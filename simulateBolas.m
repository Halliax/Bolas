function simulateBolas(InitialConditions)

initialX = InitialConditions(1); % m
initialY = InitialConditions(2); % m
initialVx = InitialConditions(3); % m/s
initialVy = InitialConditions(4); % m/s

r = .75; % m
g = 9.81; % m/s

[Times, Stocks] = ode45(@bolasDerivs, [0, 5], [initialX, initialY, initialVx, initialVy]);
Xpositions = Stocks(:,1);
Ypositions = Stocks(:,2);
Xvelocities = Stocks(:,3);
Yvelocities = Stocks(:,4);

fig1 = figure();
fig1.OuterPosition = [10,200,570,510];
comet(Times,Xpositions);
title('Bolas X Position over Time');

fig2 = figure();
fig2.OuterPosition = [600,200,570,510];
comet(Times,Ypositions);
title('Bolas Y Position over Time');

fig3 = figure();
fig3.OuterPosition = [1190,200,570,510];
comet(Xpositions,Ypositions);
title('Bolas Position over Time');

    function res = bolasDerivs(~, S)
    X = S(1);
    Y = S(2);
    Vx = S(3);
    Vy = S(4);
    
    dVx = (Vx^2 + Vy^2) / r * (X / sqrt(X^2 + Y^2));

    dVy = (Vx^2 + Vy^2) / r * (Y / sqrt(X^2 + Y^2));

    res = [Vx; Vy; dVx; dVy];

    end
end