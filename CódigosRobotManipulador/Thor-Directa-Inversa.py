import numpy as np
from numpy import cos, sin, pi
from sympy import atan2, asin, acos, deg
import matplotlib.pyplot as plt
from matplotlib.patheffects import withStroke
from matplotlib.ticker import FormatStrFormatter
from mpl_toolkits.mplot3d import Axes3D
import sympy as sp

# Lista de parámetros DH (Denavit-Hartenberg)
DOF = 6
q1, q2, q3, q4, q5, q6 = sp.symbols('q1 q2 q3 q4 q5 q6')

spi = sp.pi

DH_params = []
DH_params.append([20.2, q1, 0, sp.pi/2])
DH_params.append([0, q2, 16, 0])
DH_params.append([0, q3, 0, sp.pi/2])
DH_params.append([19.5, q4, 0, -sp.pi/2])
DH_params.append([0, q5, 0, sp.pi/2])
DH_params.append([6.75, q6, 0, 0])
DH_params.append([1, 0, 0, 0])

def DH_trans_matrix(params):
    d, theta, a, alpha = (params[0], params[1], params[2], params[3])
    mat = sp.Matrix([[sp.cos(theta), -1*sp.sin(theta)*sp.cos(alpha), sp.sin(theta)*sp.sin(alpha), a*sp.cos(theta)],
                    [sp.sin(theta), sp.cos(theta)*sp.cos(alpha), -1*sp.cos(theta)*sp.sin(alpha), a*sp.sin(theta)],
                    [0, sp.sin(alpha), sp.cos(alpha), d],
                    [0, 0, 0, 1]])
    return mat

def joint_transforms(DH_params):
    transforms = []
    transforms.append(sp.eye(4))

    for el in DH_params:
        transforms.append(DH_trans_matrix(el))
    return transforms

# To get the jacobain we can use the cross product method since we have all of the transformations
# Get the total transformation to the end effector
# This function gives the symbolic expression for the jacobian
def jacobian_expr(DH_params):
    transforms = joint_transforms(DH_params)
    trans_EF = transforms[0]

    for mat in transforms[1:]:
        trans_EF = trans_EF * mat
    pos_EF = trans_EF[0:3,3]

    J = sp.zeros(6, DOF)
    for joint in range(DOF):
        trans_joint = transforms[0]
        for mat in transforms[1:joint+1]:
            trans_joint = trans_joint*mat

        z_axis = trans_joint[0:3,2]
        pos_joint = trans_joint[0:3,3]
        Jv = z_axis.cross(pos_EF - pos_joint)
        Jw = z_axis

        J[0:3,joint] = Jv
        J[3:6,joint] = Jw

    J = sp.simplify(J)
    return J

# This function evaluates a symbolic jacobian expression using provided joint angles
def jacobian_subs(joints, jacobian_sym):  
    # Convert to list if it's an ndarray
    if (isinstance(joints, np.ndarray)):
        joints = joints.flatten().tolist()
    
    J_l = jacobian_sym 
    J_l = J_l.subs(q1, joints[0])
    J_l = J_l.subs(q2, joints[1])
    J_l = J_l.subs(q3, joints[2])
    J_l = J_l.subs(q4, joints[3])
    J_l = J_l.subs(q5, joints[4])
    J_l = J_l.subs(q6, joints[5])
    return J_l

# Verify the two previous functions

# If you're trying to implement the jacobian, you can just take the symbolic jacobian that's printed and hard
# code that into your model

jacobian_symbolic = jacobian_expr(DH_params)
jacobian_symbolic

def trans_EF_eval(joints, DH_params):
    if isinstance(joints, np.ndarray):
        joints = joints.flatten().tolist()
    
    transforms = joint_transforms(DH_params)

    trans_EF = transforms[0]

    for mat in transforms[1:]:
        trans_EF = trans_EF * mat
    
    trans_EF_cur = trans_EF
    
    for i in range(DOF):
        trans_EF_cur = trans_EF_cur.subs(f'q{i+1}', joints[i])
    
    return trans_EF_cur

