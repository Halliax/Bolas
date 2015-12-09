function simulateBolasMarkII()
%% assign initial conditions


%% ODE45
% store simulation results in time and stock vectors
[Times, Stocks] = ode45(@bolasDerivs, [0, simulationTime]);

 % sort simulation results out of stock vectors

%% plot results


%% flow function
    function res = bolasDerivs(~, S)
    

    end
end