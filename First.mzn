% OEIS A006856
array [1..32] of int: f4 = [0, 1, 2, 3, 5, 6, 8, 10, 12, 15, 16, 18, 21, 23, 26, 28, 31, 
                            34, 38, 41, 44, 47, 50, 54, 57, 61, 65, 68, 72, 76, 80, 85];
% Number of vertices and edges
int: n = 11;
int: m = f4[n];

% Adjacency matrix and auxiliary var arrays
array [1..n, 1..n] of var 0..1: A;
array [1..n, 1..n, 1..n] of var 0..1: x3;
array [1..n, 1..n] of var 0..1: x2;

% A is symmetric with no loops
constraint forall(i, j in 1..n where i < j) (A[i, j] = A[j, i]);
constraint forall(i in 1..n) (A[i, i] = 0);

% Definition of x2 and x3
constraint forall(i, j, k in 1..n) (x3[i, j, k] = A[i, j] * A[j, k]);
constraint forall(i, k in 1..n) (x2[i, k] = exists([x3[i, j, k] = 1 | j in 1..n where j != i /\ j != k]));
% No cycles of length 3 and 4
constraint forall(i, k in 1..n where i != k) (A[i, k] + x2[i, k] < 2);
constraint forall(i, k in 1..n where i != k) (sum([x3[i, j, k] | j in 1..n]) < 2);

% Degrees of vertices and max/min degree
array [1..n] of var 0..n: degree;
var 1..n: min_deg;
var 1..n: max_deg;

% ceil(2 * m / n)
int: tmp = if 2 * m mod n = 0 then 2 * m div n else (2 * m div n) + 1 endif;

constraint 1 + min_deg * max_deg <= n;
constraint min_deg <= max_deg;
constraint min_deg >= m - f4[n - 1];
constraint max_deg >= tmp;

% Definition of degrees
constraint forall(i in 1..n) (degree[i] = sum([A[i, j] | j in 1..n]));
constraint forall(i in 1..n) (degree[i] <= max_deg);
constraint forall(i in 1..n) (degree[i] >= min_deg);
constraint forall(i in 1..n) (min_deg = min(degree));
constraint forall(i in 1..n) (max_deg = max(degree));
constraint sum(degree) = 2 * m;

% Fixed edge number
constraint sum(A) = 2 * m;

% Symmetry breaking

% BFS-tree parents
array [2..n] of var 1..n: p;

% BFS constraints
constraint forall(i in 2..n) (p[i] < i);
constraint forall(i in 1..n, j in 2..n) ((p[j] = i) <-> (A[i, j] = 1 /\ forall(k in 1..i - 1) (A[k, j] = 0)));
constraint forall(i in 2..n-1) (p[i] <= p[i + 1]);

% BFS weights of subtrees
array [1..n] of var 1..n: w;

constraint forall(i in 1..n) (w[i] <= n - i + 1);
constraint w[1] = n;
constraint forall(i in 2..n - 1) ((p[i] = p[i + 1]) -> (w[i] >= w[i + 1]));
constraint forall(i in 1..n) (w[i] = sum([bool2int(p[j] = i) * w[j] | j in 1..n where j > i]) + 1);

% (max_deg, min_deg - 1) star
%constraint degree[1] = max_deg;
%constraint forall(i in 1..max_deg) (degree[i + 1] = min_deg);

solve satisfy;

output [show((A[i, j])) ++ (if i = n then "\n" else " " endif) | j, i in 1..n]

















