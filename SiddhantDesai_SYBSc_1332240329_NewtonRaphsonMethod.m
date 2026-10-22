clc
clear all;

a = input('Enter Value for a:');
i = 1;

f_x = @(x) x^3 - 4*x^2 -7*x +10;
f1_x = @(x) 3*x^2 - 8*x - 7;

fprintf('F(a) is %g\n', f_x(a));
fprintf('F''(a) is %g\n', f1_x(a));

while i <= 250
    b = a - (f_x(a)/f1_x(a));
    if abs(b-a)<= 0.0001
        fprintf('Final root approximation after %d iterations: %g\n', i-1, a);
        break;
    end
    a = b; 
    fprintf('Aprroximation after iteration %d: a = %g\n', i, a);
    i = i + 1;
    if i == 250
        warning('Maximum Iterations Have bbeen Reached');
    end
end