clear, close, clc;
prm = param();
%Creamos un robot mediante sus parametros D-H
L1=Revolute('a',0,'alpha',-pi/2,'d',prm.d1);    
L2=Revolute('a',0.160,'alpha',0,'d',0);
L3=Revolute('a',0,'alpha',pi/2,'d',0);
L4=Revolute('a',0,'alpha',-pi/2,'d',0.195);
L5=Revolute('a',0.067,'alpha',pi/2,'d',0);
L6=Revolute('a',0,'alpha',0,'d',prm.d6);
bot=SerialLink([L1,L2,L3,L4,L5,L6]); %Crear robot
%Pose inicial (home)
home= [0,0.5,0.5,0,0,0];
ws=([-4.5 4.5 -4.5 4.5 -1 4.5]);
% bot.plot([0,0.5,0.5,0,0,0], 'workspace',ws,'noname');
bot.teach(home,'workspace',ws,'noname');
%Crear bucle para cambiar manualmente la posición del robot
while true
    O= input('Introduzca un vector de posición deseada [x,y,z]: ');
Evaluamos y graficamos
    plot_sphere(O,0.05, 'y')
    input('Presione una tecla para mover al robot...')
    bot.teach([q1,q2,q3,q4,q5,q6], 'workspace', ws, 'noname')
end
function [q1,q2,q3,q4,q5,q6] = invPos(x,y,z)
    prm=param();
     q1=atan2(-y(67.15*cos(q5)*sin(q4))/x);
     q2=atan2(((x*cos(q1)+y*sin(q1))*160+(195*sin(q3)-67.15*sin(q3)*sin(q5)+67.15*cos(q3)*cos(q4)*cos(q5)))/(z+202));
     q3=asin((-160+cos(q2)*(x*cos(q1)+y*sin(q1))-sin(q2)*(z+202)-67.15*cos(q3)*cos(q4)*cos(q5))/(195-67.15*sin(q5))):
     q4=asin((tan(q1)+(y/x))/(67.15*cos(q4)));
     q5=acos(-(tan(q1)+(y/x))/(67.15*sin(q4)));
q6=atan2((x*(cos(q1)*(cos(q2)*(cos(q5)*sin(q3)+cos(q3)*cos(q4)*sin(q5))+sin(q2)*(cos(q3)*cos(q5)-cos(q4)*sin(q3)*sin(q5))sin(q1)*sin(q4)*sin(q5)+202*sin(q2)*(cos(q5)*sin(q3)+cos(q3)*cos(q4)*sin(q5))))/(y*sin(q1)*(cos(q2)*(cos(q5)*sin(q3)+cos(q3)*cos(q4)*sin(q5)))+z(cos(q2)*(cos(q3)*cos(q5)-cos(q4)*sin(q3)*sin(q5))-sin(q2)*(cos(q5)*sin(q3)+cos(q3)*cos(q4)+sin(q5)))) 
end
