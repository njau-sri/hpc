function hello()

% show matlab version
disp(version)

% timing matrix multiplication
tic
n = 1000;
a = rand(n);
b = rand(n);
c = rand(n);
for i = 1 : 100
    c = a * b;
end
toc
