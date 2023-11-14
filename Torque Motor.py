#!/usr/bin/python
'''
author: Tobias Weis
''”
import sys,os
import math
import time
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
sns.set()
import cv2

CONST_NM_TO_KGM = 9.80665
CONST_NM_TO_PINCH = 0.11299

TORQUE_NM=0.42

# Calcular a cuanta distancia soporta las cargas el motor
values = []
for distance in range(1,51):
    values.append([distance, TORQUE_NM/CONST_NM_TO_KGM*100/distance])

values = np.array(values)

fig = plt.figure(figsize=(16,9.125))
ax = fig.add_subplot(111)

plt.plot(values[:,0], values[:,1], '-x', label='%.3f Nm' % (TORQUE_NM))
plt.plot(values[:,0], values[:,1], 'bo')

tidx = 0
pos=(10,2)
ax.annotate('%d cm: %.3f kg' % (values[tidx,0], values[tidx,1]), 
            xy=(values[tidx,0], values[tidx,1]), 
            xytext = pos,
            arrowprops=dict(facecolor='black', shrink=0.0, width=3, linewidth=0.05))

tidx = 9
pos=(20,2)
ax.annotate('%d cm: %.3f kg' % (values[tidx,0], values[tidx,1]), 
            xy=(values[tidx,0], values[tidx,1]), 
            xytext = pos,
            arrowprops=dict(facecolor='black', shrink=0.0, width=3, linewidth=0.05))

tidx = 49
pos=(40,1)
ax.annotate('%d cm: %.3f kg' % (values[tidx,0], values[tidx,1]), 
            xy=(values[tidx,0], values[tidx,1]), 
            xytext = pos,
            arrowprops=dict(facecolor='black', shrink=0.0, width=3, linewidth=0.05))


plt.xlabel("Distancias al centro del motor [cm]")
plt.ylabel("Peso que puede soportar [kg]")
plt.legend()
plt.show()

