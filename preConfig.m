m = 0.12;
g = 9.8;
N = 4;
b = 6.4;
a = 0.97;
c = .15;
% current = 1:0.01:1e5;
syms current
accel = current/(m*a*b^N)-g;
conv = double(vpa(solve(accel == 0, current)));

%no teste, t = 1.46s
%          y = 3.8cm