% Definición de la estructura del robot
robot.radio_rueda = 1.95;  % Radio de las ruedas en metros
robot.distancia_entre_ruedas = 1.2;  % Distancia entre las ruedas en metros
robot.x_actual = 0;  % Posición actual en el eje x en metros
robot.y_actual = 0;  % Posición actual en el eje y en metros
robot.theta_actual = 0;  % Orientación actual en radianes
 
% Posición y orientación deseada
x_deseada = 1.0;  % Posición deseada en el eje x en metros
y_deseada = 1.0;  % Posición deseada en el eje y en metros
theta_deseada = 0.5;  % Orientación deseada en radianes
 
% Cálculo de las velocidades lineales y angulares utilizando la cinemática inversa
[v_x, v_y, w] = cinematica_inversa_omnidireccional(robot, x_deseada, y_deseada, theta_deseada);
 
% Visualización de las velocidades resultantes
disp(['Velocidad lineal en x: ', num2str(v_x), ' m/s']);
disp(['Velocidad lineal en y: ', num2str(v_y), ' m/s']);
disp(['Velocidad angular: ', num2str(w), ' rad/s']);
 
% Gráfica de la trayectoria deseada y real
figure;
plot([robot.x_actual, x_deseada], [robot.y_actual, y_deseada], 'r--', 'LineWidth', 2);
hold on;
plot(robot.x_actual, robot.y_actual, 'go', 'MarkerSize', 10);
plot(x_deseada, y_deseada, 'bx', 'MarkerSize', 10);
legend('Trayectoria Deseada', 'Posición Actual', 'Posición Deseada');
xlabel('Posición en X (m)');
ylabel('Posición en Y (m)');
title('Trayectoria del Robot Móvil');
grid on;
axis equal;
 
% Función de cinemática inversa omnidireccional
function [v_x, v_y, w] = cinematica_inversa_omnidireccional(robot, x_deseada, y_deseada, theta_deseada)
    % Parámetros del robot
    radio_rueda = robot.radio_rueda;
    distancia_entre_ruedas = robot.distancia_entre_ruedas;
 
    % Posición y orientación actual
    x_actual = robot.x_actual;
    y_actual = robot.y_actual;
    theta_actual = robot.theta_actual;
 
    % Cálculo de las diferencias
    delta_x = x_deseada - x_actual;
    delta_y = y_deseada - y_actual;
 
    % Transformación de coordenadas
    x_trans = cos(theta_actual) * delta_x + sin(theta_actual) * delta_y;
    y_trans = -sin(theta_actual) * delta_x + cos(theta_actual) * delta_y;
 
    % Cálculo de las velocidades lineales y angulares
    v_x = x_trans;
    v_y = y_trans;
    w = theta_deseada - theta_actual;
end

