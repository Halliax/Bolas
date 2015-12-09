function simulateBolasMarkII(masses, length, throwingEnergy)
%% define variables
simulationTime = 0.75; % seconds

mass1 = masses(1); % kg
mass2 = masses(2); % kg
totalMass = mass1 + mass2; % kg
length1 = (length * mass2) / totalMass; % length between CoM and mass1
length2 = length - length1; % length between CoM and mass2
moment = mass1 * (length1^2) + mass2 * (length2^2); % I = sum(mr^2)

airDensity = 1.2041; % kg/m^3
dragCoefficient = 0.47; % dimensionless, coefficient of sphere

solidDensity = 740; % kg/m^3
volume1 = mass1/solidDensity; % density = M/V
volume2 = mass2/solidDensity;
radius1 = nthroot((0.75 / pi) * volume1, 3); % volume = 4/3 * pi * r^3
radius2 = nthroot((0.75 / pi) * volume2, 3);
crossA1 = pi * radius1^2; % A = pi * r^2
crossA2 = pi * radius2^2;

Ra_init = [-length1,0]; % position vector of mass 1
Rb_init = [length2,0]; % position vector of mass 2
Va_init = [0,0]; % velocity vector of mass 1
Vb_init = [0,sqrt((2 * throwingEnergy) / mass2)]; % velocity vector of mass 2
R_init = [0,0]; % position vector of center of mass
V_init = [0,(mass2 * Vb_init(2)) / totalMass]; % velocity vector of CoM
theta_init = 0; % radians, angle b/w +X and mass 2
w_init = (Vb_init(2) - V_init(2)) / length1; % initial angular velocity, V/R

%% ODE45
% store simulation results in time and stock vectors
[Times, Stocks] = ode45(@bolasDerivs, [0, simulationTime], ...
    [R_init(1),R_init(2),V_init(1),V_init(2),Ra_init(1),Ra_init(2), ...
    Rb_init(1),Rb_init(2), theta_init,w_init]);

%% sort simulation results out of stock vectors
CenterPositions = [Stocks(:,1),Stocks(:,2)];
CenterVelocities = [Stocks(:,3),Stocks(:,4)];
Mass1Positions = [Stocks(:,5),Stocks(:,6)];
Mass2Positions = [Stocks(:,7),Stocks(:,8)];
Thetas = Stocks(:,9);
Omegas = Stocks(:,10);

%% plot results

% plot X positions
fig1 = figure();
title('Bolas X Position over Time');
fig1.OuterPosition = [10,200,570,510];
hold on;
plot(Times,Mass1Positions(:,1));
plot(Times,Mass2Positions(:,1));
plot(Times,CenterPositions(:,1));

% plot Y positions
fig2 = figure();
title('Bolas Y Position over Time');
fig2.OuterPosition = [610,200,570,510];
hold on;
plot(Times,Mass1Positions(:,2));
plot(Times,Mass2Positions(:,2));
plot(Times,CenterPositions(:,2));

% plot X vs Y positions
fig3 = figure();
title('Bolas Positions');
fig3.OuterPosition = [1210,200,570,510];
hold on;
plot(Mass1Positions(:,1), Mass1Positions(:,2));
plot(Mass2Positions(:,1), Mass2Positions(:,2));
plot(CenterPositions(:,1), CenterPositions(:,2));

figure();
hold on;
animate_func(Times,Stocks);

%% flow function
    function res = bolasDerivs(~, S)
    % unpack input variables
    R = [S(1),S(2)];
    V = [S(3),S(4)];
    Ra = [S(5),S(6)];
    Rb = [S(7),S(8)];
    theta = S(9);
    w = S(10);
    
    % calculate R1 and R2, position vectors of masses relative to CoM
    R2 = [length2 * cos(theta),length2 * sin(theta)];
    R1 = [-length1 * cos(theta),-length1 * sin(theta)];
    
    % calculate Ra and Rb, position vectors of masses relative to origin
    Ra = R + R1; % add dem vectors
    Rb = R + R2; % add dem even more vectors
    
    % calculate Va and Vb, derivatives of Ra and Rb
    Va = V + [length1 * w * sin(theta), -length1 * w * cos(theta)];
    Vb = V + [-length2 * w * sin(theta), length2 * w * cos(theta)];
    
    % drag forces (Fd = -1/2 * p * Cd * A * |V| * vectorV)
    Fd1 = -0.5 * airDensity * dragCoefficient * crossA1 * norm(Va) * Va;
    Fd2 = -0.5 * airDensity * dragCoefficient * crossA2 * norm(Vb) * Vb;
    
    % derivative of center of mass velocity (linear acceleration)
    A = [(1/totalMass) * (Fd1(1) + Fd2(1)),(1/totalMass) * (Fd1(2) + Fd2(2))];
    
    % derivative of angular velocity (angular acceleration)
    Torque = cross([R1,0],[Fd1,0])+cross([R2,0],[Fd2,0]);
    alpha = Torque(3) / moment;
    
    res = [V(1); V(2); A(1); A(2); Va(1); Va(2); Vb(1); Vb(2); w; alpha];
    %keyboard
    end
end