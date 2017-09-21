m = 0.12;
g = 9.8;
N = 4;
b = 6.28;
a = 1;
% current = 1:0.01:1e5;
% syms current
% accel = current/(m*a*b^N)-g;
% conv = double(vpa(solve(accel == 0, current)));

%no teste, t = 1.46s
%          y = 3.8cm
% 
% Counts = [24 20 15 10 5 2]*1e3;
% 
% Mp = [94.22 90.4 83.5 70.9 57.5 45]*1e-2;
% 
% tr = [329 338 354 387 435 496]*1e-3;

% Requisitos do projeto

tr = 0.02;

Mp = 0.20;

% xi e omega_n a partir dos requisitos

xi = abs(log(Mp))/sqrt(pi^2+(log(Mp)^2))

wn = (pi - acos(xi))/(tr*sqrt(1 - xi^2))

% Função de transferência modelo

k = 1;
am1 = 2*xi*wn;
am0 = wn^2;
den = tf(k, [1 am1 am0]);
Gm = k*den;