@echo off
set /a count=6
set txtfile="abc.txt"
if defined count for /f "skip=%count%tokens=1*delims=:" %%i in ('findstr /N "^" %txtfile%') do if not defined value set "value=%%j"
echo %value%
pause