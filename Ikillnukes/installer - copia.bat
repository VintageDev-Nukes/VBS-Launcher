@echo off
:INST
If Not Exist "%UserProfile%\Desktop\" (Set "DesktopPath=%UserProfile%\Escritorio")
If Not Exist "%UserProfile%\Escritorio\" (Set "DesktopPath=%UserProfile%\Desktop")
copy /y "%APPDATA%\Ikillnukes\HugeCraft.lnk" "%desktoppath%"
copy /y "%APPDATA%\Ikillnukes\HugeCraft-Snapshots.url" "%desktoppath%"
del installer.bat
del HugeCraft.lnk
exit