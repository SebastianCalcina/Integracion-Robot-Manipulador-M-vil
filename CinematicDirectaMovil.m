%limpiar variables
clear all;close all;clc
%medidas del Robot
d1=1.2;
d2=0.60;
r=0.09; %radio
L=0.17;%distancia de ubicación del Laser
%tiempo de muestreo
ts=.1 ; tfin=20; %500
t=[0:ts:tfin];
%POSICION INICIAL DEL ROBOT
x(1)=0; %posicion inicial robot en X
y(1)=0; %posicion inicial robot en Y
th(1)=0; %rotacion inicial robot en th
%Inicio
for k=1:length(t)
% inicia medición de tiempo
tic
%velocidades de referencia
if k<100
 vf(k)=0.5; %en m/s
 vl(k)=-0.35; %en m/s
 w(k)=0.5; %en rad/s
else
 vf(k)=-0.5; %en m/s
 vl(k)=-0.45; %en m/s
 w(k)=-0.4; %en rad/s
end
% calcular velocidades para las ruedas
V_ref=[vf(k) vl(k) w(k)]';
%Matriz de transformación de velocidades lineales a velocidades
%angulares
%independientes
T_inv=[[1/r -1/r -(d1+d2)/r];...
 [1/r 1/r -(d1+d2)/r];...
 [1/r -1/r (d1+d2)/r];...
 [1/r 1/r (d1+d2)/r]];
%transformación de velocidades lineales a angulares
W_rf=T_inv*V_ref;
%separo las velocidades angulares para cada llanta
w1(k)=W_rf(1);
w2(k)=W_rf(2);
w3(k)=W_rf(3);
w4(k)=W_rf(4);
%calculo la velocidad del robot en el punto de interés en base a la
%cinemática
xp(k) = vf(k)*cos(th(k))-vl(k)*sin(th(k)) -L*w(k)*sin(th(k));
yp(k) = vf(k)*sin(th(k))+vl(k)*cos(th(k))-L*w(k)*cos(th(k));
% calculo la nueva posición del robot en base a la euler
x(k+1) = x(k)+(ts)*xp(k);
y(k+1) = y(k)+(ts)*yp(k);
th(k+1) = th(k)+w(k)*(ts);
end
%fin del programa
disp("fin")
%%Graficar las variables y el movimiento ejecutado por el robot
paso=70; fig=figure;
set(fig,'position',[100 60 980 600]);
axis equal; cameratoolbar
%definiciones ejes para la grafica
view(25,88)
axis([-2 2 -2.5 2.5 0 0.5]);grid on, hold on
%% graficar la evolucion de la posicion
figure
subplot(3,1,1);
plot(x);
legend('Evolucion posicion x')
xlabel('Tiempo [s]'), ylabel('[m]'),grid on
subplot(3,1,2)
plot(y,'r');
legend('Evolucion posicion y')
xlabel('Tiempo [s]'), ylabel('[m]'),grid on
subplot(3,1,3)
plot(th);
legend('Evolucion rotacion \phi')
xlabel('Tiempo [s]'), ylabel('[rad]'),grid on
%% graficar los valores de velocidades enviadas vs recibidas
figure
subplot(4,1,1);
plot(w1,'b'); hold on;
legend('w_1')
xlabel('Tiempo [s]'), ylabel('[rad/s]'),grid on
subplot(4,1,2);
plot(w2,'r'); hold on;
legend('w_2')
xlabel('Tiempo [s]'), ylabel('[rad/s]'),grid on
subplot(4,1,3);
plot(w3,'g'); hold on;
legend('w_3')
xlabel('Tiempo [s]'), ylabel('[rad/s]'),grid on
subplot(4,1,4);
plot(w4,'k'); hold on;
legend('w_4')
xlabel('Tiempo [s]'), ylabel('[rad/s]'),grid on 
