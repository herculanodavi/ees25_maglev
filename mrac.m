% variaveis simbolicas
syms s r;
syms a b c;
syms kp kd ki;

% valores de constantes
gammaKp = 1;
gammaKd = 1;
gammaKi = 1;
a_exp = 1;
b_exp = 1;
c_exp = 1;

% funcao de transferencia da planta
%G(s) = 0.004813/(s^2 + 1.25 *s + 6.031);
G(s, a, b, c) = a/(s^2 + b*s + c);

% funcao de transferencia do sistema com controlador
G_c(s, kp, ki, kd, a, b, c) = (kp + ki/s)/(1/G(s, a, b, c) + kp + ki/s + s*kd);

% erro de adaptação
y_p(r, s, kp, ki, kd, a, b, c) = G_c(s, kp, ki, kd, a, b, c) * r;
e(r, s, kp, ki, kd, a, b, c) = r - y_p(r, s, kp, ki, kd, a, b, c);
epsilon(r, s, kp, ki, kd, a, b, c) = G_c(s, kp, ki, kd, a, b, c)*r - G(s, a, b, c)*r;

% obtendo derivadas com respeito a kp, ki, kd
de_dkp(r, s, kp, ki, kd, a, b, c) = diff(epsilon(r, s, kp, ki, kd, a, b, c), kp);
de_dki(r, s, kp, ki, kd, a, b, c) = diff(epsilon(r, s, kp, ki, kd, a, b, c), ki);
de_dkd(r, s, kp, ki, kd, a, b, c) = diff(epsilon(r, s, kp, ki, kd, a, b, c), kd);

% aplicando na regra do mit (dTheta/dt = dJ/dTheta)
dkp_dt = - gammaKp * epsilon(r, s, kp, ki, kd, a, b, c) * de_dkp(r, s, kp, ki, kd, a, b, c);
dkd_dt = - gammaKd * epsilon(r, s, kp, ki, kd, a, b, c) * de_dkd(r, s, kp, ki, kd, a, b, c);
dki_dt = - gammaKi * epsilon(r, s, kp, ki, kd, a, b, c) * de_dki(r, s, kp, ki, kd, a, b, c);