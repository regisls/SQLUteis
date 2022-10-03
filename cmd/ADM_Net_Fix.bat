@echo off

net start spooler
ipconfig /release
ipconfig /renew
ipconfig /flushdns
Netsh winsock reset
net localgroup administradores localservice /add
fsutil resource setautoreset true C:\
netsh int ip reset resetlog.txt
netsh winsock reset all
netsh int 6to4 reset all
Netsh int ip reset all
netsh int ipv4 reset all
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
Netsh int ip reset
Netsh winsock reset
net start bits
net start wuauserv
net start cryptsvc
net start MSIServer
Sfc /ScanNow
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
Net Stop MpsSvc
Net Start MpsSvc
net start spooler
Sc config wuauserv start= auto
Sc config bits start= auto
Sc config cryptsvc start= auto
Sc config trustedinstaller start= auto
echo ---PRESSIONE ENTER PARA FINALIZAR---

PAUSE
