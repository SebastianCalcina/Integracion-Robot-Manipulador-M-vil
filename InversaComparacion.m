% Vector de tiempo (en segundos)
tiempo = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
 
% Matriz de �ngulos simulados
angulos_simulados = [0, 40.5, -47.5, 42.5, 46.1, 2.9, 2.5, 2.5, 2.5, 2.5, 2.5, 6.1, 2.5, 2.5, 2.5, -8.3, -13, -13, -15.5, -15.5];
 
% Matriz de �ngulos reales
angulos_reales = [0, 38.7, -49.5, 44.5, 47.5, 2, 2.7, 2.7, 2.7, 2.7, 2.6, 5.3, 2.6, 2.6, 2.6, -8.4, -12, -12, -16, -16];
 
% Crear la gr�fica de los �ngulos en funci�n del tiempo
figure;
 
% Gr�fica de �ngulos simulados (l�nea punteada)
plot(tiempo, angulos_simulados, '--ro', 'LineWidth', 1, 'MarkerSize', 5);
hold on;
 
% Gr�fica de �ngulos reales (l�nea s�lida)
plot(tiempo, angulos_reales, '-k', 'LineWidth', 0.5, 'MarkerSize', 1);
 
% Etiquetas de ejes y t�tulo
xlabel('Tiempo (min)', 'FontSize', 14);
ylabel('�ngulo (grados)', 'FontSize', 14);
title('Comparaci�n de �ngulos Simulados y Reales en funci�n del Tiempo', 'FontSize', 14);
 
legend('Simulado', 'Real');
 
% Cuadr�cula
grid on;


