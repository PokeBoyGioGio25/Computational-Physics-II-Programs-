clc;
clear;

f = @(x) x^3 + 2*x^2 - x;

a = 2;
b = 6;

t = [-1/sqrt(3), 1/sqrt(3)];
w = [1, 1];

I_g = 0;
for i = 1:2
    x = ((b-a)/2)*t(i) + (a+b)/2;
    I_g = I_g + w(i)*f(x);
end

I_g = (b-a)/2 * I_g;

g = @(x) (x^4)/4 + (2/3)*x^3 - (x^2)/2;
I_a = g(b) - g(a);

fprintf('Gaussian Quadrature value = %.6f\n', I_g);
fprintf('Analytical Value = %.6f\n', I_a);
fprintf('Error = %.6f\n', abs(I_a - I_g));