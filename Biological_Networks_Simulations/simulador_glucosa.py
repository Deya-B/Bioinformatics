import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt
import matplotlib


def simular_glucosa(div_factor):

    '''
    Simula la respuesta a 3 comidas dependiendo de la sensibilidad a insulina.
    Calcula también la adaptación de células beta a un cambio de sensibilidad.

    Args: 
        - div_factor --> Número por el cuál se divide la sensibilidad basal a insulina.
        Si es > 1 la sensibilidad baja por un factor div_factor. Si es < 1 aumentará por div_factor.

    Prints:
        Gráficas y datos sobre la adaptación de las células beta a la nueva sensibilidad
        Gráficas de simulación con 3 comidas en 24h con distinta sensibilidad, con y sin adaptación

    Returns: None 

    '''

    ### --- PARÁMETROS Y FUNCIONES --- ###

    # --- Parámetros ---
    u0 = 0.0333  # input basal
    C = 0.001
    Si = 0.0005
    p = 0.03
    alpha = 7.85
    gamma = 0.3
    mu_plus = 0.000014583
    mu_minus = 0.000017361

    # --- Condiciones iniciales ---
    G0 = 5.4
    I0 = 10.34
    B0 = 322
    x0 = [G0, I0, B0]

    # Tiempo de simulación para calcular punto de adaptación de células beta
    t_adapt = np.linspace(0, 15000 * 60, 50000) 

    # tiempo de simulación para 24h (post-adaptación)
    t_meals = np.linspace(0, 24 * 60, 10000)  # minutos en 24h

    # --- Función para simular ingestas cada 4 horas  ---
    def u_comidas(t):
        comidas = [4*60, 8*60, 12*60]  # minutos
        u_extra = 0
        for meal_time in comidas:
            if meal_time <= t <= meal_time + 30:
                u_extra += 0.1
        return u0 + u_extra

    # --- Ecuaciones para adaptación con sensibilidad normal ---
    def sistema(x, t):
        G, I, B = x
        u = u0
        dGdt = u - (C + Si  * I) * G
        dIdt = p * B * (1 / (1 + (alpha / G) ** 2)) - gamma * I
        dBdt = B * (mu_plus * (1 / (1 + (8.4 / G) ** 1.7)) - mu_minus * 
                    (1 / (1 + (G / 4.8) ** 8.5)))
        return [dGdt, dIdt, dBdt]

    # --- Ecuaciones para adaptación con sensibilidad modificada ---
    def sistema_mod(x, t):
        G, I, B = x
        u = u0
        dGdt = u - (C + (Si / div_factor) * I) * G
        dIdt = p * B * (1 / (1 + (alpha / G) ** 2)) - gamma * I
        dBdt = B * (mu_plus * (1 / (1 + (8.4 / G) ** 1.7)) - mu_minus * 
                    (1 / (1 + (G / 4.8) ** 8.5)))
        return [dGdt, dIdt, dBdt]

    # --- Ecuaciones para 24h con sensibilidad normal ---
    def sistema_24h(x, t):
        G, I, B = x
        u = u_comidas(t)
        dGdt = u - (C + Si * I) * G
        dIdt = p * B * (1 / (1 + (alpha / G) ** 2)) - gamma * I
        dBdt = B * (mu_plus * (1 / (1 + (8.4 / G) ** 1.7)) - mu_minus * (1 / (G / 4.8) ** 8.5))
        return [dGdt, dIdt, dBdt]

    # --- Ecuaciones para 24h con sensibilidad modificada ---
    def sistema_24h_mod(x, t):
        G, I, B = x
        u = u_comidas(t)
        dGdt = u - (C + (Si / div_factor) * I) * G
        dIdt = p * B * (1 / (1 + (alpha / G) ** 2)) - gamma * I
        dBdt = B * (mu_plus * (1 / (1 + (8.4 / G) ** 1.7)) - mu_minus * (1 / (G / 4.8) ** 8.5))
        return [dGdt, dIdt, dBdt]

    # --- Variables para ejes de las gráficas ---

    # Define los tiempos reales en horas donde quieres los ticks
    ticks_horas = [0, 4, 8, 12, 16, 20, 24]  # en "horas" del array `horas`

    # Etiquetas de texto como si fueran horas de reloj
    tick_labels = ["06", "10", "14", "18", "22", "02", "06"]

    horas = t_meals / 60 




    ### --- ADAPTACIÓN --- ###




    # Simulación larga para ver adaptación de masa funcional de células beta

    sol_estabilización = odeint(sistema_mod, x0, t_adapt)
    G, I, B = sol_estabilización.T


    # --- Detectar estabilización ---


    # Derivada discreta de B (diferencias finitas)
    dBdt_approx = np.abs(np.gradient(B, t_adapt))

    # Establecer umbral relativo para estabilización
    threshold = 1e-5  # cambia según tolerancia

    # Ventana de estabilidad (p.ej., estabilidad mantenida durante 1 hora = 60 min)
    window = int(60 / (t_adapt[1] - t_adapt[0]))  # número de puntos para 60 min

    # Encuentra el primer punto donde dBdt_approx se mantiene por debajo del umbral
    for i in range(len(dBdt_approx) - window):
        if np.all(dBdt_approx[i:i+window] < threshold):
            idx_stabilized = i
            break
    else:
        idx_stabilized = -1  # Si no se encuentra estabilización

    # Resultado
    t_stabilized = t_adapt[idx_stabilized] / 60  # en horas
    B_stabilized = B[idx_stabilized]
    I_stabilized = I[idx_stabilized]

    print(f'La masa funcional de células beta tras adaptación es de {round(B_stabilized, 
                                                                           None)}.')
    print(f'La concentración de insulina es de {round(I_stabilized, 2)} µU/mL.')
    print(f'El tiempo de adaptación ha sido aproximadamente de {round(t_stabilized/720, 
                                                                      None)} meses.')
    
    # --- Graficar ---


    plt.figure(1, figsize=(10, 7))

    plt.plot(t_adapt / 43200, B, label="Células beta", lw = 2)

    plt.axvline(t_stabilized/720, color='r', linestyle='--', label="Estabilización",
                lw = 2)

    plt.xlabel("Tiempo (meses)", fontsize=16)
    plt.ylabel("Masa funcional de células beta", fontsize=16)

    plt.legend(fontsize=14)
    plt.xticks(fontsize=12)
    plt.yticks(fontsize=12)

    plt.title(f'Adaptación de la masa funcional de células beta con Si/{div_factor}', 
            fontsize=18)
    plt.grid()
    plt.show()

    




    ### --- SIMULACIONES 24H CON 3 COMIDAS --- ###




    # Valores iniciales con el valor de masa de células beta adaptado (calculado antes)
    x0_mod = [G0, I0, B_stabilized]

    # Simulación 24h con sensibilidad normal
    sol_normal = odeint(sistema_24h, x0, t_meals)
    G_normal, I_normal, B_normal = sol_normal.T

    # Simulación 24h post-adaptación con sensibilidad modificada
    sol_mod = odeint(sistema_24h_mod, x0_mod, t_meals)
    G_mod, I_mod, B_mod = sol_mod.T

    # Simulación 24h sin adaptación células beta
    sol_descompensado = odeint(sistema_24h_mod, x0, t_meals)
    G_descompensada, I_descompensada, B_descompensada = sol_descompensado.T


    # --- Graficar --- #


    plt.close('all')
    # Crear una figura y un conjunto de subgráficas (2 filas, 2 columnas)
    fig, ((ax2, ax3, ax4)) = plt.subplots(3, 1, figsize=(10, 7*3))

    # Primer gráfico: Respuesta glucémica post-adaptación con 3 comidas
    ax2.plot(horas, G_normal, label="Si", color="black", alpha=1, linestyle="-", lw=7)
    ax2.plot(horas, G_mod, label=f'Si/{div_factor}', color='grey', alpha=1, linestyle="--", lw=7)
    ax2.plot(horas, G_descompensada, label=f'Si/{div_factor} sin adaptación', color='red', 
             alpha=0.6, linestyle="-.", lw=2)
    ax2.set_xlabel("Tiempo (horas del día)", fontsize=16)
    ax2.set_ylabel("Glucosa (mM)", fontsize=16)
    ax2.set_xticks(ticks_horas)
    ax2.set_xticklabels(tick_labels, fontsize=12)
    ax2.tick_params(axis='y', labelsize=12)
    ax2.set_title("Respuesta glucémica post-adaptación", fontsize=20)
    ax2.legend(fontsize=14)
    ax2.grid(False)

    # Segundo gráfico: Dinámica de la insulina a lo largo del día
    ax3.plot(horas, I_normal, label="Si", color="black", alpha=1, linestyle="-", lw=7)
    ax3.plot(horas, I_mod, label=f'Si/{div_factor}', color='grey', alpha=1, linestyle="--", lw=7)
    ax3.plot(horas, I_descompensada, label=f'Si/{div_factor} sin adaptación', color='red', 
             alpha=0.6, linestyle="-.", lw=2)
    ax3.set_xlabel("Tiempo (horas del día)", fontsize=16)
    ax3.set_ylabel("Insulina (µU/ml)", fontsize=16)
    ax3.set_xticks(ticks_horas)
    ax3.set_xticklabels(tick_labels, fontsize=12)
    ax3.tick_params(axis='y', labelsize=12)
    ax3.set_title("Dinámica de la insulina", fontsize=20)
    ax3.legend(fontsize=14)
    ax3.grid(False)

    # Trecer gráfico: Dinámica de la insulina normalizada
    ax4.plot(horas, I_normal / I0, label="Si", color="black", alpha=1, linestyle="-", lw=7)
    ax4.plot(horas, I_mod / I_stabilized, label=f'Si/{div_factor}', color='grey', alpha=1, 
             linestyle="--", lw=7)
    ax4.plot(horas, I_descompensada / I0, label=f'Si/{div_factor} sin adaptación', color='red', 
             alpha=0.6, linestyle="-.", lw=2)
    ax4.set_xlabel("Tiempo (horas del día)", fontsize=16)
    ax4.set_ylabel("Insulina/basal", fontsize=16)
    ax4.set_xticks(ticks_horas)
    ax4.set_xticklabels(tick_labels, fontsize=12)
    ax4.tick_params(axis='y', labelsize=12)
    ax4.set_title("Dinámica de la insulina normalizada", fontsize=20)
    ax4.set_ylim(0.00, )
    ax4.legend(fontsize=14)
    ax4.grid(False)

    # Ajustar el layout para que no se superpongan las etiquetas
    plt.tight_layout()

    # Mostrar todos los gráficos
    plt.show()