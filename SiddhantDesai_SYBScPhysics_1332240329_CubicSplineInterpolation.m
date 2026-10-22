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

if any(diff(x) <= 0)
    error('x values must increase.');
end

h = diff(x);
A = zeros(n,n);
rhs = zeros(n,1);

A(1,1) = 1;
A(n,n) = 1;

for i = 2:n-1
    A(i,i-1) = h(i-1);
    A(i,i)   = 2*(h(i-1) + h(i));
    A(i,i+1) = h(i);
    
    rhs(i) = 6*((y(i+1)-y(i))/h(i) - (y(i)-y(i-1))/h(i-1));
end

M = A \ rhs;
xp = input('Enter the value to interpolate: ');

for i = 1:n-1
    if xp >= x(i) && xp <= x(i+1)
        break;
    end
end

hi = h(i);

yp = (M(i)*(x(i+1)-xp)^3)/(6*hi) + ...
     (M(i+1)*(xp-x(i))^3)/(6*hi) + ...
     (y(i) - M(i)*hi^2/6)*(x(i+1)-xp)/hi + ...
     (y(i+1) - M(i+1)*hi^2/6)*(xp-x(i))/hi;

fprintf('Interpolated value at x = %.4f is y = %.4f\n', xp, yp);

xx = linspace(min(x), max(x), 500);
yy = zeros(size(xx));

for k = 1:length(xx)
    for i = 1:n-1
        if xx(k) >= x(i) && xx(k) <= x(i+1)
            hi = h(i);
            yy(k) = (M(i)*(x(i+1)-xx(k))^3)/(6*hi) + ...
                    (M(i+1)*(xx(k)-x(i))^3)/(6*hi) + ...
                    (y(i) - M(i)*hi^2/6)*(x(i+1)-xx(k))/hi + ...
                    (y(i+1) - M(i+1)*hi^2/6)*(xx(k)-x(i))/hi;
            break;
        end
    end
end

figure;
plot(x, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on;
plot(xx, yy, 'b-', 'LineWidth', 2);
plot(xp, yp, 'ks', 'MarkerFaceColor', 'g');

legend('Data Points', 'Cubic Spline', 'Interpolated Point');
xlabel('x');
ylabel('y');
title('Cubic Spline Interpolation');
grid on;