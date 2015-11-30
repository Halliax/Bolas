function [positionB1G,positionB2G] = centertoground(positionB1C,positionB2C,positionC)
positionB1G.x = positionB1C.x + positionC.x;
positionB1G.y = positionB1C.y + positionC.y;
positionB1G.z = positionC.z;
positionB2G.x = positionB2C.x + positionC.x;
positionB2G.y = positionB2C.y + positionC.y;
positionB2G.z = positionC.z;

end