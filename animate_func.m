function animate_func(Times,Stocks)
X1 = Stocks(:,7);
Y1 = Stocks(:,8);
X2 = Stocks(:,9);
Y2 = Stocks(:,10);

minmax = [min([X1;X2]), max([X1;X2]), min([Y1;Y2]), max([Y1;Y2])];

for i=1:length(Times)
    clf;
    axis(minmax);
    axis equal;
    hold on;
    draw_func(X1(i), Y1(i), X2(i), Y2(i));
    drawnow;
end