clc
clear;

a = input('Enter Value for a:');
b = input('Enter Value for b:');
N = input('Enter number of samples N:');

if a >= b
    error('Lower limit a must be less than upper limit b.');
end

if N <= 0
    error('N must be a positive integer.');
end

f = @(x) x.^3 + 2.*x.^2 + 1;
g = @(x) (x.^4)/4 + (2.*x.^3)/3 + x;

x_r = a + (b - a) * rand(1,N);
y_r = f(x_r);
 
I_e = (b - a) * mean(y_r);
I_a = g(b) - g(a);

fprintf('Estimated integral of f(x) from %.4f to %.4f is: %.6f\n', a, b, I_e);
fprintf('Exact value of the integral: %.6f\n', I_a);
fprintf('Error: %.6e\n', abs(I_a - I_e))