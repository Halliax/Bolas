function res = translatex(t,V,init_positionC)
positionC.x = V.x*t+init_positionC.x;
positionC.y = V.y*t+init_positionC.y;
positionC.z = init_positionC.z;
res = positionC;
end