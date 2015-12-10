function draw_func(xj, yj, xs, ys, radii)
   plot(xj, yj, 'b.', 'MarkerSize', 500 * radii(1));
   plot(xs, ys, 'r.', 'MarkerSize', 500 * radii(2));
   line([xj,xs], [yj,ys]);
end