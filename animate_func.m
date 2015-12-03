function animate_func(Times,Stocks)
X1 = Stocks(:,1);
Y1 = Stocks(:,2);
X2 = Stocks(:,5);
Y2 = Stocks(:,6);

minmax = [min([X1;X2]), max([X1;X2]), min([Y1;Y2]), max([Y1;Y2])];

for i=1:length(Times)
    clf;
    axis(minmax);
    hold on;
    draw_func(X1(i), Y1(i), X2(i), Y2(i));
    drawnow;
end