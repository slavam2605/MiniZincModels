array [1..33] of int: f4 = [0, 1, 2, 3, 5, 6, 8, 10, 12, 15, 16, 18, 21, 23, 26, 28, 31, 
                            34, 38, 41, 44, 47, 50, 54, 57, 61, 65, 68, 72, 76, 80, 85, 89];

int: n = 22;
int: m = f4[n];

var 0..n: min_deg;
var 0..n: max_deg;

int: tmp = if 2 * m mod n = 0 then 2 * m div n else (2 * m div n) + 1 endif;

constraint 1 + min_deg * max_deg <= n;
constraint min_deg <= max_deg;
constraint min_deg >= m - f4[n - 1];
constraint max_deg >= tmp;

solve satisfy;

output [show(min_deg) ++ ", " ++ show(max_deg) ++ "\n" ++ show(min_deg * max_deg) ++ " :: " ++ show(n - 1)]