% sim_cm_sat.m
% This file simulates a single coil magnetic circuit with core saturation.
%
% Copyright Alberto Sanchez 2021
%  ver 1.0 28/01/2021
%
% Modify by Alex Andrade
%  ver 2.0 04/02/2021
%******************************************************************
% Model Description:
% 
% State Variables: Psi
% Parameters: wb r xl xm
%
%******************************************************************
% This Simulations is for a 120/240 V, 1.5 KVA, 60-Hz transformer
% with the following parameters:
%
% r = 0.25 Ohms
% xl = 0.056 Ohms
% xm = 47.5 Ohms
%
%*****************************************************************
% Any change to be performed at this point of the code
%*****************************************************************
%
% Voltaje devanado primario
%

V1 = sqrt(2)*120;       % Voltaje pico
V1f = 0;                 % Desfasamiento de voltaje V1. Altere este valor segun lo requerido 0 o pi/2

%
%*****************************************************************
% DO NOT MAKE ANY CHANGES BELOW THIS POINT
%*****************************************************************
%
cm_init;
%
%
% Simulacion
%
disp('');
disp('Espere unos instantes.....simulacion en progreso')
tic;
sim('cm_sat_model',1);
toc
disp('');
disp('Simulacion finalizada')
i = salida(:,1);
e = salida(:,2);
psi = salida(:,3);
psim = salida(:,4);
v = salida(:,5);
%
% Resultados
%
figure;
title('Circuito Magnético con Saturacion - Magnitudes Eléctricas');
subplot(2,1,1);
plot(T,v);
hold on
plot(T,e);
ylabel('volts');
legend('Vs','fem');
grid on;
subplot(2,1,2);
plot(T,i);
ylabel('i [A]');
xlabel('Tiempo [s]');
grid on;

figure;
title('Circuito Magnético con Saturacion - Concatenación de Flujo');
subplot(2,1,1);
plot(T,psi);
ylabel('\Psi [Wb/s]');
grid on;
subplot(2,1,2);
plot(T,psim);
ylabel('\Psi_{m} [Wb/s]');
xlabel('Tiempo [s]');
grid on;

figure;
title('Circuito Magnético con Saturacion - Concatenación de Flujo');
plot(psisat,Dpsi);
xlabel('\Psi_{m}^{sat} [Wb/s]');
ylabel('\Delta \Psi [Wb/s]');
grid on;