def plot_pose(joints, DH_params):
    if isinstance(joints, np.ndarray):
        joints = joints.flatten().tolist()

    xs, ys, zs = [], [], []

    # Crear la figura y el objeto de los ejes
    fig = plt.figure(figsize=(8,8))
    ax = fig.add_subplot(111, projection='3d')

    transforms = joint_transforms(DH_params)

    trans_EF = trans_EF_eval(joints, DH_params)
    pos_EF = trans_EF[0:3, 3]

    # Convertir joints a grados antes de mostrarlos
    joints_degrees = [joint * 180 / pi for joint in joints]

    for joint in range(DOF):
        trans_joint = transforms[0]

        for mat in transforms[1:joint+1]:
            trans_joint = trans_joint * mat

        pos_joint = trans_joint[0:3, 3]

        for i in range(DOF):
            pos_joint = pos_joint.subs(f'q{i+1}', joints[i])

        xs.append(pos_joint[0])
        ys.append(pos_joint[1])
        zs.append(pos_joint[2])

        # Marcadores de joints con etiquetas
        for i, (x, y, z) in enumerate(zip(xs, ys, zs)):
            if i < len(joints):
                align  = 'right' if i % 2 == 0 else 'left'
                align2 = 'bottom' if i % 2 == 0 else 'top'
                ax.scatter(pos_joint[0], pos_joint[1], pos_joint[2], color='blue', marker='o')
                ax.text(x, y, z, f'Art.{i + 1}= {joints_degrees[i]:.2f}°', fontsize=10, color='blue', ha=align, va=align2,weight="bold")
  
    xs.append(pos_EF[0])
    ys.append(pos_EF[1])
    zs.append(pos_EF[2])

    ax.set_xlim3d(-60,60)
    ax.set_ylim3d(-60,60)
    ax.set_zlim3d(0, 50)

    ax.set_xlabel('Eje X')
    ax.set_ylabel('Eje Y')
    ax.set_zlabel('Eje Z')

    # Etiquetas de posición del efector final
    ax.plot(xs, ys, zs, label='Articulaciones', color='blue', linewidth=2, linestyle='-',marker='o',markersize=8)
    ax.scatter(pos_EF[0], pos_EF[1], pos_EF[2], c='red', marker='o', label='Efector Final')

    label_offset=10
    ax.text(pos_EF[0], pos_EF[1], pos_EF[2]+label_offset, f'X, Y, Z : ({pos_EF[0]:.2f}, {pos_EF[1]:.2f}, {pos_EF[2]:.2f})', 
            fontsize=10, color='red', va="top",ha="center", weight="bold")

    ax.legend(fontsize='large', loc='upper left', facecolor='lightgray')
    ax.grid(True, linestyle='--', linewidth=0.5, color='gray')
    title_text = ax.set_title('Robot Manipulator THOR', fontsize=16, color='red')
    title_text.set_path_effects([withStroke(linewidth=3, foreground='black')])
    ax.xaxis.set_major_formatter(FormatStrFormatter('%.0f'))
    ax.yaxis.set_major_formatter(FormatStrFormatter('%.0f'))
    ax.zaxis.set_major_formatter(FormatStrFormatter('%.0f'))

    plt.show()

# Para probar el mecanismo de graficación del robot
joints = [180*pi/180, 90*pi/180, 22.5*pi/180, 0, 45*pi/180, 20*pi/180]
# Define las articulaciones en grados
#joints_en_grados = np.array([20.0, 30.0, 79.0, 40.0, 30.0, 20.0])

# Convierte las articulaciones a radianes
#joints_en_radianes = np.radians(joints_en_grados)

#joints = joints_en_radianes
plot_pose(joints, DH_params)
print("Posición del Efector Final:", trans_EF_eval(joints, DH_params)[0:3, 3])
print("Orientación del Efector Final:", trans_EF_eval(joints, DH_params)[0:3, 0:3])
print("Angulos iniciales",joints)
# This takes the current joints and saturates them to the joint limits if they're out of bounds

def joint_limits(joints):
            
    # Joint 1
    if (joints[0] < -pi):
        joints[0] = -pi
        
    elif (joints[0] > pi):
        joints[0] = pi
        
    
    # Joint 2
    if (joints[1] < -pi/2):
        joints[1] = -pi/2
        
    elif (joints[1] > pi/2):
        joints[1] = pi/2
        
    # Joint 3
    if (joints[2] < -135*pi/180):
        joints[2] = -135*pi/180
        
    elif (joints[2] > 135*pi/180):
        joints[2] = 135*pi/180
        
    # Joint 4
    if (joints[3] < -pi):
        joints[3] = -pi
        
    elif (joints[3] > pi):
        joints[3] = pi
            
    # return joints

    # Joint 5
    if (joints[4] < -pi/2):
        joints[4] = -pi/2
        
    elif (joints[4] > pi/2):
        joints[4] = pi/2
        
    # Joint 6
    if (joints[5] < -pi):
        joints[5] = -pi
        
    elif (joints[5] >pi):
        joints[5] = pi
            
    return joints

