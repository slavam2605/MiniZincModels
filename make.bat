"C:\Program Files (x86)\MiniZinc IDE (bundled)\mzn2fzn.exe" First.mzn -D"n = %*" -o First.fzn
ptime "C:\Program Files (x86)\MiniZinc IDE (bundled)\fzn-gecode.exe" First.fzn
rm -f First.fzn
