function simulateBolas(InitialConditions)

initialX1 = InitialConditions(1); % m
initialY1 = InitialConditions(2); % m
initialVx1 = InitialConditions(3); % m/s
initialVy1 = InitialConditions(4); % m/s

initialX2 = InitialConditions(5); % m
initialY2 = InitialConditions(6); % m
initialVx2 = InitialConditions(7); % m/s
initialVy2 = InitialConditions(8); % m/s

r = .75; % m

[Times, Stocks] = ode45(@bolasDerivs, [0, 5], [initialX1, initialY1, ...
    initialVx1, initialVy1, initialX2, initialY2, initialVx2, initialVy2]);
X1positions = Stocks(:,1);
Y1positions = Stocks(:,2);
% X1velocities = Stocks(:,3);
% Y1velocities = Stocks(:,4);
X2positions = Stocks(:,5);
Y2positions = Stocks(:,6);
% X2velocities = Stocks(:,7);
% Y2velocities = Stocks(:,8);

fig1 = figure();
title('Bolas X Position over Time');
fig1.OuterPosition = [10,200,570,510];
hold on;
plot(Times,X1positions);
plot(Times,X2positions);

fig2 = figure();
title('Bolas Y Position over Time');
fig2.OuterPosition = [610,200,570,510];
hold on;
plot(Times,Y1positions);
plot(Times,Y2positions);

fig3 = figure();
title('Bolas Position over Time');
fig3.OuterPosition = [1210,200,570,510];
hold on;
plot(X1positions,Y1positions);
plot(X2positions,Y2positions);

    function res = bolasDerivs(~, S)
    X1 = S(1);
    Y1 = S(2);
    Vx1 = S(3);
    Vy1 = S(4);
    
    X2 = S(5);
    Y2 = S(6);
    Vx2 = S(7);
    Vy2 = S(8);
    
    dVx1 = (Vx1^2 + Vy1^2) / r * ((X2-X1) / sqrt((X2 - X1)^2 + (Y2 - Y1)^2));
    
    dVy1 = (Vx1^2 + Vy1^2) / r * ((Y2-Y1) / sqrt((X2 - X1)^2 + (Y2 - Y1)^2));
    
    dVx2 = (Vx2^2 + Vy2^2) / r * ((X1-X2) / sqrt((X1 - X2)^2 + (Y1 - Y2)^2));

    dVy2 = (Vx2^2 + Vy2^2) / r * ((Y1-Y2) / sqrt((X1 - X2)^2 + (Y1 - Y2)^2));
    
    
    res = [Vx1; Vy1 + 6; dVx1; dVy1; Vx2; Vy2 + 6; dVx2; dVy2];

    end
end