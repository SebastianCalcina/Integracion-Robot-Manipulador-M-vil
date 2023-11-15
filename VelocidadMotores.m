% Vector de tiempo (en segundos)
tiempo = [0, 1, 2, 3, 4, 5, 6, 7];
 
% Matriz de velocidades (cada fila representa una velocidad)
velocidades = [
    0, 500, 500, 500, 500,500,500, 0;
    0, 400, 400, 400, 400,400,400, 0;
    0, 450, 450, 450, 450,450,450, 0;
    0, 480, 480, 480, 480,480,480, 0;
    0, 1000, 1000, 1000, 1000,1000, 1000, 0;
    0, 300, 300, 300, 300,300,300, 0;
    0, 350, 350, 350, 350,350,350, 0
];
 
% Crear la gráfica de las velocidades en función del tiempo
figure;
 
% Colores suaves en formato RGB
colores = [
    [0.6, 0.6, 1];   % Azul suave
    [0.6, 1, 0.6];   % Verde suave
    [1, 0.6, 0.6];   % Rojo suave
    [0.7, 0.7, 0.7]; % Gris suave
    [0.8, 0.8, 0.2]; % Amarillo suave
    [1, 0.6, 1];     % Magenta suave
    [0.2, 0.8, 0.8]  % Cian suave
];
 
for i = 1:size(velocidades, 1)
    plot(tiempo, velocidades(i, :), '-o', 'LineWidth', 2, 'MarkerSize', 8, 'Color', colores(i, :));
    hold on;
end
 
% Etiquetas de ejes y título
xlabel('Tiempo (min)', 'FontSize', 14);
ylabel('Velocidad (mm/min)', 'FontSize', 14);
title('Cambio de Velocidad en función del Tiempo', 'FontSize', 16);
 
% Leyenda
leyenda = cell(1, size(velocidades, 1));
for i = 1:size(velocidades, 1)
    leyenda{i} = sprintf('Velocidad %d', i);
end
legend(leyenda, 'FontSize', 12, 'Location', 'Best');
 
% Cuadrícula
grid on;



