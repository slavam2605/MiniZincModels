array [1..32] of int: f4 = [0, 1, 2, 3, 5, 6, 8, 10, 12, 15, 16, 18, 21, 23, 26, 28, 31, 
                            34, 38, 41, 44, 47, 50, 54, 57, 61, 65, 68, 72, 76, 80, 85];

int: n = 33;
var int: f;
var int: temp;

constraint f >= 0;
constraint f <= n * sqrt(n - 1) / 2;
constraint n >= 1 + (2 * f / n + 1) * (f - f4[n - 1]);

% f4[33] <= 90
% f4[33] >= 87

% f4[2q^2 + q] >= q^2(q+1) + (q+1)f4[q]
% 36 = 2 * 4^2 + 4
% f4[36] >= 4^2*5 + 5* f4[4] = 80 + 5 * 3 = 95
% f4[36] >= 95

solve satisfy;

output [show(f)];
