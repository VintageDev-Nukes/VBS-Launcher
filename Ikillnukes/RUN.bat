@echo off
color 0A
title Launcher
Setlocal enabledelayedexpansion
For /F "tokens=2 delims=,=" %%# in ('WMIC MEMPHYSICAL get MaxCapacity /format:list') do (
	Set Bytes=%%#
	Set /A MB=!Bytes! / 16384
)
if not exist mem.txt (
set "mem=!mb!"
)
for /f "tokens=*" %%x in (mem.txt) do (
set "mem=%%x")
for /f "tokens=*" %%x in (user.txt) do (
set "user=%%x")
set "APPDATA=%APPDATA%\Ikillnukes\Roaming"
java  -Xincgc -Xmx%mem%m -cp "%APPDATA%\.minecraft\bin\minecraft.jar;%APPDATA%\.minecraft\bin\lwjgl.jar;%APPDATA%\.minecraft\bin\lwjgl_util.jar;%APPDATA%\.minecraft\bin\jinput.jar" -Djava.library.path="%APPDATA%\.minecraft\bin\natives" net.minecraft.client.Minecraft %user%
exit
