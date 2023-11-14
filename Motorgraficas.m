%Motor 17HS3430 
% Par�metros del motor
resistencia_devanado = 30; % Resistencia del devanado en ohmios
inductancia_devanado = 35; % Inductancia del devanado en henrios
inercia_rotor = 3.4; % Inercia del rotor en kg�m�
friccion = 0.01; % Coeficiente de fricci�n en N�m/(rad/s)
constante_torque = 2; % Constante de torque en N�m/A
voltaje_maximo = 12; % Voltaje m�ximo en voltios
carga = 1; % Torque de carga en N�m
 
% Rango de voltaje a considerar
voltaje = 0:0.01:voltaje_maximo; % Desde 0 hasta el voltaje m�ximo con incrementos de 0.01 V
 
% Funci�n sigmoide para modelar la relaci�n no lineal
alfa = 0.5; % Ajusta este valor seg�n la forma de la curva
beta = 2;   % Ajusta este valor para controlar la pendiente
torque = constante_torque * (1 - exp(-alfa * (voltaje - carga))) ./ (1 + exp(-alfa * (voltaje - carga)));
 
% Gr�fica de la relaci�n torque-voltaje en forma de curva
figure;
plot(voltaje, torque, 'b-', 'LineWidth', 2);
xlabel('Voltaje (V)');
ylabel('Torque (N�m)');
title('Gr�fica de Torque vs Voltaje en un Motor Paso a Paso con Curva Sigmoide');
grid on;
 
%MOTOR 17H13-0404S-PG5
% Par�metros del motor
resistencia_devanado = 27; % Resistencia del devanado en ohmios
inductancia_devanado = 0.0281; % Inductancia del devanado en henrios
inercia_rotor = 10.4; % Inercia del rotor en kg�m�
friccion = 0.01; % Coeficiente de fricci�n en N�m/(rad/s)
constante_torque = 3; % Constante de torque en N�m/A
voltaje_maximo = 12; % Voltaje m�ximo en voltios
carga = 0.5; % Torque de carga en N�m
 
% Rango de voltaje a considerar
voltaje = 0:0.01:voltaje_maximo; % Desde 0 hasta el voltaje m�ximo con incrementos de 0.01 V
 
% Funci�n sigmoide para modelar la relaci�n no lineal
alfa = 0.5; % Ajusta este valor seg�n la forma de la curva
beta = 2;   % Ajusta este valor para controlar la pendiente
torque = constante_torque * (1 - exp(-alfa * (voltaje - carga))) ./ (1 + exp(-alfa * (voltaje - carga)));
 
% Gr�fica de la relaci�n torque-voltaje en forma de curva
figure;
plot(voltaje, torque, 'b-', 'LineWidth', 2);
xlabel('Voltaje (V)');
ylabel('Torque (N�m)');
title('Gr�fica de Torque vs Voltaje en un 17HS13-0404S-PG5');
grid on;










%Motor 17HS4401
% Par�metros del motor
resistencia_devanado = 1.5; % Resistencia del devanado en ohmios
inductancia_devanado = 0.0028; % Inductancia del devanado en henrios
inercia_rotor = 5.4; % Inercia del rotor en kg�m�
friccion = 0.01; % Coeficiente de fricci�n en N�m/(rad/s)
constante_torque = 0.4; % Constante de torque en N�m/A
voltaje_maximo = 12; % Voltaje m�ximo en voltios
carga = 0.5; % Torque de carga en N�m
 
% Rango de voltaje a considerar
voltaje = 0:0.01:voltaje_maximo; % Desde 0 hasta el voltaje m�ximo con incrementos de 0.01 V
 
% Funci�n sigmoide para modelar la relaci�n no lineal
alfa = 0.5; % Ajusta este valor seg�n la forma de la curva
beta = 2;   % Ajusta este valor para controlar la pendiente
torque = constante_torque * (1 - exp(-alfa * (voltaje - carga))) ./ (1 + exp(-alfa * (voltaje - carga)));
 
% Gr�fica de la relaci�n torque-voltaje en forma de curva
figure;
plot(voltaje, torque, 'b-', 'LineWidth', 2);
xlabel('Voltaje (V)');
ylabel('Torque (N�m)');
title('Gr�fica de Torque vs Voltaje en un 17HS13-0404S-PG5');
grid on;







