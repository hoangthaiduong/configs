git config --global core.autocrlf false
cp C:/cygwin64/home/User/.emacs ./emacs
cp %USERPROFILE%/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ./terminal
cp %USERPROFILE%/AppData/Roaming/doublecmd/doublecmd.xml ./doublecmd
cp %USERPROFILE%/AppData/Roaming/Code/User/settings.json ./vscode
cp %USERPROFILE%/scoop/apps/keypirinha/current/portable/Profile/User/Keypirinha.ini ./keypirinha
zip -r ./emacs/.emacs.d.zip C:/cygwin64/home/User/.emacs.d
git add -A .
set /p msg="Enter commit message: "
git commit -m "%msg%"
git push origin
