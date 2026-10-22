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

fprintf('The X values are:\n');
fprintf('  %g', x);
fprintf('\nThe Y values are:\n');
fprintf('  %g', y);
fprintf('\n');

mX = mean(x);
mY = mean(y);
fprintf('Mean x:\n%g\n', mX);
fprintf('Mean y:\n%g\n', mY);

dX = x - mX;
dY = y - mY;
fprintf('dX = %g\n', sum(dX));
fprintf('dY = %g\n', sum(dY));

sXY = sum(dX .* dY);
sXX = sum(dX .^ 2);
fprintf('sXY = %g\n', sXY);
fprintf('sXX = %g\n', sXX);

b = sXY / sXX;
a = mY - b * mX;
fprintf('Slope (b): %g\n', b);
fprintf('Intercept (a): %g\n', a);

fprintf('The best-fit line is: y = %g*x + %g\n', b, a);

figure;
plot(x, y, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Data'); hold on;
xline = linspace(min(x), max(x), 100);
yline = b * xline + a;
plot(xline, yline, 'r-', 'LineWidth', 2, 'DisplayName', sprintf('Line of best fit: y = %g x + %g', b, a));
xlabel('x');
ylabel('y');
title('Least Square Fitting');
legend('Location', 'best');
grid on;
hold off;