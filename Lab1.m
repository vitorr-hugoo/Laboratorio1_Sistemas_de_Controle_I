clear;
clc;

%  carrega o pacote da função transferencia
pkg load control
pkg load symbolic

%            1           5 (amplitude)
% Il2= --------------- *
%      2*s^2 + 6*s + 2

s = tf('s');
syms s t;    %define variaveis simbolicas

%função
G=5/(2*s^2 + 6*s + 2);
num = [1];       % Coeficientes do numerador
den = [2, 6, 2]; % Coeficientes do denominador
G2 = tf(num, den); %função criada para analise das frações parciais

%vetor tempo
t=0:0.1:20;

%expansão em frações parciais
[r,p,k] = residue(num,den); %

%printa a função
disp('  R =');
disp(r);
disp('--------------------------------------------------------------');
disp('  P =');
disp(p);
disp('--------------------------------------------------------------');
disp('  K =');
disp(k);
disp('--------------------------------------------------------------');

%transformada laplace inversa
g = ilaplace(G);
disp('Transformada de laplace inversa: ');
disp(g);
disp('--------------------------------------------------------------');

%da a resposta a função transferencia ao degrau unitario
%figure;
%step(G2,t);
%xlabel('TEMPO');
%ylabel('Saída');
%title('RESPOSTA AO DEGRAU UNITARIO');

% resposta ao impulso
figure;
impulse(G2);
xlabel('TEMPO');
ylabel('Saída');
title('RESPOSTA AO IMPULSO UNITÁRIO:');

%resposta a entrada da rampa com coeficiente angular 10
figure;
r=ramp(G2,t,10);
y1= lsim(G2, r, t);
plot(t, r);
xlabel('TEMPO');
ylabel('Saída');
title('RESPOSTA A RAMPA:');

%resposta a entrada r(t)=2*e^-0.5t
figure;
h = 2*exp(-0.5*t);
[y2,t] = lsim(G2, h, t);
plot(t,y2);
xlabel('TEMPO');
ylabel('Saída');
title('RESPOSTA A ENTRADA r(t)=2*e^-0.5t:');

%resposta a parabola unitaria t^2
figure;
pu = t.^2; % Parábola unitária: r(t) = t^2
[z,t]=lsim(G2,pu,t);
plot(t, z);
xlabel('Tempo (s)');
ylabel('r(t)');
title('Parábola Unitária');

