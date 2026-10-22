clc
clear all

% Define Constants
x = 5;
h = 0.1;
i = 1;

% Function, Derivative, Title ArrayS
functions = {@exp, @log, @sin, @(x) x^2+5*x};
derivatives = {@exp, @(x) 1/x, @cos, @(x) 2*x+5};
titles = {'exp(x)', 'log(x)', 'sin(x)', 'x^2 + 5*x'};

while i <= length(functions)
    % Array Data
    f_x  = functions{i};
    df_dx = derivatives{i};
    % Formula for Forward, Backward, and Central Derivative
    f_a = df_dx(x);
    f_f = (f_x(x+h) - f_x(x)) / h;
    f_b = (f_x(x) - f_x(x-h)) / h;
    f_c = (f_x(x+h) - f_x(x-h)) / (2*h);
    % Abolute Error Calculation
    e_f = abs(f_a - f_f);
    e_b = abs(f_a - f_b);
    e_c = abs(f_a - f_c);
    % Result
    fprintf('\nFunction: %s\n', titles{i});
    fprintf('Analytical Solution: %.5f\n', f_a);
    fprintf('Forward Derivative: %.5f | Error: %.5f\n', f_f, e_f);
    fprintf('Backward Derivative: %.5f | Error: %.5f\n', f_b, e_b);
    fprintf('Central Derivative: %.5f | Error: %.5f\n', f_c, e_c);

    i = i + 1;  
end
