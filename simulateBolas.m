function simulateBolas(Bola1Conditions, Bola2Conditions, masses, simulationTime)
%% assign initial conditions (linear)

% assign X and Y position and velocity for Bola 1
initialX1 = Bola1Conditions(1); % m
initialY1 = Bola1Conditions(2); % m
initialVx1 = Bola1Conditions(3); % m/s
initialVy1 = Bola1Conditions(4); % m/s

% assign X and Y position and velocity for Bola 2
initialX2 = Bola2Conditions(1); % m
initialY2 = Bola2Conditions(2); % m
initialVx2 = Bola2Conditions(3); % m/s
initialVy2 = Bola2Conditions(4); % m/s

% assign masses
mass1 = masses(1); % kg
mass2 = masses(2); % kg
totalMass = mass1 + mass2; % kg

%% define center of mass conditions

% position and velocity conditions: Xcm = (m1X1 + m2X2) / (m1 + m2)
initialXc = ((mass1 * initialX1) + (mass2 * initialX2)) / totalMass;
initialYc = ((mass1 * initialY1) + (mass2 * initialY2)) / totalMass;
initialVxc = ((mass1 * initialVx1) + (mass2 * initialVx2)) / totalMass;
initialVyc = ((mass1 * initialVy1) + (mass2 * initialVy2)) / totalMass;

% radius = (?(X^2 + Y^2)) / 2
r = sqrt((initialX2 - initialX1)^2 + (initialY2 - initialY1)^2) / 2; % m

%% define angular velocities

% find the angle between the velocity vector and the radius
initialThetaDiff1 = atan(initialVy1/initialVx1) - atan((initialY1-initialYc)/(initialX1-initialXc));
initialThetaDiff2 = atan(initialVy2/initialVx2) - atan((initialY2-initialYc)/(initialX2-initialXc));

% calculate angular velocity based on thetaDiff
initialw1 = (sqrt(initialVx1^2 + initialVy1^2) / r) * (sin(initialThetaDiff1));
initialw2 = (sqrt(initialVx2^2 + initialVy2^2) / r) * (sin(initialThetaDiff2));

options = odeset('RelTol', 1e-7);

%% ODE45
% store simulation results in time and stock vectors
[Times, Stocks] = ode45(@bolasDerivs, [0, simulationTime], [initialX1, initialY1, ...
     initialVx1, initialVy1, initialX2, initialY2, initialVx2, initialVy2], options);
% [Times, Stocks] = ode45(@bolasDerivs, [0, simulationTime], [initialX1, initialY1, ...
%     initialVx1, initialVy1, initialX2, initialY2, initialVx2, initialVy2]);

% sort simulation results out of stock vectors
X1positions = Stocks(:,1);
Y1positions = Stocks(:,2);
X1velocities = Stocks(:,3);
Y1velocities = Stocks(:,4);

X2positions = Stocks(:,5);
Y2positions = Stocks(:,6);
X2velocities = Stocks(:,7);
Y2velocities = Stocks(:,8);

size(X1positions)
size(Y1positions)
size(X2positions)
size(Y2positions)

%% plot results

% plot X positions
fig1 = figure();
title('Bolas X Position over Time');
fig1.OuterPosition = [10,200,570,510];
hold on;
plot(Times,X1positions);
plot(Times,X2positions);

% plot Y positions
fig2 = figure();
title('Bolas Y Position over Time');
fig2.OuterPosition = [610,200,570,510];
hold on;
plot(Times,Y1positions);
plot(Times,Y2positions);

% plot X vs Y positions
fig3 = figure();
title('Bolas Positions');
fig3.OuterPosition = [1210,200,570,510];
hold on;
plot(X1positions,Y1positions);
plot(X2positions,Y2positions);

figure();
hold on;
animate_func(Times,Stocks);


%% flow function
    function res = bolasDerivs(~, S)
    % unpack positions and velocities
    X1 = S(1);
    Y1 = S(2);
    Vx1 = S(3);
    Vy1 = S(4);
    
    X2 = S(5);
    Y2 = S(6);
    Vx2 = S(7);
    Vy2 = S(8);
    
    % center of mass position and velocity conditions
    Xc = ((mass1 * X1) + (mass2 * X2)) / totalMass;
    Yc = ((mass1 * Y1) + (mass2 * Y2)) / totalMass;
    Vxc = ((mass1 * Vx1) + (mass2 * Vx2)) / totalMass;
    Vyc = ((mass1 * Vy1) + (mass2 * Vy2)) / totalMass;
    
    %% define angular velocities

    % find the angle between the velocity vector and the radius
    thetaV1 = atan((Vy1-Vyc)/(Vx1-Vxc))
    thetaV2 = atan((Vy2-Vyc)/(Vx2-Vxc))
    thetaR1 = atan((Y1-Yc)/(X1-Xc))
    thetaR2 = atan((Y2-Yc)/(X2-Xc))
    thetaDiff1 = thetaV1 - thetaR1
    thetaDiff2 = thetaV2 - thetaR2

    % calculate angular velocity based on thetaDiff
    w1 = (sqrt(Vx1^2 + Vy1^2) / r) * (sin(thetaDiff1));
    w2 = (sqrt(Vx2^2 + Vy2^2) / r) * (sin(thetaDiff2));
    
    % calculate radial acceleration
    dVx1 = w1^2 * r * -(cos(thetaR1));
    
    dVy1 = w1^2 * r * -(sin(thetaR1));
    
    dVx2 = w2^2 * r * -(cos(thetaR2));
    
    dVy2 = w2^2 * r * -(sin(thetaR2));
    
%     dVx1 = (Vx1^2 + Vy1^2) / r * ((Xc-X1) / sqrt((Xc - X1)^2 + (Yc - Y1)^2));
%     
%     dVy1 = (Vx1^2 + Vy1^2) / r * ((Yc-Y1) / sqrt((Xc - X1)^2 + (Yc - Y1)^2));
%     
%     dVx2 = (Vx2^2 + Vy2^2) / r * ((Xc-X2) / sqrt((Xc - X2)^2 + (Yc - Y2)^2));
% 
%     dVy2 = (Vx2^2 + Vy2^2) / r * ((Yc-Y2) / sqrt((Xc - X2)^2 + (Yc - Y2)^2));
    
    % return bolas positions and velocities
    res = [Vx1 + Vxc; Vy1 + Vyc; dVx1; dVy1; Vx2 + Vxc; Vy2 + Vyc; dVx2; dVy2];
    keyboard;

    end
end