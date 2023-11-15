% Crear datos experimentales (sustituye estos valores con tus datos reales)
tiempo = 1:10;
x_exp = [0,0.2 ,0.3, 0.4, 0.5, 0.45, 0.35, 0.35, 0, 0.51];
y_exp = [0,0.25 ,0.35, 0.45, 0.55, 0.25, 0.15, 0.05, 0, 0.41];
theta_exp = [0,0.15 ,0.25, 0.45, 0.05, 0.15, 0.25, 0.05, 0, 0.31];
 
% Crear datos simulados (sustituye estos valores con tus datos simulados)
x_sim = [0,0.25 ,0.35, 0.45, 0.55, 0.50, 0.45, 0.45 0, 0.61];
y_sim = [0,0.35 ,0.45, 0.55, 0.65, 0.35, 0.25, 0.15, 0, 0.51];
theta_sim = [0,0.30 ,0.45, 0.55, 0.08, 0.17, 0.27, 0.05, 0, 0.45];
 
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
title('Velocidad lineal de x: Experimental vs. Simulado');
 
% Subplot para la variable y
subplot(3, 1, 2);
plot(tiempo, y_exp, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Experimental');
hold on;
plot(tiempo, y_sim, '--o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Simulado');
xlabel('Tiempo');
ylabel('y');
legend('Location', 'Best');
title('Velocidad lineal de y: Experimental vs. Simulado');
 
% Subplot para la variable theta
subplot(3, 1, 3);
plot(tiempo, theta_exp, '-o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Experimental');
hold on;
plot(tiempo, theta_sim, '--o', 'LineWidth', 1.5, 'MarkerSize', 6, 'DisplayName', 'Simulado');
xlabel('Tiempo');
ylabel('\theta');
legend('Location', 'Best');
title('Velocidad angular: Experimental vs. Simulado');

