"""calculate important parameters for window delay stage"""

import numpy as np


w = 3e-3   # window length, in m
n1 = 1.  # refractive index of air
n2 = 1.45  # refractive index of window material


def calculate(alpha, w=w, n1=n1, n2=n2):
    refracted_angle = np.arcsin(n1 * np.sin(alpha) / n2)
    beta = alpha - np.arcsin(n1 * np.sin(alpha) / n2)
    B1 = w / np.cos(refracted_angle)  # length of travel through glass (including refraction)
    B2 = B1 * np.sin(beta) * np.tan(alpha) # length of travel after glass to meet with wavefront of path C
    C = w / np.cos(alpha)  # path length through glass without refraction
    path_difference = 2 * (n2 * B1 + n1 * B2 - n1 * C)
    return dict(
        refracted_angle = refracted_angle,
        beta = beta,
        B1 = B1,
        B2 = B2,
        C = C,
        path_difference = path_difference,
    )


if __name__ == "__main__":
    alpha = np.linspace(0, 70, 90)
    calculations = [a for a in map(calculate, alpha * np.pi / 180)]
    opt_delay = np.array([a["path_difference"]/3e8 for a in calculations])
    no_refraction = lambda a: 2 * (n2-n1) *a["C"]
    approx_delay = np.array([x/3e8 for x in map(no_refraction, calculations)])

    import matplotlib.pyplot as plt
    fig, (ax1, ax2) = plt.subplots(nrows=2, sharex=True)
    ax1.plot(alpha, opt_delay *1e12)
    ax1.plot(alpha, approx_delay * 1e12)

    ax2.plot(alpha, np.array([2 * a["B1"]*1e3 for a in calculations]))

    ax1.set_ylabel("optical delay (ps)")
    ax2.set_ylabel("window_travel length (mm)")
    ax2.set_xlabel("incidence angle (deg)")
    ax1.set_title(f"w={w*1e3} mm, n={n2}")
    # ax1.set_ylim(0, 10)
    ax1.set_xlim(0, 70)
    [ax.grid() for ax in fig.axes]
    plt.show()



