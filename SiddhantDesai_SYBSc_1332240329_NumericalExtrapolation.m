clc
clear all;

n = input('Enter the number of data points: ');
x = zeros(1, n);
y = zeros(1, n);

fprintf('Enter %d x values:\n', n);
for i = 1:n
    x(i) = input(sprintf('  x(%d) = ', i));
end

fprintf('Enter %d y values:\n', n);
for i = 1:n
    y(i) = input(sprintf('  y(%d) = ', i));
end

x = x(:);
y = y(:);

[x, idx] = sort(x);
y = y(idx);

x_e = input('Enter the x value for extrapolation: ');
d = input('Enter degree for polynomial extrapolation: ');

if d >= n
    error('Degree must be less than number of data points.');
end

x1 = x(n-1);
x2 = x(n);
y1 = y(n-1);
y2 = y(n);

s = (y2 - y1) / (x2 - x1);
y_l = y2 + s * (x_e - x2);

A = zeros(n, d+1);

for i = 1:n
    for j = 0:d
        A(i, j+1) = x(i)^j;
    end
end

c = A \ y;

y_p = 0;
for j = 0:d
    y_p = y_p + c(j+1) * (x_e^j);
end

fprintf('Linear Extrapolated value at x = %.2f is: %.4f\n', x_e, y_l);
fprintf('Polynomial Extrapolated value (degree %d) at x = %.2f is: %.4f\n', d, x_e, y_p);

xx = linspace(min(x), max([x; x_e]) + 2, 100);
yy = zeros(size(xx));

for k = 1:length(xx)
    temp = 0;
    for j = 0:d
        temp = temp + c(j+1) * (xx(k)^j);
    end
    yy(k) = temp;
end

figure;
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
plot(xx, yy, 'b-', 'LineWidth', 2);
plot(x_e, y_p, 'yo', 'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor', 'y');
plot(x_e, y_l, 'o', 'MarkerSize', 10, 'LineWidth', 2, 'MarkerFaceColor', 'g');

legend('Data Points', 'Polynomial Fit', 'Polynomial Extrapolation', 'Linear Extrapolation');
xlabel('x');
ylabel('y');
title('Linear and Polynomial Extrapolation');
grid on;