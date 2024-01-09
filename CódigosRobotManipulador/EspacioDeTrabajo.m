clc;
clear all;

% Definición de parámetros
d1 = 0.202;
d6 = 0.067;

% Definición del robot mediante parámetros D-H
L1 = Revolute('a', 0, 'alpha', pi/2, 'd', d1);
L2 = Revolute('a', 0.160, 'alpha', 0, 'd', 0);
L3 = Revolute('a', 0, 'alpha', pi/2, 'd', 0);
L4 = Revolute('a', 0, 'alpha', -pi/2, 'd', 0.195);
L5 = Revolute('a', 0, 'alpha', pi/2, 'd', 0);
L6 = Revolute('a', 0, 'alpha', 0, 'd', d6);
bot = SerialLink([L1, L2, L3, L4, L5, L6]);
bot.name = 'Thor'; % Cambiando el nombre del robot a "Thor"
% Definición de límites articulares
limits = {
    [-180 180], % Joint1
    [-90 90],  % Joint2
    [-135 135],  % Joint3
    [-180 180], % Joint4
    [-90 90], % Joint5
    [-180 180]  % Joint6
};

th1 = linspace(deg2rad(limits{1}(1)), deg2rad(limits{1}(2)), 8);
th2 = linspace(deg2rad(limits{2}(1)), deg2rad(limits{2}(2)), 8);
th3 = linspace(deg2rad(limits{3}(1)), deg2rad(limits{3}(2)), 8);
th4 = linspace(deg2rad(limits{4}(1)), deg2rad(limits{4}(2)), 8);
th5 = linspace(deg2rad(limits{5}(1)), deg2rad(limits{5}(2)), 8);
th6 = linspace(deg2rad(limits{6}(1)), deg2rad(limits{6}(2)), 8);

q = {th1, th2, th3, th4, th5, th6};

bot.display();
bot.teach();
hold on;

[~, n] = size(bot.links);

var = sym('q', [n 1]);
assume(var, 'real');

% Generación de una cuadrícula de valores theta
[Q{1:numel(q)}] = ndgrid(q{:}); 
T = simplify(vpa(bot.fkine(var), 3));
Pos = T.tv;

x(var(:)) = Pos(1);
X = matlabFunction(x);
X = X(Q{:});

y(var(:)) = Pos(2);
Y = matlabFunction(y);
Y = Y(Q{:});

z(var(:)) = Pos(3);
Z = matlabFunction(z);
Z = Z(Q{:});

% Visualización del espacio de trabajo con ajustes
scatter3(X(:), Y(:), Z(:), 5, 'r', 'filled', 'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3); % Ajustando la transparencia
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Espacio de trabajo del robot');
hold off;
