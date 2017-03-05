prueba = msgbox("¿Eres premium en Minecraft? (¿Tienes comprado el juego?)",vbYesNo,"¿Eres premium?") 
 
Select Case prueba 
Case vbYes 
CreateObject("Wscript.Shell").Run "launcher-download.bat yes", 0 
Case vbNo 
CreateObject("Wscript.Shell").Run "launcher-download.bat no", 0 
End Select 
