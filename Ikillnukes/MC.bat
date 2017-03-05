@echo off
color 0A
title Launcher
:UPT
echo Espera un momento se esta comprobando la version de tu Launcher...
echo.
set CYGWIN
set CYGWIN=%CYGWIN%;nodosfilewarning
bin\wget --no-check-certificate -O "%APPDATA%\Ikillnukes\cheker.txt" http://deadfrontier-esp.foroactivo.com/h5-test

:UPDATE
cls
find /i "4547" "cheker.txt"
if %errorlevel%==0 (goto:SETUP) else (goto:UPT666)

if not exist recovery.txt (
start UPT.hta
)
if exist recovery.txt (
goto:SETUP
)

:UPT666
start UPT.hta
exit

:SETUP
start RUN.hta
exit