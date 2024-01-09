import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.widgets import Button

class MecanumRobot:
    def __init__(self):
        self.x_r = 0.0
        self.y_r = 0.0
        self.phi = 0.0
        self.u_f = 1  # Velocidad hacia adelante
        self.u_l = 1 # Velocidad lateral
        self.omega = 1  # Velocidad angular

        self.fig, self.ax = plt.subplots()
        self.ax.set_xlim([-5, 5])
        self.ax.set_ylim([-5, 5])

        self.square_points = [
            (-1, -1), (-1, 1), (1, 1), (1, -1), (-1, -1)
        ]

        self.robot_body, = self.ax.plot([], [], label='Robot móvil', color='blue')
        self.orientation_line, = self.ax.plot([], [], label='Orientación', color='blue', linewidth=2)
        self.wheel_radius = 0.2
        self.wheels = [
            self.ax.plot([], [], 'o-', label=f'Rueda {i}', color='red')[0]
            for i in range(4)
        ]

        self.path_line, = self.ax.plot([], [], '--', label='Trayectoría del Robot Móvil', color='green')
        self.ax.set_xlabel('X-axis')
        self.ax.set_ylabel('Y-axis')
        self.ax.legend()

        self.path_data = {'x': [], 'y': []}

        # Agregar botón de pausa
        self.pause = False
        self.ax_pause = plt.axes([0.81, 0.01, 0.1, 0.05])
        self.btn_pause = Button(self.ax_pause, 'Pause')
        self.btn_pause.on_clicked(self.toggle_pause)

    def toggle_pause(self, event):
        self.pause = not self.pause

    def update(self, _):
        dt = 0.1
        self.x_r += (self.u_f * np.cos(self.phi) - self.u_l * np.sin(self.phi)) * dt
        self.y_r += (self.u_f * np.sin(self.phi) + self.u_l * np.cos(self.phi)) * dt
        self.phi += self.omega * dt

        if not self.pause:
            # Imprimir los valores actuales de x_r, y_r y phi solo si no está pausado
            print(f"x_r: {self.x_r}, y_r: {self.y_r}, phi: {self.phi}")

        if self.pause:
            return [self.robot_body, self.orientation_line, *self.wheels, self.path_line]

        self.robot_body.set_data(*zip(*[(self.x_r + x, self.y_r + y) for x, y in self.square_points]))

        orientation_end_point = (self.x_r + 2 * np.cos(self.phi), self.y_r + 2 * np.sin(self.phi))
        self.orientation_line.set_data([self.x_r, orientation_end_point[0]], [self.y_r, orientation_end_point[1]])

        wheel_positions = [
            (self.x_r + x, self.y_r + y)
            for x, y in [(0.5, 0.5), (-0.5, 0.5), (-0.5, -0.5), (0.5, -0.5)]
        ]

        for wheel, position in zip(self.wheels, wheel_positions):
            wheel.set_data([position[0]], [position[1]])

        self.path_data['x'].append(self.x_r)
        self.path_data['y'].append(self.y_r)
        self.path_line.set_data(self.path_data['x'], self.path_data['y'])

        return [self.robot_body, self.orientation_line, *self.wheels, self.path_line]

    def animate(self):
        self.animation = FuncAnimation(self.fig, self.update, frames=np.arange(0, 10), interval=200, blit=True)
        plt.show()

robot = MecanumRobot()
robot.animate()
