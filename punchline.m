n = 100;
length = linspace(.05,5,n);
mass = linspace(.05,5,n);
result = zeros(n,n);
for i=1:n
    for j=1:n
        result(i,j)=simulateBolas(i,j);
    end
end
pcolor(mass,length,result);
hold on;
contour(mass,length,result,'r');
xlabel('mass (kilograms)');
ylabel('length (meters)');
title('Success Rate as a Function of Mass and Length of the Bolas');