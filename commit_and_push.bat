git config --global core.autocrlf false
cp C:/cygwin64/home/User/.emacs .
git add -u .
set /p msg="Enter commit message: "
git commit -m "%msg%"
