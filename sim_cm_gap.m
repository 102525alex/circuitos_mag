% Simtrans1.m
% This file simulates a magnetic circuit with predominant air-gap (no saturation considered)
%
% Copyright Alberto Sanchez 2021
%
%  ver 1.0 27/01/2021
%
% Modify by Alex Andrade
%  ver 2.0 04/02/2021
%
%******************************************************************
% Model Description:
% 
% State Variables: Psi
% Parameters: wb r xl xm
%******************************************************************
% This Simulations is for a 120 V, 60-Hz magnetic circuit
% with the following parameters:
%
% r = 0.62 Ohms   Resistencia de bobinado
% xl = 0.056 Ohms  Reactancia de dispersión
% xm = 47.5 Ohms  reactancia de magnetización
%
%*****************************************************************

% Any change to be performed at this point of the code
V1 = sqrt(2)*120;
fase = 0;
F = 60;
wb = 2*pi*F;

r = 0.62;
xl = 0.056;
xm = 47.5;


% do not change below this point
XINIT = [0];
PAR = [wb r xl xm];
tic;
disp('Un momento por favor...')
sim('cm_gap_model',0.5);
disp('Simulacion finalizada');
toc
i = salida(:,1);
psi = salida(:,2);
e = salida(:,3);
v = salida(:,4);

subplot(4,1,1);
plot(T,i);
title('Circuito Magnético con Entre-Hierro Predominante');
ylabel('i [A]');
grid on;
subplot(4,1,2);
plot(T,psi);
ylabel('\Psi [Wb/s]')
xlabel('Tiempo [s]')
grid on;
subplot(4,1,3);
plot(T,v);
hold on;
plot(T,e);
legend('v_s','fem');
ylabel('[volts]');
xlabel('Tiempo [s]');
grid on;
subplot(4,1,4);
plot(T,v.*i);
ylabel('p [watts]')
xlabel('Tiempo [s]')
grid on;

