%% Build data set
X = zeros(1,20);
Y = zeros(1,30);
Z =zeros(30,20);

for i = 1:100
    X(i) = i/100;
    disp([num2str(i), ' percent'])
    for j = 1:50
       Y(j) = j/10;
       Z((j), i) = successRate([i/100,i/100], j/10);
    end
end

%% plot

figure(1)
hold on
colormap(jet);
contourLevels = (5:5:45);
title('Success Rate of Bolas Constructions')
xlabel('Masses (kg)')
ylabel('Length (m)')
colorbar;

%filled contour plot
contourf(X,Y,Z); 

%regular contour plot
contour(X,Y,Z); 

hold off
