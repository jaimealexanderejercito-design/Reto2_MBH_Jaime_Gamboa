%scrip para el desarrollo de una micro-red
% Por Jaime Alexander Gamboa
% Simulacion De Generacion Electrica Y Demanda En 24 Horas
% vector  tiempo de 24 horas
t= 1:24;

% Inicializamos el vector solar con ceros de 1x24
P_solar = zeros(1, 24);

% Simulamos la curva solar diurna (horas 6 a 18)
for i = 1:24
if i >= 6 && i <= 18
% Usamos una función seno para lograr una curva suave que llega a 25 kW en la hora 12
P_solar(i) = 25 * sin(pi * (i - 6) / 12);
end
end

% Fijamos una semilla opcional para que los valores aleatorios sean reproducibles
rng(42); 

% Generamos valores aleatorios entre 3 y 14 kW para simular la fluctuación del viento
P_eolica = 3 + 11 * rand(1, 24);

% Suma matemática de la generación solar y eolica
P_total = P_solar + P_eolica;

% Inicializamos el vector de demanda
P_demanda = zeros(1, 24);

for i = 1:24
if (i >= 1 && i <= 5) || (i >= 22 && i <= 24)
% Consumo nocturno base (entre 2 y 4 kW)
P_demanda(i) = 2 + 2 * rand();
elseif i >= 6 && i <= 17
% Consumo diurno moderado (entre 6 y 10 kW)
P_demanda(i) = 6 + 4 * rand();
elseif i >= 18 && i <= 21
% Pico máximo de demanda (15 kW exactos)
P_demanda(i) = 15;
end
end
% Creamos la ventana de la gráfica
figure;

% Graficamos la Generación Total en color azul con línea gruesa
plot(t, P_total, 'LineWidth', 2, 'Color', 'b');
hold on; % Mantiene la gráfica actual para superponer la siguiente

% Graficamos la Demanda en color rojo con línea gruesa
plot(t, P_demanda, 'LineWidth', 2, 'Color', 'r');

% Añadimos elementos estéticos y etiquetas requeridas
grid on;
title('Comportamiento Energético de la Micro-red');
xlabel('Tiempo en horas');
ylabel('Potencia en Kilovatios (kW)');
legend('Generación Total', 'Demanda de la Comunidad', 'Location', 'northwest');

hold off; % Liberamos la figura