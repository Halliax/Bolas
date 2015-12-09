function simulateBolasMarkII()
% define variables

simulationTime = 10; %seconds
mass1 = 3; % kg
mass2 = 3; % kg
length = 4; % length of rope
length1 = length/2; % length between CoM and mass1
length2 = length/2; % length between CoM and mass2
R_init = [0,0]; % position vector of center of mass
V_init = [0,2]; % velocity vector of CoM
theta_init = 0; % radians, angle b/w +X and mass 2
w_init = 2 / length1; % initial angular velocity, V/R
Ra_init = [-2,0]; % position vector of mass 1
Rb_init = [2,0]; % position vector of mass 2

%% ODE45
% store simulation results in time and stock vectors
[Times, Stocks] = ode45(@bolasDerivs, [0, simulationTime],...
    [R_init(1),R_init(2),V_init(1),V_init(2),theta_init,w_init,...
    Ra_init(1),Ra_init(2),Rb_init(1),Rb_init(2)]);

%% sort simulation results out of stock vectors
CenterPositions = [Stocks(:,1),Stocks(:,2)];
CenterVelocities = [Stocks(:,3),Stocks(:,4)];
Thetas = Stocks(:,5);
Omegas = Stocks(:,6);
Mass1Positions = [Stocks(:,7),Stocks(:,8)];
Mass2Positions = [Stocks(:,9),Stocks(:,10)];

%% plot results

% plot X positions
fig1 = figure();
title('Bolas X Position over Time');
fig1.OuterPosition = [10,200,570,510];
hold on;
plot(Times,Mass1Positions(1));
plot(Times,Mass2Positions(1));
plot(Times,CenterPositions(1));

% plot Y positions
fig2 = figure();
title('Bolas Y Position over Time');
fig2.OuterPosition = [610,200,570,510];
hold on;
plot(Times,Mass1Positions(2));
plot(Times,Mass2Positions(2));
plot(Times,CenterPositions(2));

% plot X vs Y positions
fig3 = figure();
title('Bolas Positions');
fig3.OuterPosition = [1210,200,570,510];
hold on;
plot(Mass1Positions);
plot(Mass2Positions);
plot(CenterPositions);

% plot bullshit
%plot(Times,Stocks);

% figure();
% hold on;
% animate_func(Times,Stocks);

%% flow function
    function res = bolasDerivs(~, S)
    % unpack input variables
    R = [S(1),S(2)];
    V = [S(3),S(4)];
    theta = S(5);
    w = S(6);
    Ra = [S(7),S(8)];
    Rb = [S(9),S(10)];
    
    % derivative of center of mass velocity (linear acceleration)
    A = [0,0];
    
    % calculate R1 and R2, position vectors of masses relative to CoM
    R2 = [length2 * cos(theta),length2 * sin(theta)];
    R1 = [-length1 * cos(theta),-length1 * sin(theta)];
    
    % calculate Ra and Rb, position vectors of masses relative to origin
    Ra = R + R1; % add dem vectors
    Rb = R + R2; % add dem even more vectors
    
    % calculate Va and Vb, derivatives of Ra and Rb
    Va = V + [length1 * w * sin(theta), -length1 * w * cos(theta)];
    Vb = V + [-length2 * w * sin(theta), length2 * w * cos(theta)];
    
    % derivative of angular velocity (angular acceleration)
    alpha = 0;
    
    res = [V(1); V(2); A(1); A(2); w; alpha; Va(1); Va(2); Vb(1); Vb(2)];
    %keyboard;
    end
end