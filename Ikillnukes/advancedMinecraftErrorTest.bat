@ECHO OFF
:: This nice an advanced minecraft error test, is brought to you by theFriedZombie from MesiaPK gaming
:: Please do not rehost elsewhere and modify branding

:: This is version V1.1
setlocal enabledelayedexpansion

echo [spoiler][code]
call :start
echo.
echo ==Computer info==
echo.
call :bios "SystemManufacturer"
call :bios "SystemProductName"
call :bios "SystemFamily"
call :bios "SystemVersion"
echo Processor: %PROCESSOR_IDENTIFIER%
FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic computersystem get NumberOfProcessors /value') DO echo NumberOfProcessors: %%A

echo.
call :memory
echo.
call :windows "ProductName"
set winVer=%RETURN%
call :windows "CSDVersion"
set winVer=%winVer%, %RETURN%
set osBit=32
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set osBit=64
echo OS: %winVer%, %osBit%bits
echo.
echo userprofile: %userprofile%
echo %userprofile% | findstr !  > nul 2>&1
if %errorlevel%==0 (
echo Your user profile name has an "!" in it, java doesn't like that
echo. 
echo Aborting script now.
goto end
)
echo.
echo ==Video controller info==
call :video
echo Tip of the day: http://www.pcidatabase.com/
echo great source for looking up unkown devices
echo.
echo ==Java info==
echo.
call :java || (
echo Issue detected with java, ending script now!
goto end
)


echo.
echo ==Minecraft pre-tests==
echo.
set logReach=1
call :login login.minecraft.net || ( set logREach=0 )
call :login session.minecraft.net || ( set logReach=0 )
if %logReach%==0 (
echo   Make sure your internet connection is working,
echo   and no firewall or virus scanner is interfering with the connection.
call :login www.google.com
)

echo.
if not exist "%appdata%\.minecraft\" (
echo Warning: the directory "%appdata%\.minecraft\" does not exist
if "%~1"=="" goto exe
)
dir /s /b "%appdata%\.minecraft\*.class" > nul 2>&1
if %errorlevel%==0 (
echo.
echo Warning: class files found within the minecraft directory!
echo  They can cause for issues while starting minecraft.
echo  Did you unpack a jar file?
echo  The explorer extension binding can tell that the jar was zip
echo  But it is really not a zip!
echo.
echo continuing anyway
)
if not "%~1"=="" goto custom

if not exist "%appdata%\.minecraft\bin\minecraft.jar" (
echo Warning: "the file %appdata%\.minecraft\bin\minecraft.jar" does not exists
if exist "%appdata%\.minecraft\bin\minecraft.zip" (
echo %appdata%\.minecraft\bin\minecraft.zip, was found
echo it can be that the file was saved to zip by accident
echo Internet explorer sometimes does that
echo Try renaming it to minecraft.jar
)
goto exe
)

echo Trying to start the minecraft.jar
echo ==End of pre-tests and info, minecraft starts here==
echo.
java  -Xincgc -Xmx1024m -cp "%APPDATA%\.minecraft\bin\minecraft.jar;%APPDATA%\.minecraft\bin\lwjgl.jar;%APPDATA%\.minecraft\bin\lwjgl_util.jar;%APPDATA%\.minecraft\bin\jinput.jar" -Djava.library.path="%APPDATA%\.minecraft\bin\natives" net.minecraft.client.Minecraft player

goto end
exit /b 0

:custom
echo Trying to start "%~1"
echo ==End of pre-tests and info, minecraft starts here==
java  -Xincgc -Xmx1024m -jar "%~1"
goto end

:exe
if exist minecraft.exe (
echo Trying to start the minecraft.exe
echo ==End of pre-tests and info, minecraft starts here==
echo.
java -Xincgc -Xmx1024m -jar minecraft.exe
) else (
echo.
echo The minecraft.exe can not be found in the current directory.
echo Put the minecraft.exe in the same directory as this batch script!
echo and run the batch again.
echo Or drag the minecraft.exe on top of this batch file
)
:end
echo.
echo ==End of script==
echo.
echo.
echo Right click, Select all, 
echo Press Enter (This will copy the output to your clipboard). 
echo Then paste the result on http://www.pastebin.com
echo Or your favourite forum.
echo.
echo ===========Brought to you by============
echo ===theFriedZombie from MesiaPK Gaming===
echo http://www.mesiapk.com
echo [/code][/spoiler]
copy con nul
exit /b 0