# joints_init is the current joint values for the robot
# target is the desired transformation matrix at the end effector
# set no_rotation to true if you only care about end effector position, not rotation
# set joint_lims to false if you want to allow the robot to ignore joint limits
# This is currently super slow since it's using all symbolic math
def i_kine(joints_init, target, DH_params, error_trace=False, no_rotation=False, joint_lims=True):
    
    joints = joints_init
    xr_desired = target[0:3,0:3]
    xt_desired = target[0:3,3]
    x_dot_prev = np.array([0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
    e_trace = []
    iters = 0
    
    print("Finding symbolic jacobian")
    
    # We only do this once since it's computationally heavy
    jacobian_symbolic = jacobian_expr(DH_params)
    
    print("Starting IK loop")
    
    final_xt = 0
    
    while(1):
        
        jac = jacobian_subs(joints, jacobian_symbolic)
        jac = np.array(jac).astype(np.float64)
        trans_EF_cur = trans_EF_eval(joints, DH_params)
        trans_EF_cur = np.array(trans_EF_cur).astype(np.float64)
        xr_cur = trans_EF_cur[0:3,0:3]
        xt_cur = trans_EF_cur[0:3,3]
        final_xt = xt_cur
        xt_dot = xt_desired - xt_cur
        
        # Find error rotation matrix
        R = xr_desired @ xr_cur.T
        
        # convert to desired angular velocity
        v = np.arccos((R[0,0] + R[1,1] + R[2,2] - 1)/2)
        r = (0.5 * sin(v)) * np.array([[R[2,1]-R[1,2]],
                                       [R[0,2]-R[2,0]],
                                       [R[1,0]-R[0,1]]])
        
        # The large constant just tells us how much to prioritize rotation
        xr_dot = 200 * r * sin(v)
        
        # use this if you only care about end effector position and not rotation
        if (no_rotation):    
            xr_dot = 0 * r
        
        xt_dot = xt_dot.reshape((3,1))
        x_dot = np.vstack((xt_dot, xr_dot))
        x_dot_norm = np.linalg.norm(x_dot)
        
        if (x_dot_norm > 25):    
            x_dot /= (x_dot_norm/25)
            
        x_dot_change = np.linalg.norm(x_dot - x_dot_prev)
                    
        # This loop now exits if the change in the desired movement stops changing
        # This is useful for moving close to unreachable points
        if (x_dot_change < 0.005):
            break
            
        x_dot_prev = x_dot
        e_trace.append(x_dot_norm)
        Lambda = 12
        Alpha = 1
                        
        joint_change = Alpha * np.linalg.inv(jac.T@jac + Lambda**2*np.eye(DOF)) @ jac.T @ x_dot
        joints += joint_change
        
        if (joint_lims): joints = joint_limits(joints)
    
        iters += 1
                
    print("Done in {} iterations".format(iters))
    print("Final position is:")
    print(final_xt)
    print("Ángulos finales de articulación-Inicial:")
    print(joints)
    
    return (joints, e_trace) if error_trace else joints

# PRUEBA CON INFORMACION DE LA DIRECTA
# Obtener la matriz de transformación homogénea del efector final
matriz_transformacion = trans_EF_eval(joints, DH_params)

# Extraer la posición del efector final
pos_efector_final = matriz_transformacion[0:3, 3]
x_deseado, y_deseado, z_deseado = pos_efector_final

# Extraer la orientación del efector final
orientacion_efector_final = matriz_transformacion[0:3, 0:3]
nueva_rx, nueva_ry, nueva_rz = orientacion_efector_final[0, 0], orientacion_efector_final[1, 1], orientacion_efector_final[2, 2]

# Definir una nueva posición y orientación deseada
#nueva_posicion = np.array([x_deseado, y_deseado, z_deseado])
nueva_posicion = np.array([26.84, 4.73, 36.20])

nueva_orientacion = np.array([[nueva_rx, 0, 0],
                              [0, nueva_ry, 0],
                              [0, 0, nueva_rz]])

# Crear la nueva matriz target
nueva_target = np.eye(4)
nueva_target[:3, :3] = nueva_orientacion
nueva_target[:3, 3] = nueva_posicion

target = nueva_target
joints = np.array([[0],[0.0],[0.0],[0.0],[0.0],[0.0]])
#joints = np.array([[2.0943951],[-2.98451302],[-0.02558683],[-1.53994713],[-2.58803074],[-2.43682844]])

new_j, e_trace = i_kine(joints, target, DH_params, error_trace=True)
plot_pose(new_j, DH_params)

print("Ángulos finales de articulación-Directa:")
print(new_j)
plt.figure(figsize=(8,8))
plt.plot(e_trace)
plt.title('Directa')


# Ejemplo 1
#joints = np.array([[0.0],[-pi/2],[0.0],[pi/2],[0.0],[0.0]])

#target = np.array([[1, 0, 0, 10],
#                   [0, -1, 0, 34],
#                   [0, 0, -1, 37],
#                   [0, 0, 0, 1]])

#new_j, e_trace = i_kine(joints, target, DH_params, error_trace=True)

#plot_pose(new_j, DH_params)

#plt.figure(figsize=(8,8))
#plt.plot(e_trace)
#plt.title('Rastro de Error')
#plt.show()

#Ejemplo 2
#joints = np.array([[20*pi/180],[30*pi/180],[0],[0],[0],[0]])

#target = np.array([[1, 0, 0, 10],
#                   [0, -1, 0, 34],
#                   [0, 0, -1, 37],
#                   [0, 0, 0, 1]])

#new_j, e_trace = i_kine(joints, target, DH_params, error_trace=True, no_rotation=True)

#plot_pose(new_j, DH_params)
# Imprime los ángulos de articulación finales
# print("Ángulos finales de articulación:")
# print(new_j)
# plt.figure(figsize=(8,8))
# plt.plot(e_trace)
# plt.title('Error Trace')
# plt.show()