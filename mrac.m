% variaveis simbolicas
syms s r;
syms xi wn;
syms a b c;
syms kp kd ki;

% valores de constantes
gammaKp = 1;
gammaKd = 1;
gammaKi = 1;
a_exp = 1;
b_exp = 1;
c_exp = 1;  

% requisitos desejados
ts = 1;
mn = 1;
xi_exp = 1;
wn_exp = 1;

% funcao de transferencia da planta
%G(s) = 0.004813/(s^2 + 1.25 *s + 6.031);
G = a/(s^2 + b*s + c);

% funcao de transferencia da planta desejada
G_m = 1/(s^2 + 2*wn*xi*s + wn^2);

% funcao de transferencia do sistema com controlador
G_c = (kp + ki/s)/(1/G + kp + ki/s + s*kd);

% erro de adaptação
y_p     = G_c * r;
e       = r - y_p;
epsilon = y_p - G_m*r;

% obtendo derivadas com respeito a kp, ki, kd
de_dkp = diff(epsilon, kp);
de_dki = diff(epsilon, ki);
de_dkd = diff(epsilon, kd);

% aplicando na regra do mit (dTheta/dt = dJ/dTheta)
dkp_dt = - gammaKp * epsilon * de_dkp;
dki_dt = - gammaKi * epsilon * de_dki;  
dkd_dt = - gammaKd * epsilon * de_dkd;