:: End of the simple batch stuff!
:login <value>
setlocal
SET value=%1
ping -w 10 -n 1 %value% 2>&1 | findstr "Pinging" > nul 2>&1
if %errorlevel%==0 (
echo %value% resolvable? YES
) else (
echo %value% resolvable? NO
exit /b 1
)
endlocal
exit /b 0


:java
setlocal
echo Java location according to the path variable:
where java.exe 2> nul
echo.
java -version 2> nul
if %errorlevel%==9009 (
  echo can execute java? NO
  exit /b 1
) else (
  echo can execute java? YES
)
echo.
java -version 2>&1 | findstr "64-Bit" > nul 2>&1
if %errorlevel%==0 (
echo java is 64 bit
) else (
echo java is 32 bit
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" Echo Warning: 64Bit java is recommended, on this machine!
)
echo.
java -version 
)

endlocal
exit /b 0

:video
setlocal
wmic /namespace:\\root\cimv2 path Win32_VideoController get Caption, Description, DriverVersion, InstalledDisplayDrivers, Name, PNPDeviceID, Status, StatusInfo, ConfigManagerErrorCode /value

endlocal
exit /b 0
:start
setlocal
title ==Advanced Minecraft error test V1.0== - by theFriedZombie from MesiaPK gaming
echo ==Advanced Minecraft error test v1.0== - by theFriedZombie
endlocal
exit /b 0
:memory
setlocal
FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic memorychip GET Capacity /VALUE 2^>nul') DO CALL :memInstall %%A
set memInst=%SLO1%
FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic computersystem get TotalPhysicalMemory /VALUE') DO CALL :memCalc %%A
set memAvail=%RETURN%
FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic os get FreePhysicalMemory /VALUE') DO set memFree=%%A
set /A memFree=%memFree:~0,-1%/1024

FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic pagefile get AllocatedBaseSize /VALUE') DO set virtAlloc=%%A
FOR /F "TOKENS=2 DELIMS==" %%A IN ('wmic os get FreeVirtualMemory /VALUE') DO set virtFree=%%A
set /A virtFree=%virtFree:~0,-1%/1024

echo Physical memory: %memInst% MB installed, %memAvail% MB available, %memFree% MB free
echo Virtual  memory: %virtAlloc% MB allocated, %virtFree% MB free

endlocal
exit /b 0

:memCalc <value>
setlocal
SET value=%1
set /A data=%value:~0,-1%/104857
endlocal & set RETURN=%data%
exit /b 0

:memInstall <value>
SET SLO=%1
SET/A SLO=%SLO:~0,-1%/104857
SET/A SLO1=SLO1+SLO
exit /b 0

::functions and other stuff down here
:windows <value>
setlocal
set TESTK1=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion
set TESTK2=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion
set TESTV=%~1
call :reg_read "%TESTK1%" "%TESTV%" || (
call :reg_read "%TESTK2%" "%TESTV%" || (set RETURN=)
)
set data=%RETURN%
endlocal & set RETURN=%data%
exit /b 0

:bios <value>
setlocal
set TESTK=HKLM\HARDWARE\DESCRIPTION\System\BIOS
set TESTV=%~1
call :reg_read "%TESTK%" "%TESTV%" || (set RETURN=Unkown)
echo %TESTV%: %RETURN%
endlocal
exit /b 0

:reg_read <key> <value>
setlocal

set key=%~1
set value=%~2

reg query "%key%" /v "%value%" 1>nul 2>&1 || (exit /b 1)

for /f "tokens=2,*" %%a in ('reg query "%key%" /v "%value%" ^| findstr /c:"%value%"') do (
set data=%%b
)

if "%data%"=="" (endlocal & exit /b 1)

endlocal & set RETURN=%data%
exit /b 0