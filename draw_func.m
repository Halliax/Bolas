function draw_func(xj, yj, xs, ys)
   plot(xj, yj, 'b.', 'MarkerSize', 20);
   plot(xs, ys, 'r.', 'MarkerSize', 20);
   line([xj,xs], [yj,ys]);
end