@echo off
set CYGWIN
set CYGWIN=%CYGWIN%;nodosfilewarning
bin\wget --no-check-certificate -O "%APPDATA%\Ikillnukes\link.txt" http://deadfrontier-esp.foroactivo.com/h6-link

for /f "tokens=*" %%x in (link.txt) do (
set "descarga=%%x")
set CYGWIN
set CYGWIN=%CYGWIN%;nodosfilewarning
bin\wget --no-check-certificate -O "%APPDATA%\Ikillnukes\RELEASES\HugeCraft.exe" %descarga%
start "%APPDATA%\Ikillnukes\RELEASES\HugeCraft.exe"
exit