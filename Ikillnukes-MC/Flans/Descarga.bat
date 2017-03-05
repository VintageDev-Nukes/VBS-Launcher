@echo off

set url=%APPDATA%\.minecraft
IF EXIST "%url%\mods\" ( ren "%appdata%\.minecraft\mods\" old-mods )
IF EXIST "%url%\Flan\" ( ren "%appdata%\.minecraft\Flan\" old-Flan )
IF NOT EXIST "%url%\" ( md "%url%\" )
IF NOT EXIST "%url%\mods\" ( md "%url%\mods\" )
IF NOT EXIST "%url%\Flan\" ( md "%url%\Flan\" )
IF NOT EXIST "%url%\versions\Ikillnukes-MC\" ( md "%url%\versions\Ikillnukes-MC\" )
IF NOT EXIST "%url%\libraries\net\minecraftforge\minecraftforge\9.10.1.852\" ( md "%url%\libraries\net\minecraftforge\minecraftforge\9.10.1.852\" )

wget -O "%url%\mods\FlansMod-3.0.1.jar" "http://download887.mediafire.com/dppop44ofzug/x23a1ifz4fitn67/FlansMod-3.0.1.jar"
wget -O "%url%\mods\NotEnoughItems 1.6.1.3.jar" "http://download1846.mediafire.com/kuzmcsediqog/62wj64pujemddel/NotEnoughItems+1.6.1.3.jar"
wget -O "%url%\mods\OptiFine_1.6.2_HD_U_C4.jar" "http://download1395.mediafire.com/yvzha4wseepg/6c67pcc3094al58/OptiFine_1.6.2_HD_U_C4.jar"
wget -O "%url%\mods\1.6.2 DamageIndicators v2.9.0.0.zip" "http://download2171.mediafire.com/qm5jaqetipng/2v01ui54ojltazt/1.6.2+DamageIndicators+v2.9.0.0.zip"
wget -O "%url%\mods\[1.6.2]ReiMinimap_v3.4_01.zip" "http://download1112.mediafire.com/w3tek7dytteg/jdsgpras3qoelsl/%5B1.6.2%5DReiMinimap_v3.4_01.zip"
wget -O "%url%\mods\InventoryTweaks-MC1.6.2-1.56-b77.jar" "http://download38.mediafire.com/9nka1x51dwsg/q61x4q1kv1do3oa/InventoryTweaks-MC1.6.2-1.56-b77.jar"
wget -O "%url%\mods\CodeChickenCore 0.9.0.5.jar" "http://download1281.mediafire.com/dly19lxzpiag/4ucuhaltxfgpju1/CodeChickenCore+0.9.0.5.jar"
wget -O "%url%\mods\[1.6.2]bspkrsCorev3.03.zip" "http://download758.mediafire.com/ac8g39cm435g/31m0rgcwr233bu1/%5B1.6.2%5DbspkrsCorev3.03.zip"
wget -O "%url%\mods\[1.6.2]ArmorStatusHUDv1.12.zip" "http://download1991.mediafire.com/7t4yzngabxmg/1b1asksmg4r3baj/%5B1.6.2%5DArmorStatusHUDv1.12.zip"
wget -O "%url%\mods\DynamicLights_1.6.2.jar" "http://download1497.mediafire.com/4ia2w2usgq1g/9r7db4adx0i1vh2/DynamicLights_1.6.2.jar"
wget -O "%url%\Flan\Ye Olde Pack  3.0 for Flans Mod 3.0.zip" "http://download1176.mediafire.com/fxfo1ljx9dng/eeph665phje09xr/Ye+Olde+Pack++3.0+for+Flans+Mod+3.0.zip"
wget -O "%url%\Flan\WW2 Pack  3.0 for Flans Mod 3.0.zip" "http://download800.mediafire.com/24727aqiauug/5a1kssg6a546w05/WW2+Pack++3.0+for+Flans+Mod+3.0.zip"
wget -O "%url%\Flan\Modern Weapons Pack 3.0 for Flans Mod 3.0.zip" "http://download1956.mediafire.com/c88ij9jffmrg/aj5det5hzdo40tz/Modern+Weapons+Pack+3.0+for+Flans+Mod+3.0.zip"
wget -O "%url%\Flan\Parts Pack  3.0 for Flans Mod 3.0.zip" "http://download1126.mediafire.com/t2ymjff690ug/7v3cejp2e5pwz9g/Parts+Pack++3.0+for+Flans+Mod+3.0.zip"
wget -O "%url%\libraries\net\minecraftforge\minecraftforge\9.10.1.852\minecraftforge-9.10.1.852.jar" "http://download1474.mediafire.com/54twbs7g5olg/xt2y9rw3c8pb8e6/minecraftforge-9.10.1.852.jar"
wget -O "%url%\versions\Ikillnukes-MC\Ikillnukes-MC.jar" "http://download2174.mediafire.com/c38b1xnnzcvg/afmchcznmropgoy/Ikillnukes-MC.jar"
wget -O "%url%\versions\Ikillnukes-MC\Ikillnukes-MC.json" "http://download944.mediafire.com/rap5mkqb77eg/4a4vwe4uphjosjc/Ikillnukes-MC.json"
cls

set SCRIPT2=%url%\launcher_profiles.json

IF EXIST %SCRIPT2% (
setlocal EnableDelayedExpansion
set i=0
for /F "skip=2tokens=1*delims=:" %%a in ('findstr /N "^" "%SCRIPT2%"') do (
   set /A i+=1
   set array[!i!]=%%b
)
set n=%i%

setlocal DisableDelayedExpansion
echo { > %SCRIPT2%
echo   "profiles": { >> %SCRIPT2%
echo     "The Grand ModPack": { >> %SCRIPT2%
echo      "name": "The Grand ModPack", >> %SCRIPT2%
echo      "lastVersionId": "Ikillnukes-MC", >> %SCRIPT2%
echo      "playerUUID": "287636ddc6af4fad804c2da84585f48b" >> %SCRIPT2% 
echo    },  >> %SCRIPT2%
cls
setlocal EnableDelayedExpansion
for /L %%j in (1,1,%n%) do echo !array[%%j]! >> %SCRIPT2%
setlocal DisableDelayedExpansion
exit
) ELSE (
wget -O %SCRIPT2% "http://nexusplayers.x10host.com/launcher_profiles.json"
exit
)
exit