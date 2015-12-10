function animate_func(Times,Stocks,targetDistance, radii)
X1 = Stocks(:,5);
Y1 = Stocks(:,6);
X2 = Stocks(:,7);
Y2 = Stocks(:,8);

minmax = [min([X1;X2]), max([X1;X2]), min([Y1;Y2]), max([Y1;Y2])];

for i=1:length(Times)
    clf;
    axis([-10,10,0,20]);
    hold on;
    draw_func(X1(i), Y1(i), X2(i), Y2(i), radii);
    plot(0,targetDistance,'*');
    drawnow;
end