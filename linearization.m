clc; clear all;
% Definindo a função com variáveis simbólicas
syms a b c y yd ydd u N m g;

f_mag = u/(m*a*(y+b)^N);

ydd = f_mag - g - c*yd/m;

% Descobrindo o valor de controle para o estado estacionário, considerando
% a altura final desejada como 1.5cm

y_ss = 1.5;

yd_ss = 0;

u_ss = solve(subs(ydd, [y, yd], [y_ss, yd_ss])==0, u);

% Linearizando em torno do ponto de operação no estado estacionário

part_ydd_y = subs(diff(ydd, y), [y, yd, u], [y_ss, yd_ss, u_ss]); 

part_ydd_u = subs(diff(ydd, u), [y, yd, u], [y_ss, yd_ss, u_ss]);

part_ydd_yd = subs(diff(ydd, yd), [y, yd, u], [y_ss, yd_ss, u_ss]);

y_lin = part_ydd_y*y + part_ydd_u*u + part_ydd_yd*yd;

y_lin = vpa(subs(y_lin, [a b c N m g], [0.97 6.4 0.15 4 0.12 9.8]));

% Definindo a função de transferência com os valores encontrados
% anteriormente

num = [double(subs(y_lin, [y yd u], [0 0 1]))];

a = -subs(y_lin, [y yd u], [0 1 0]);

b = -subs(y_lin, [y yd u], [1 0 0]);

den = [1 double(a) double(b)];

G = tf(num, den)