Set WshShell = WScript.CreateObject("WScript.Shell")

' Espera 2 segundos antes de executar (tempo para você focar na janela certa)
WScript.Sleep 2000

' Pressiona espaço
WshShell.SendKeys " "

' Espera 500 milissegundos
WScript.Sleep 500

' Pressiona ALT+TAB
WshShell.SendKeys "%{TAB}"
