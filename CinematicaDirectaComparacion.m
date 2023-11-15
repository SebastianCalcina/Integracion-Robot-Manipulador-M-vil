% Nueva serie de datos para Coordenada X real (por ejemplo, en milímetros)
coordenadaX_real = [0.5, 0.33, 0.28, 0.31, 0.29, 0.43, 0.324, 0.41,0.40,0.41,0.42,0.41,0.41,0.343,0.248,0.217,0.215,0.20,0.20,0.22];
% Datos de coordenada X simulada
tiempo = [0, 1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];  % Tiempo (segundos)
% Coordenada X simulada (por ejemplo, en milímetros)
coordenadaX_simulada = [0.41, 0.321, 0.275, 0.304, 0.286, 0.408, 0.327, 0.414, 0.414, 0.412, 0.409,0.407, 0.409, 0.34, 0.248, 0.215, 0.212, 0.194, 0.191, 0.219];
% Crear la gráfica comparativa
figure;
plot(tiempo, coordenadaX_real, '-o', 'DisplayName', 'X Real (Medido)', 'Color', [0, 0.5, 0]);  % Línea sólida verde para X real
hold on;
plot(tiempo, coordenadaX_simulada, '--s', 'DisplayName', 'X Simulada (Simulado)', 'Color', [0.9, 0.2, 0]);  % Línea punteada naranja para X simulada
 
xlabel('Tiempo (minutos)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje X
ylabel('Coordenada X (mm)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje Y
title('Comparación de X Real y X Simulada respecto al Tiempo', 'FontSize', 10);  % Cambiar el tamaño de la fuente del título
%legend('FontSize', 12, 'Location', 'Best', 'Orientation', 'horizontal');  % Ubicar la leyenda en la parte superior de la gráfica
legend('X Real','X Simulada')
grid on;

% Nueva serie de datos para Coordenada X real (por ejemplo, en milímetros)
coordenadaY_real = [-0.006, 0.30, -0.32, 0.28, 0.28, 0.025, 0.020, 0.017, 0.017, 0.017, 0.017,0.04, 0.02, 0.015, 0.010, -0.035, -0.048, -0.054, -0.0554, -0.060];
% Datos de coordenada X simulada
tiempo = [0, 1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];  % Tiempo (segundos)
% Coordenada X simulada (por ejemplo, en milímetros)
coordenadaY_simulada = [-0.003, 0.255, -0.304, 0.275, 0.293, 0.018, 0.013, 0.016, 0.016, 0.016, 0.016,0.042, 0.016, 0.013, 0.009, -0.033, -0.047, -0.055, -0.055, -0.061];
% Crear la gráfica comparativa
figure;
plot(tiempo, coordenadaY_real, '-o', 'DisplayName', 'Y Real (Medido)', 'Color', [0, 0.5, 0]);  % Línea sólida verde para X real
hold on;
plot(tiempo, coordenadaY_simulada, '--s', 'DisplayName', 'Y Simulada (Simulado)', 'Color', [0.9, 0.2, 0]);  % Línea punteada naranja para X simulada
 
xlabel('Tiempo (minutos)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje X
ylabel('Coordenada y (m)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje Y
title('Comparación de Y Real y Y Simulada respecto al Tiempo', 'FontSize', 10);  % Cambiar el tamaño de la fuente del título
%legend('FontSize', 12, 'Location', 'Best', 'Orientation', 'horizontal');  % Ubicar la leyenda en la parte superior de la gráfica
legend('Y Real','Y Simulada')
grid on;

% Nueva serie de datos para Coordenada X real (por ejemplo, en milímetros)
coordenadaZ_real = [0.255, 0.255, 0.255, 0.255, 0.255, 0.265, -0.02, 0.195, 0.216, 0.244, 0.269,0.253, 0.272, 0.430, 0.498, 0.502, 0.502, 0.513, 0.513, 0.512];
% Datos de coordenada X simulada
tiempo = [0, 1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];  % Tiempo (segundos)
% Coordenada X simulada (por ejemplo, en milímetros)
coordenadaZ_simulada = [0.252, 0.252, 0.252, 0.252, 0.252, 0.263, -0.052, 0.189, 0.215, 0.241, 0.267,0.25, 0.267, 0.428, 0.491, 0.501, 0.501, 0.514, 0.514, 0.512];
% Crear la gráfica comparativa
figure;
plot(tiempo, coordenadaZ_real, '-o', 'DisplayName', 'Y Real (Medido)', 'Color', [0, 0.5, 0]);  % Línea sólida verde para X real
hold on;
plot(tiempo, coordenadaZ_simulada, '--s', 'DisplayName', 'Y Simulada (Simulado)', 'Color', [0.9, 0.2, 0]);  % Línea punteada naranja para X simulada
 
xlabel('Tiempo (minutos)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje X
ylabel('Coordenada z (m)', 'FontSize', 12);  % Cambiar el tamaño de la fuente del eje Y
title('Comparación de Z Real y Z Simulada respecto al Tiempo', 'FontSize', 10);  % Cambiar el tamaño de la fuente del título
%legend('FontSize', 12, 'Location', 'Best', 'Orientation', 'horizontal');  % Ubicar la leyenda en la parte superior de la gráfica
legend('Z Real','Z Simulada')
grid on;
