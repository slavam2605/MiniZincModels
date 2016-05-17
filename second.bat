"C:\Program Files (x86)\MiniZinc IDE (bundled)\mzn2fzn.exe" Second.mzn -o Second.fzn -D"n = %*"
"C:\Program Files (x86)\MiniZinc IDE (bundled)\fzn-gecode.exe" -a Second.fzn
rm -f Second.fzn
