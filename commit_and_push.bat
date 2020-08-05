git config --global core.autocrlf false
cp C:/cygwin64/home/User/.emacs ./emacs
cp C:/Users/User/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ./terminal
git add -u .
set /p msg="Enter commit message: "
git commit -m "%msg%"
