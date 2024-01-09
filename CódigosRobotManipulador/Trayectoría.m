clc;
clear all;

% Definici�n de par�metros
d1 = 0.202;
d6 = 0.067;

% Definici�n del robot mediante par�metros D-H
L1 = Revolute('a', 0, 'alpha', pi/2, 'd', d1);
L2 = Revolute('a', 0.160, 'alpha', 0, 'd', 0);
L3 = Revolute('a', 0, 'alpha', pi/2, 'd', 0);
L4 = Revolute('a', 0, 'alpha', -pi/2, 'd', 0.195);
L5 = Revolute('a', 0, 'alpha', pi/2, 'd', 0);
L6 = Revolute('a', 0, 'alpha', 0, 'd', d6);
bot = SerialLink([L1, L2, L3, L4, L5, L6]);
bot.name = 'thor'; % Cambiando el nombre del robot a "thor"

% Definici�n de puntos de inicio y fin para la trayectoria
q0 = [0, 0, 0, 0, 0, 0];   % Configuraci�n inicial (todos los �ngulos en 0)
qf = [pi, pi/2, pi/8, 0, pi/4,20*pi/180]; % Configuraci�n final (todos los �ngulos en pi/4)

% Definici�n del tiempo de la trayectoria
t = linspace(0, 1, 50);  % 50 puntos en el tiempo

% Generar trayectoria
[q, ~, ~] = jtraj(q0, qf, t);

% Ventana para visualizaci�n 3D del robot con los 6 joints y trayectoria
figure;

% Graficar el movimiento de cada joint en un solo gr�fico
for i = 1:6
    plot(t, q(:, i));
    hold on; % Mantener la visualizaci�n actual para agregar la siguiente l�nea
end
title('Movimiento de los Joints a lo largo del tiempo');
xlabel('Tiempo');
ylabel('�ngulo (rad)');
legend('Joint 1', 'Joint 2', 'Joint 3', 'Joint 4', 'Joint 5', 'Joint 6');
grid on;

% Ventana para visualizaci�n 3D del robot y trayectoria
figure;

% Graficar el robot y mostrar las coordenadas XYZ
for j = 1:length(t)
    bot.plot(q(j, :));
    position = bot.fkine(q(j, :)).t; % Posici�n del extremo
    fprintf('Iteraci�n %d - Coordenadas XYZ: %.4f, %.4f, %.4f\n', j, position(1), position(2), position(3));
    if j == 1
        hold on;
    end
end

% Extraer la posici�n del extremo del robot de cada configuraci�n q
positions = zeros(length(t), 3);
for j = 1:length(t)
    position = bot.fkine(q(j, :)).t; % Posici�n del extremo
    positions(j, :) = position(1:3);  % Extraer x, y, z
end

% Conectar puntos para visualizar la trayectoria
plot3(positions(:, 1), positions(:, 2), positions(:, 3), 'r', 'LineWidth', 2);

title('Trayectoria a lo largo del tiempo del brazo manipulador');
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
hold off;
