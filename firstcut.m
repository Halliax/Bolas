function res = firstcut()
omega = 2*pi;
init_positionC.x = 0;
init_positionC.y = 0;
init_positionC.z = 0;
r = .75; %meters
V.x = 1;%meters per second
V.y = 0;%meters per second
V.z = 0;%meters per second
init_theta = pi/4; %radians

tt = linspace(0,5,1000);
result = zeros(4,1000);
for i=1:1000
    tcurrent = tt(i);
%     result(i) = bolasSimulation(tcurrent);
    [pB1G, pB2G] = bolasSimulation(tcurrent);
    result(1,i) = pB1G.x;
    result(2,i) = pB1G.y;
    result(3,i) = pB2G.x;
    result(4,i) = pB2G.y;
end
hold on;
plot(tt,result(1,:));
plot(tt,result(2,:));

 function [positionB1G,positionB2G] = bolasSimulation(time)
   [positionB1C,positionB2C] = centerframe(time,omega,init_theta,r);
   positionC = translatex(time,V,init_positionC);
   [positionB1G,positionB2G] = centertoground(positionB1C,positionB2C,positionC);
%    [position1,position2] = [positionB1G,positionB2G];
 end
end
