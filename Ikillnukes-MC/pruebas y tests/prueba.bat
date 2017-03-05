@echo off
:Hola
set /p selecc=">> "
if not defined selecc set sitio=:Hola
if "%selecc%"=="0" set sitio=:Adios
if "%selecc%"=="1" set sitio=:Jaja
if "%selecc%"=="2" EXIT
goto %sitio%

:Adios
cls
echo adios.
pause
exit

:Jaja
cls
echo jaja.
pause
exit