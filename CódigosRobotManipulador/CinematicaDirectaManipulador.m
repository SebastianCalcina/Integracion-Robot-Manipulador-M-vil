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
% bot.plot(home, 'workspace',ws,'noname');
% t=[0:0.1:2];
% T=transl(0.6,0.1,0)*rpy2tr(0,180,0,'deg');
% hold on
% trplot(T);
% q=ikine6s(T)
bot.teach(home,'workspace',ws,'noname');
function g= param(name, value)
    persistent buff;
    %Inicializar
    if isempty(buff)
        buff.d1=0.202;
        buff.d6=0.010;
    end
    %Sobreescribir valores
    if nargin > 0
        buff.(name) = value;
    end
    g=buff;
end
