clc
clear all

f_x = @(x) x^3 - 16*x^2 + 65*x - 50;
a = input('Enter Value for a:');
b = input('Enter Value for b:');

fprintf('Value of a is %g\n', a)
fprintf('Value of b is %g\n', b)

fprintf('F(a) = %g\n', f_x(a))
fprintf('F(b) = %g\n', f_x(b))

if f_x(a)*f_x(b)>=0 
    error('A root does not exist in the given value of a and b')
end

while (b-a) >= 0.0001
    c = (a+b)/2;
    if f_x(c) == 0
        fprintf('Root found at c = %g\n', c);
        break;
    elseif f_x(c)*f_x(a) < 0
        b = c;
    else
        a = c;
    end
end

fprintf('Approximate root found at c = %g\n', c);