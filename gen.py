import sys

N = int(sys.argv[1])
m = int(sys.argv[2])
n = int(sys.argv[3])

def get(i, j):
	if (i < j):
		return get(j, i)
	if (i == j): 
		return 0
	if (i > m * (n + 1) + 1):
		return 2
	if (i > m + 1):
		if ((i - m - 2) // n == (j - m - 2) // n):
			return 0
	if (j == 1):
		if (i >= 2 and i <= m + 1):
			return 1
		else:
			return 0
	if (j >= 2 and j <= m + 1):
		if ((i - m - 2) // n == j - 2):
			return 1
		else:
			return 0
	return 2

s = "CA = ["
for i in range(1, N + 1):
	if (i > 1):
		s += "      "
	s += "| "
	for j in range(1, N + 1):
		s += str(get(i, j)) + ", "
	s += "\n"
s += "      |];"
print(s)
