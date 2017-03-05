@echo off
:INICIO
echo Bienvenido a la descarga del ModPack de Ikillnukes. Por favor, seleccione numericamente (0 o 1) su opcion:
echo.
echo Que desea hacer?
echo.
echo 0.- Descargar el instalador del cliente del ModPack
echo 1.- Descargar el servidor del ModPack
echo 2.- Salir
echo.
set /p selecc=">> "
if not defined selecc goto:INICIO
if "%selecc%"=="0" goto:CLIENTE
if "%selecc%"=="1" goto:SERVER
if "%selecc%"=="2" EXIT

:CLIENTE
cls
set SCRIPT="launcher-download.bat"
set SCRIPT1="premium.vbs"
(
echo @echo off
echo if "%%1"=="yes" set sitio=:Premium
echo if "%%1"=="no" set sitio=:Pirata
echo.
echo md "%%APPDATA%%\.minecraft\ikill-tools\"
echo xcopy *.dll "%%APPDATA%%\.minecraft\ikill-tools\" /y
echo xcopy *.exe "%%APPDATA%%\.minecraft\ikill-tools\" /y
echo set SCRIPT="%%APPDATA%%\.minecraft\ikill-tools\test.vbs"
echo set SCRIPT1="%%APPDATA%%\.minecraft\ikill-tools\launcher.bat"
echo set SCRIPT2="%%APPDATA%%\.minecraft\ikill-tools\updater.bat"
echo set SCRIPT3="%%APPDATA%%\.minecraft\ikill-tools\updater.vbs"
echo echo Creando el Launcher.
echo ::Aquí irian las funciones
echo ^(
echo echo @echo off
echo echo set txtfile^^="upt.txt"
echo echo set upt^^=1
echo echo "%%%%~d0%%%%~p0wget.exe" "http://nexusplayers.x10host.com/upt.txt" --output-document^^=%%%%txtfile%%%%
echo echo for /f "skip=1tokens=1*delims=:" %%%%%%%%i in ^^^(^^^'findstr /N "^" %%%%txtfile%%%%^^^'^^^) do ^^^(if not defined version set "version=%%%%%%%%j"^^^)
echo echo if %%%%version%%%%^^=^^=%%%%upt%%%% ^^^(goto:Launch^^^) else ^^^(goto:Update^^^)
echo echo.
echo echo :Update
echo echo del %%%%txtfile%%%%
echo echo cscript /nologo %%SCRIPT3%%
echo echo exit
echo ^) ^> %%SCRIPT1%%
echo goto %%sitio%%
echo.
echo :Premium
echo ^(
echo echo.
echo echo :Launch
echo echo del %%%%txtfile%%%%
echo echo cd "%%APPDATA%%\.minecraft\"
echo echo start premium.exe
echo echo exit
echo ^) ^>^> %%SCRIPT1%%
echo wget "http://s3.amazonaws.com/Minecraft.Download/launcher/Minecraft.exe" --output-document="%%APPDATA%%\.minecraft\premium.exe"
echo set zona="%%APPDATA%%\.minecraft\premium.exe"
echo goto:AMB
echo.
echo :Pirata
echo ^(
echo echo.
echo echo del %%%%txtfile%%%%
echo echo :Launch
echo echo cd "%%APPDATA%%\.minecraft\"
echo echo start pirata.jar
echo echo exit
echo ^) ^>^> %%SCRIPT1%%
echo wget "http://mineshafter.info/s/Mineshafter-launcher.jar" --output-document="%%APPDATA%%\.minecraft\pirata.jar"
echo set zona="%%APPDATA%%\.minecraft\pirata.jar"
echo goto:AMB
echo.
echo :AMB
echo cls
echo echo Creando acceso directo.
echo echo.
echo echo Set oWS = WScript.CreateObject^("WScript.Shell"^) ^> %%SCRIPT%%
echo echo sLinkFile = "%%USERPROFILE%%\Desktop\The Grand ModPack.lnk" ^>^> %%SCRIPT%%
echo echo Set oLink = oWS.CreateShortcut^(sLinkFile^) ^>^> %%SCRIPT%%
echo echo oLink.TargetPath = "%%APPDATA%%\.minecraft\ikill-tools\launcher.bat" ^>^> %%SCRIPT%%
echo echo oLink.Save ^>^> %%SCRIPT%%
echo.
echo cscript /nologo %%SCRIPT%%
echo del %%SCRIPT%%
echo.
echo ^(
echo echo @echo off
echo echo echo Actualizando...
echo echo for /f "skip=2tokens=1*delims=:" %%%%%%%%i in ^^^(^^^'findstr /N "^" %%%%txtfile%%%%^^^'^^^) do ^^^(if not defined download set "download=%%%%%%%%j"^^^)
echo echo wget %%%%download%%%% --output-document^^="%%%%APPDATA%%%%\cliente.zip\"
echo ^) ^> %%SCRIPT2%%
echo.
echo echo prueba = msgbox^("¿Deseas actualizar el Pack de Mods?",vbYesNo,"¿Actualizas?"^) ^> %%SCRIPT3%%
echo echo. ^>^> %%SCRIPT3%%
echo echo Select Case prueba ^>^> %%SCRIPT3%%
echo echo Case vbYes ^>^> %%SCRIPT3%%
echo echo 	CreateObject^("Wscript.Shell"^).Run "updater.bat",0 ^>^> %%SCRIPT3%%
echo echo Case vbNo ^>^> %%SCRIPT3%%
echo echo    CreateObject^("Wscript.Shell"^).Run %%zona%%,0 ^>^> %%SCRIPT3%%
echo echo End Select ^>^> %%SCRIPT3%%
echo.
echo exit
) > %SCRIPT%
echo prueba = msgbox("¿Eres premium en Minecraft? (¿Tienes comprado el juego?)",vbYesNo,"¿Eres premium?") > %SCRIPT1%
echo. >> %SCRIPT1%
echo Select Case prueba >> %SCRIPT1%
echo Case vbYes >> %SCRIPT1%
echo CreateObject("Wscript.Shell").Run "launcher-download.bat yes", 0 >> %SCRIPT1%
echo Case vbNo >> %SCRIPT1%
echo CreateObject("Wscript.Shell").Run "launcher-download.bat no", 0 >> %SCRIPT1%
echo End Select >> %SCRIPT1%
cls
echo Espere unos instantes mientras que su instalador se descarga.
cscript /nologo "premium.vbs"
wget -O %APPDATA%\cliente.zip "http://download1980.mediafire.com/1fa824aqhctg/cwvs1treh2yl3lx/Minecraft+Ikillnukes+ModPacks.zip"
cd "%APPDATA%"
"%~d0%~p07z.exe" X cliente.zip
del %SCRIPT%
del %SCRIPT1%
exit

:SERVER
cls
echo Espere mientras que se descarga el servidor.
wget -O %USERPROFILE%\Ikillnukes\The GrandModPack\Server\ "http://download1335.mediafire.com/h8sg4m8sbxyg/4ybhqt0gfrc4jr8/Server+ModPack+Ikillnukes.zip"
start %USERPROFILE%\Ikillnukes\The GrandModPack\Server\
exit