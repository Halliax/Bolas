function simulateBolas(InitialConditions)

initialX = InitialConditions(1); % m
initialY = InitialConditions(2); % m
initialVx = InitialConditions(3); % m/s
initialVy = InitialConditions(4); % m/s

g = 9.81; % m/s

[Times, Stocks] = ode45(@pendulumDerivs, [0, endTime], [initialX, initialY, initialVx, initialVy]);
Xpositions = Stocks(:,1);
Ypositions = Stocks(:,2);
Xvelocities = Stocks(:,3);
Yvelocities = Stocks(:,4);

fig1 = figure();
fig1.OuterPosition = [10,200,570,510];
comet(Times,Xpositions);
title('Pendulum X Position over Time');

fig2 = figure();
fig2.OuterPosition = [600,200,570,510];
comet(Times,Ypositions);
title('Pendulum Y Position over Time');

fig3 = figure();
fig3.OuterPosition = [1190,200,570,510];
comet(Xpositions,Ypositions);
title('Pendulum Position over Time');

    function res = pendulumDerivs(~, S)
    X = S(1);
    Y = S(2);
    Vx = S(3);
    Vy = S(4);
    
    dVx = (- springConstant * (sqrt(X^2+Y^2) - restLength) * ...
        (X / (sqrt(X^2+Y^2)))) / mass;

    dVy = (-mass * g  - springConstant * (sqrt(X^2+Y^2) - restLength) * ...
        (Y / (sqrt(X^2+Y^2)))) / mass;

    res = [Vx; Vy; dVx; dVy];

    end
end