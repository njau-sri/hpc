import argparse
import numpy as np
import xpclr
import os
import logging

LOGFORMAT = '%(asctime)s : %(levelname)s : %(message)s'

def main():
    # Argument parsing
    psr = argparse.ArgumentParser(
        description='Tool to calculate XP-CLR as per Chen, Patterson, Reich 2010')

    # files:
    psr.add_argument('--out', "-O", required=True, help='output file')

    psr.add_argument('--format', "-F", required=False, default="vcf",
                     help='input expected. One of "vcf" (default), "hdf5", "zarr" or "txt"')

    # data inputs for hdf5/VCF format:
    psr.add_argument('--input', '-I', required=False, help='input file vcf or hdf5',
                     default=None, action='store')

    psr.add_argument('--gdistkey', required=False, default=None, type=str,
                     help='key for genetic position in variants table of hdf5/VCF')

    psr.add_argument('--samplesA', '-Sa', action='store', default=None,
                     dest='samplesA', required=False,
                     help='Samples comprising population A. Comma separated list or path to file with each ID on a line')

    psr.add_argument('--samplesB', '-Sb', action='store', default=None,
                     dest='samplesB', required=False,
                     help='Samples comprising population B. Comma separated list or path to file with each ID on a line')

    # only used when input is hdf5 or VCF
    psr.add_argument('--rrate', '-R', dest='rrate', action='store',
                     default=1e-8, help='recombination rate per base', type=float)

    # data inputs for text format
    psr.add_argument('--map', required=False, default=None, action='store',
                     help='input map file as per XPCLR specs')

    psr.add_argument('--popA', required=False, default=None, action='store',
                     help='filepath to population A genotypes')

    psr.add_argument('--popB', required=False, default=None, action='store',
                     help='filepath to population A genotypes')

    # parameters
    # chrom
    psr.add_argument('--chr', '-C', required=True, dest='chrom', action='store',
                     help='Which contig analysis is based on')

    psr.add_argument('--ld', '-L', dest='ldcutoff', action='store',
                     default=0.95, help='LD cutoff to apply for weighting', type=float)

    psr.add_argument('--phased', '-P', dest='phased', action='store_true',
                     help='whether data is phased for more precise r2 calculation')

    psr.add_argument('--verbose', '-V', dest='verbose', action='store', default=20, type=int,
                     help='How verbose to be in logging. 10=DEBUG, 20=INFO, 30=WARN, 40=ERROR, 50=CRITICAL')

    psr.add_argument('--maxsnps', '-M', dest='maxsnps', action='store',
                     default=200, help='max SNPs in a window', type=int)
    psr.add_argument('--minsnps', '-N', dest='minsnps', action='store',
                     default=10, help='min SNPs in a window', type=int)

    psr.add_argument('--size', dest='size', action='store',
                     default=20000, help='window size in base pairs', type=int)
    psr.add_argument('--start', dest='start', action='store', type=int,
                     default=1, help='start base position for windows')
    psr.add_argument('--stop', dest='stop', action='store', default=None, type=int,
                     help='stop base position for windows')
    psr.add_argument('--step', dest='step', action='store', default=20000, type=int,
                     help='step size for sliding windows')

    args = psr.parse_args()

    logging.basicConfig(format=LOGFORMAT, level=args.verbose, datefmt="%Y-%m-%d %H:%M:%S")

    fn = args.out
    outdir = os.path.dirname(fn)

    assert os.access(outdir, os.W_OK), \
        "No permission to write in the specified directory: {0}".format(outdir)

    logging.info("running xpclr v{0}".format(xpclr.__version__))
    chromosome = args.chrom

    # if mode is "hdf5"
    if args.format == 'vcf':

        logging.info("Loading VCF")
        g1, g2, positions, genetic_dist = xpclr.util.load_vcf_format_data(
            args.input.strip(),
            chromosome,
            args.samplesA,
            args.samplesB,
            gdistkey=args.gdistkey)
        logging.info("VCF loading complete")

    elif args.format == 'hdf5':

        logging.info("Loading HDF5")
        g1, g2, positions, genetic_dist = xpclr.util.load_hdf5_data(
            args.input.strip(),
            chromosome,
            args.samplesA,
            args.samplesB,
            gdistkey=args.gdistkey)
        logging.info("HDF5 loading complete")

    elif args.format == 'zarr':

        logging.info("Loading zarr")
        g1, g2, positions, genetic_dist = xpclr.util.load_zarr_data(
            args.input.strip(),
            chromosome,
            args.samplesA,
            args.samplesB,
            gdistkey=args.gdistkey)
        logging.info("zarr loading complete")

    elif args.format == 'txt':
        # else if mode is text
        logging.info("Loading TXT")
        g1, g2, positions, genetic_dist = xpclr.util.load_text_format_data(
            args.map,
            args.popA,
            args.popB)
        logging.info("TXT loading complete")
    else:
        raise ValueError("Format must be one of vcf/hdf5/txt")

    ac1 = g1.count_alleles()
    ac2 = g2.count_alleles()

    logging.info("{0:,} SNPs in total are in the provided input files".format(g1.shape[0]))

    multiallelic = (ac1[:, 2:].sum(1) > 0) | (ac2[:, 2:].sum(1) > 0)
    logging.info("{0:,} SNPs excluded as multiallelic".format(multiallelic.sum()))

    # all missing in either
    missing = (np.array(ac1.sum(1)) == 0) | (np.array(ac2.sum(1)) == 0)
    logging.info(
        "{0:,} SNPs excluded as missing in all samples in a population".format(np.sum(missing & ~multiallelic)))

    # drop if fixed in AC2,
    fixed_p2 = ac2.is_non_segregating()[:] | ac2.is_singleton(0)[:] | ac2.is_singleton(1)[:]

    logging.info(
        "{0:,} SNPs excluded as invariant or singleton in population 2".format(
            np.sum(fixed_p2 & ~missing & ~multiallelic)))

    # now compress all!
    include = (~multiallelic & ~fixed_p2 & ~missing)
    logging.info(
        "{0:,}/{1:,} SNPs included in the analysis ({2:.2f}%)".format(
            include.sum(), g1.shape[0], 100*include.sum()/g1.shape[0]))

    g1 = g1.compress(include, axis=0)
    g2 = g2.compress(include, axis=0)
    positions = np.compress(include, positions, axis=0)
    if genetic_dist is not None:
        genetic_dist = np.compress(include, genetic_dist, axis=0)
    logging.info("Done dropping above SNPs from analysis. XP-CLR algorithm starting.")

    # check everything is as expected.
    assert g1.shape[0] == g2.shape[0] == positions.shape[0]

    # determine windows
    if args.stop is None:
        args.stop = positions[-1]
    spacing = np.arange(args.start, args.stop, args.step)
    scan_windows = np.vstack([spacing, spacing - 1 + args.size]).T

    # main function
    model_lik, null_lik, selcoef, nsnps, navail, snpedges = xpclr.methods.xpclr_scan(
        g1, g2, positions, scan_windows, geneticd=genetic_dist,
        ldcutoff=args.ldcutoff, phased=args.phased,
        maxsnps=args.maxsnps, minsnps=args.minsnps,
        rrate=args.rrate)

    df = xpclr.util.tabulate_results(
        chromosome, model_lik, null_lik, selcoef, nsnps, navail, scan_windows, snpedges)

    df.to_csv(fn, sep="\t", index=False)
    logging.info("Analysis complete. Output file {0}".format(fn))


if __name__ == '__main__':
    main()
