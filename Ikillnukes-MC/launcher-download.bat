@echo off
if "%1"=="yes" set sitio=:Premium
if "%1"=="no" set sitio=:Pirata

md "%APPDATA%\.minecraft\ikill-tools\"
xcopy *.dll "%APPDATA%\.minecraft\ikill-tools\" /y
xcopy *.exe "%APPDATA%\.minecraft\ikill-tools\" /y
set SCRIPT="%APPDATA%\.minecraft\ikill-tools\test.vbs"
set SCRIPT1="%APPDATA%\.minecraft\ikill-tools\launcher.bat"
set SCRIPT2="%APPDATA%\.minecraft\ikill-tools\updater.bat"
set SCRIPT3="%APPDATA%\.minecraft\ikill-tools\updater.vbs"
echo Creando el Launcher.
::Aquí irian las funciones
(
echo @echo off
echo set txtfile^="upt.txt"
echo set upt^=1
echo "%%~d0%%~p0wget.exe" "http://nexusplayers.x10host.com/upt.txt" --output-document^=%%txtfile%%
echo for /f "skip=1tokens=1*delims=:" %%%%i in ^(^'findstr /N "^" %%txtfile%%^'^) do ^(if not defined version set "version=%%%%j"^)
echo if %%version%%^=^=%%upt%% ^(goto:Launch^) else ^(goto:Update^)
echo.
echo :Update
echo del %%txtfile%%
echo cscript /nologo %SCRIPT3%
echo exit
) > %SCRIPT1%
goto %sitio%

:Premium
(
echo.
echo :Launch
echo del %%txtfile%%
echo cd "%APPDATA%\.minecraft\"
echo start premium.exe
echo exit
) >> %SCRIPT1%
wget "http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.exe" --output-document="%APPDATA%\.minecraft\premium.exe"
set zona="%APPDATA%\.minecraft\premium.exe"
goto:AMB

:Pirata
(
echo.
echo del %%txtfile%%
echo :Launch
echo cd "%APPDATA%\.minecraft\"
echo start pirata.jar
echo exit
) >> %SCRIPT1%
wget "http://mineshafter.info/s/Mineshafter-launcher.jar" --output-document="%APPDATA%\.minecraft\pirata.jar"
set zona="%APPDATA%\.minecraft\pirata.jar"
goto:AMB

:AMB
cls
echo Creando acceso directo.
echo.
echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\The Grand ModPack.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%APPDATA%\.minecraft\ikill-tools\launcher.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

(
echo @echo off
echo echo Actualizando...
echo for /f "skip=2tokens=1*delims=:" %%%%i in ^(^'findstr /N "^" %%txtfile%%^'^) do ^(if not defined download set "download=%%%%j"^)
echo wget %%download%% --output-document^="%%APPDATA%%\cliente.zip\"
) > %SCRIPT2%

echo prueba = msgbox("¿Deseas actualizar el Pack de Mods?",vbYesNo,"¿Actualizas?") > %SCRIPT3%
echo. >> %SCRIPT3%
echo Select Case prueba >> %SCRIPT3%
echo Case vbYes >> %SCRIPT3%
echo 	CreateObject("Wscript.Shell").Run "updater.bat",0 >> %SCRIPT3%
echo Case vbNo >> %SCRIPT3%
echo    CreateObject("Wscript.Shell").Run %zona%,0 >> %SCRIPT3%
echo End Select >> %SCRIPT3%

exit
