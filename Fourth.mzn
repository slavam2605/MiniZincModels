array [1..17] of int: f = [0, 0, 0, 3, 4, 6, 7, 9, 10, 12, 14, 16, 18, 21, 22, 24, 26];

% Number of vertices and edges
int: n = 11;
int: m = f[n];

% Adjacency matrix and auxiliary var arrays
array [1..n, 1..n] of var 0..1: A;

% A is symmetric with no loops
constraint forall(i, j in 1..n where i < j) (A[i, j] = A[j, i]);
constraint forall(i in 1..n) (A[i, i] = 0);

% No loops of length 3, 4, 5
constraint forall(i, j, k in 1..n where i != j /\ i != k /\ j != k ) 
              (A[i, j] + A[j, k] + A[k, i] < 3);
constraint forall(i, j, k, l in 1..n where i != j /\ i != k /\ i != l /\ j != k /\ j != l /\ k != l) 
              (A[i, j] + A[j, k] + A[k, l] + A[l, i] < 4);
constraint forall(i, j, k, l, o in 1..n where i != j /\ i != k /\ i != l /\ i != o /\ j != k /\ j != l /\ j != o /\ k != l /\ k != o /\ l != o) 
              (A[i, j] + A[j, k] + A[k, l] + A[l, o] + A[o, i] < 5);

% Degrees of vertices and max/min degree
array [1..n] of var 0..n: degree;
var 1..n: min_deg;
var 1..n: max_deg;

constraint min_deg <= max_deg;
constraint max_deg >= ceil(2 * m / n);
constraint min_deg <= floor(2 * m / n);

% Definition of degrees
constraint forall(i in 1..n) (degree[i] = sum([A[i, j] | j in 1..n]));
constraint forall(i in 1..n) (degree[i] <= max_deg);
constraint forall(i in 1..n) (degree[i] >= min_deg);
constraint forall(i in 1..n) (min_deg = min(degree));
constraint forall(i in 1..n) (max_deg = max(degree));

% Degree constraint 
constraint 1 + max_deg * min_deg + (min_deg - 1) * (min_deg - 1) <= n;

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

% Start vertex degree
constraint degree[1] = max_deg;

solve satisfy;

output [show((A[i, j])) ++ (if i = n then "\n" else " " endif) | j, i in 1..n]

















