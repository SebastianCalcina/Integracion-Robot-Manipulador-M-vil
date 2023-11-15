% Crear datos experimentales (sustituye estos valores con tus datos reales)
tiempo = 1:10;
x_exp = [0, 1, 1.6, 1.3, 1, 0.5, 0, -0.5, -1.5, 0];
y_exp = [0, 0.5, 1, 1.2, 1.5, 1, 0.5, 0, -0.5, -1];
theta_exp = [0, 0.2, 0.25, 0.5, 0, 0.5, 1, 1.5, 0.5, 1];
 
% Crear datos simulados (sustituye estos valores con tus datos simulados)
x_sim = [0, 0.9, 1.4, 1, 0.5, 0, 0, -0.5, -1, 0];
y_sim = [0, 0.45, 0.9, 1.5, 0.5, 1, 0.5, 0, 0.5, -0.5];
theta_sim = [0, 0.11, 0.22, 0.4, 0, 0.55, 1, 1.5, 0.8, 1.2];
 
% Crear la figura con subplots
figure;
 
% Subplot para la variable x
subplot(3, 1, 1);
plot(tiempo, x_exp, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Experimental');
hold on;
plot(tiempo, x_sim, '--o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Simulado');
xlabel('Tiempo');
ylabel('x');
legend('Location', 'Best');
title('Comparación de x: Experimental vs. Simulado');
 
% Subplot para la variable y
subplot(3, 1, 2);
plot(tiempo, y_exp, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Experimental');
hold on;
plot(tiempo, y_sim, '--o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Simulado');
xlabel('Tiempo');
ylabel('y');
legend('Location', 'Best');
title('Comparación de y: Experimental vs. Simulado');
 
% Subplot para la variable theta
subplot(3, 1, 3);
plot(tiempo, theta_exp, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Experimental');
hold on;
plot(tiempo, theta_sim, '--o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Simulado');
xlabel('Tiempo');
ylabel('\theta');
legend('Location', 'Best');
title('Comparación de \theta: Experimental vs. Simulado');
