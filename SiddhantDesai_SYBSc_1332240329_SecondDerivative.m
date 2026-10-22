clc
clear all

% Define Constants
x = 5;
h = 0.1;
i = 1;

% Function, Derivative, Title Arrays
functions = {@exp, @log, @sin, @(x) x^3};
derivatives = {@exp, @(x) -(1/x^2),@(x) -sin(x), @(x) 6*x};
titles = {'exp(x)', 'log(x)', 'sin(x)', 'x^3'};

while i <= length(functions)
    % Array Data
    f_x  = functions{i};
    d2f_dx2 = derivatives{i};
    % Formula for Numerical Second Order Derivative
    f_a = d2f_dx2(x);
    f_two = (f_x(x + h) - 2*f_x(x) + f_x(x - h)) / h^2;
    % Abolute Error Calculation
    e_two = abs(f_a - f_two);
    % Result
    fprintf('\nFunction: %s\n', titles{i});
    fprintf('Analytical Solution: %.5f\n', f_a);
    fprintf('Forward Derivative: %.5f | Error: %.5f\n', f_two, e_two);
    
    i = i + 1;  
end