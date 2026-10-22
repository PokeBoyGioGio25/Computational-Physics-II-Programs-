clc
clear all;

a = input('Enter Value for a:');
b = input('Enter Value for b:');
d = 0;
i = 1;

f_x = @(x) x^3 + x^2 - 40*x;
fa = f_x(a);
fb = f_x(b);

fprintf('F(a) = %g\n', f_x(a))
fprintf('F(b) = %g\n', f_x(b))

if fb==fa
    error('Initial function values at a and b must differ.');
end

while i <= 250
    c = b - fb*(b - a)/(fb - fa); 
    a = b;
    fa = fb;
    b = c;
    fb = f_x(b);
    if f_x(c) == 0
       fprintf('Approximation after iteration %d: c = %.10g\n', i, c);
       break
    end
    if fb==fa
        warning('Function values became equal; stopping to avoid division by zero.');
        break
    end
    i = i + 1;
end