% Simulacion de una micro-red
% Por Jaime Alexander Gamboa

% Define el vector fila de tiempo continuo de 1 a 24 horas.
t = 1:24;

% Generacion Solar
% asigna en memoria un vector fila de 24 ceros para almacenar la potencia solar.
P_solar = zeros(1,24);

% Bucle iterativo 'for' que recorre secuencialmente las 24 horas del día.
for i = 1:24
    % Condicional lógico que limita la radiación solar al intervalo entre las 6:00 am y las 6:00pm.
    if i >= 6 && i <= 18
        % Función sinusoidal que modela la potencia solar, alcanzando un pico de 25 kW al mediodía.
        P_solar(i) = 25 * sin(pi * (i-6) / 12);
    end % Cierre de la estructura condicional de radiación solar.
end % Cierre del bucle de iteración diaria solar.

% Generacion Eolica
% simulacion de energia generada por el viento de forma aleatoria durante las 24 horasgarantizando que la potencia este siempre en el rango 3 kW y 15 kW.
P_eolica = 3 + 12 * rand(1,24);

% Generacion Total
% Suma vectorial de las cadapoencias solar y eolica.
P_total = P_solar + P_eolica;

% Demanda De La Comunidad
% asignacion en memoria del vector fila de potencia consumida para las 24 horas.
P_demanda = zeros(1,24);

% Bucle iterativo para simular el comportamiento del consumo eléctrico hora por hora.
for i = 1:24
    % Condicional para el intervalo nocturno/madrugada.
    if (i >= 1 && i <= 5) || (i >= 22 && i <= 24)
        % Asignación de consumo bajo aleatorio con valores distribuidos entre 2 kW y 4 kW.
        P_demanda(i) = 2 + 2 * rand();
        % Condicional para el horario diurno/laboral entre las 6:00am y las 5:00pm.
    elseif i >= 6 && i <= 17
        % Asignación de consumo intermedio aleatorio con valores entre 6 kW y 10 kW.
        P_demanda(i) = 6 + 4 * rand();
        % Condicional para la franja de consumo pico (18:00 a 21:00 h).
    elseif i >= 18 && i <= 21
        % Asignación de carga constante de alta demanda de 15 kW.
        P_demanda(i) = 15;
    end % Cierre de la estructura condicional de consumo.
end % Cierre del bucle de demanda eléctrica.

% Visualizacion Grafica De Datos.
% Inicializa y crea una nueva ventana gráfica de salida.
figure

% Grafica la curva de Generación Total en función del tiempo con trazo continuo azul.
plot(t,P_total,'b')

% Retiene el lienzo gráfico activo para superponer múltiples curvas en la misma figura.
hold on

% Grafica la curva de Demanda en función del tiempo con trazo continuo rojo.
plot(t,P_demanda,'r')

% Ajuste de Ejes
ylim([0 50])       % Eje Y de 0 a 50 kW
xlim([0 25])       % Eje X de 0 a 25 horas
xticks(0:3:24)     % Intervalos de 3 en 3 en el eje X

% Asigna el título descriptivo del análisis energético a la figura.
title('Comportamiento Energetico De La Micro-Red')

% Etiqueta el eje horizontal X indicando la magnitud de tiempo en horas.
xlabel('Tiempo en horas')

% Etiqueta el eje vertical Y especificando la unidad de medida de potencia en Kilovatios.
ylabel('Potencia en Kilovatios (kW)')

% Inserta la leyenda explicativa para identificar la serie de generación y la de demanda.
legend('Generacion Total','Demanda del pueblo')

% Activa la malla/cuadrícula de fondo para facilitar la lectura de puntos de intersección.
grid on

% Libera el lienzo gráfico para finalizar el proceso de superposición de curvas.
hold off
