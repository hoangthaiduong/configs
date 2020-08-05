git config --global core.autocrlf false
cp C:/cygwin64/home/User/.emacs ./emacs
cp C:/Users/User/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ./terminal
zip -r ./emacs/.emacs.d.zip C:/cygwin64/home/User/.emacs.d
git add -A .
set /p msg="Enter commit message: "
git commit -m "%msg%"
git push origin
