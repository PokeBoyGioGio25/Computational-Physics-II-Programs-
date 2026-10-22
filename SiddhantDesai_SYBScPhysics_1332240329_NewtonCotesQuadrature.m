clc;
clear;

f = @(x) exp(x);

a = 0;
b = 1;
n = 6;

h = (b - a)/n;
x = a:h:b;

% Analytical Solution
y = f(x);
v = exp(1) - exp(0);

% Trapezoidal Rule
T = h * ((y(1) + y(end))/2 + sum(y(2:end-1)));

% Simpson's 1/3 Rule
S13 = (h/3) * ( y(1) + y(end) + ...
    4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) );

% Simpson's 3/8 Rule
S38 = (3*h/8) * ( y(1) + y(end) + ...
    3*sum(y(2:3:end-1)) + ...
    3*sum(y(3:3:end-1)) + ...
    2*sum(y(4:3:end-3)) );

fprintf('Analytical Value     = %.8f\n', v);
fprintf('Trapezoidal Rule     = %.8f\n', T);
fprintf('Simpson''s 1/3 Rule   = %.8f\n', S13);
fprintf('Simpson''s 3/8 Rule   = %.8f\n', S38);

fprintf('\nErrors:\n');
fprintf('Trapezoidal Error    = %.8e\n', abs(v - T));
fprintf('Simpson 1/3 Error    = %.8e\n', abs(v - S13));
fprintf('Simpson 3/8 Error    = %.8e\n', abs(v - S38));