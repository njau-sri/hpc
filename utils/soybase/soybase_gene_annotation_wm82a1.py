# 20191206

# pip install requests
import requests

# pip install lxml
# pip install beautifulsoup4
from bs4 import BeautifulSoup

url = "https://www.soybase.org/sbt/search/search_results.php"

payload = {"category": "FeatureName", "version": "Glyma 1.1", "search_term": "Glyma15g03040"}

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101 Firefox/70.0"}

def search_gene_annotation(name):
    payload["search_term"] = name
    r = requests.get(url, params=payload, headers=headers)
    if "Your request was not in our database." in r.text:
        print(name, "NA", "NA", "NA", sep=",")
        return
    soup = BeautifulSoup(r.text, "lxml")
    tablelist = soup.find_all("table")
    for table in tablelist:
        th = table.find("th")
        if not th or "Database ID" not in th.get_text():
            continue
        trlist = table.find_all("tr")
        for tr in trlist[1:]:
            tdlist = tr.find_all("td")
            tdtext = [e.get_text() for e in tdlist]
            ann_id, ann_type, ann_desc = tdtext[:3]
            v = ann_desc.split(".")
            ann = v[1] if len(v) > 1 else v[0]
            if "GO" in ann:
                ann = ann.split(":")[1]
            if ann_type == "AT":
                ann = ann.split("|")[0]
            if ann_type == "UniRef":
                ann = ann.split(":")[1]
            print(name, ann_type, ann_id, ann, sep=",")

genelist = []
with open("gene.txt") as f:
    for line in f:
        genelist += line.split()

for gene in genelist:
    search_gene_annotation(gene)
