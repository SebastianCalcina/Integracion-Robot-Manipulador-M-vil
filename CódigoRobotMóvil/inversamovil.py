import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from matplotlib.widgets import Button

class MecanumRobot:
    def __init__(self):
        self.x_r = 0.0
        self.y_r = 0.0
        self.phi = 0.0
        self.u_f = 0.0
        self.u_l = 0.0
        self.omega = 0.0

        self.fig, self.ax = plt.subplots()
        self.ax.set_xlim([-5, 5])
        self.ax.set_ylim([-5, 5])
        self.robot_body, = self.ax.plot([], [], label='Mecanum Robot Body', color='blue')
        self.orientation_line, = self.ax.plot([], [], label='Orientation', color='blue', linewidth=2)
        self.path_line, = self.ax.plot([], [], '--', label='Robot Path', color='green')
        self.ax.set_xlabel('X-axis')
        self.ax.set_ylabel('Y-axis')
        self.ax.legend()
        self.path_data = {'x': [], 'y': []}

        self.time_values = np.array([0.0])
        self.u_f_values = np.array([0.0])
        self.u_l_values = np.array([0.0])
        self.omega_values = np.array([0.0])

        self.pause = False
        self.ax_pause = plt.axes([0.81, 0.01, 0.1, 0.05])
        self.btn_pause = Button(self.ax_pause, 'Pause')
        self.btn_pause.on_clicked(self.toggle_pause)

    def toggle_pause(self, event):
        self.pause = not self.pause
        if not self.pause:
            self.animate_robot()

    def update(self, frame):
        dt = 0.05
        error_x = self.desired_x_r - self.x_r
        error_y = self.desired_y_r - self.y_r

        # Controladores proporcionales ajustados
        Kp_x = 0.5
        Kp_y = 0.5
        Kp_phi = 1.0

        x_r_dot = Kp_x * error_x
        y_r_dot = Kp_y * error_y

        error_phi = self.desired_phi - self.phi
        phi_dot = Kp_phi * error_phi

        self.u_f = x_r_dot * np.cos(self.phi) + y_r_dot * np.sin(self.phi)
        self.u_l = -x_r_dot * np.sin(self.phi) + y_r_dot * np.cos(self.phi)
        self.omega = phi_dot

        self.u_f = min(1.0, max(-1.0, self.u_f))
        self.u_l = min(1.0, max(-1.0, self.u_l))

        self.x_r += (self.u_f * np.cos(self.phi) - self.u_l * np.sin(self.phi)) * dt
        self.y_r += (self.u_f * np.sin(self.phi) + self.u_l * np.cos(self.phi)) * dt
        self.phi += self.omega * dt

        self.time_values = np.append(self.time_values, frame * dt)
        self.u_f_values = np.append(self.u_f_values, self.u_f)
        self.u_l_values = np.append(self.u_l_values, self.u_l)
        self.omega_values = np.append(self.omega_values, self.omega)

        x_coords, y_coords = zip(*[(self.x_r + x, self.y_r + y) for x, y in [(-1, -1), (-1, 1), (1, 1), (1, -1), (-1, -1)]])
        self.robot_body.set_data(x_coords, y_coords)
        self.orientation_line.set_data([self.x_r, self.x_r + np.cos(self.phi)], [self.y_r, self.y_r + np.sin(self.phi)])
        self.path_data['x'].append(self.x_r)
        self.path_data['y'].append(self.y_r)
        self.path_line.set_data(self.path_data['x'], self.path_data['y'])

        return [self.robot_body, self.orientation_line, self.path_line]

    def plot_velocities(self):
        plt.figure(figsize=(14, 10))

        time_end = len(self.time_values) * 0.05
        time_values = np.linspace(0, time_end, len(self.time_values))

        plt.subplot(1, 3, 1)
        plt.plot(time_values, self.u_f_values, label='u_f', color='b')
        plt.title('Variación de u_f en el Tiempo')
        plt.xlabel('Tiempo (s)')
        plt.ylabel('u_f')
        plt.grid(True)

        plt.subplot(1, 3, 2)
        plt.plot(time_values, self.u_l_values, label='u_l', color='r')
        plt.title('Variación de u_l en el Tiempo')
        plt.xlabel('Tiempo (s)')
        plt.ylabel('u_l')
        plt.grid(True)

        plt.subplot(1, 3, 3)
        plt.plot(time_values, self.omega_values, label='omega', color='g')
        plt.title('Variación de omega en el Tiempo')
        plt.xlabel('Tiempo (s)')
        plt.ylabel('omega')
        plt.grid(True)

        plt.tight_layout()
        plt.show()

    def animate_robot(self):
        self.animation = FuncAnimation(self.fig, self.update, frames=np.arange(0, 200), interval=70, blit=True)

    def animate(self, desired_x_r, desired_y_r, desired_phi):
        self.desired_x_r = desired_x_r
        self.desired_y_r = desired_y_r
        self.desired_phi = desired_phi
        self.animate_robot()
        plt.show()

robot = MecanumRobot()
robot.animate(1, 1, 1)
robot.plot_velocities()
