function [positionB1,positionB2] = centerframe(time,omega,init_theta,r)
cur_theta = omega*time + init_theta;
positionB1.x = cos(cur_theta)*r;
positionB1.y = sin(cur_theta)*r;
positionB1.z = 0;
positionB2.x = -cos(cur_theta)*r;
positionB2.y = -sin(cur_theta)*r;
positionB2.z = 0;

end

