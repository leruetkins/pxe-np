:: @echo off
:: WebDAV адрес
set webdav=${url_dav}/strelec

:CheckNetwork
ping -n 2 ${server_ip} | find /i "TTL=" >nul
if %errorlevel%==1 (
    ping -n 5 127.0.0.1>NUL
    goto CheckNetwork
) else (

    :: Включаем поддержку Basic Auth для WebDAV
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient\Parameters" /v BasicAuthLevel /t REG_DWORD /d 2 /f
    
    :: Включаем поддержку 4 Гб для WebDAV
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient\Parameters" /v FileSizeLimitInBytes /t REG_DWORD /d 4294967295 /f
    
    net stop webclient
    net start webclient
    
    :: Подключаем WebDAV диск Z:
    net use Z: "%webdav%"
    ping -n 4 127.0.0.1>NUL
FOR %%i IN ( c d e f g h i j k l m n o p q r s t u v w y z) DO IF EXIST %%i:\SSTR\WLANProfile SET strelec=%%i:
start /w WLANDRIVER.exe
start %windir%\system32\MInstLink.exe
netcfg.exe -c s -i MS_Server
netcfg.exe -c p -i MS_NDISWAN
netcfg.exe -c p -i MS_NDISWANLEGACY
netcfg.exe -c s -i MS_RASMAN
netcfg.exe -c p -i MS_PPPOE
netcfg.exe -c p -i MS_NDISUIO
netcfg.exe -c s -i ms_nativewifip
netcfg.exe -c s -i ms_vwifi
netcfg.exe -c p -i ms_lltdio
netcfg.exe -c p -i ms_rspndr
netcfg.exe -c p -i ms_lldp
Reg Add "HKLM\SYSTEM\Setup" /v "SystemSetupInProgress" /t REG_DWORD /d "0x0" /f
net start dhcp
net start wcmsvc
net start LanmanServer
net start netprofm
net start MpsSvc
net start Netman
net start nlasvc
net start Server
net start mpssvc
net start RasMan
net start RasAuto
net start wlansvc
net start fdPHost
Reg Add "HKLM\SYSTEM\Setup" /v "SystemSetupInProgress" /t REG_DWORD /d "0x1" /f
wpeutil DisableFirewall
rem wpeutil UpdateBootInfo
FOR /F "tokens=3* delims= " %%i in ('reg query HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardManufacturer') DO (SET BaseBoardManufacturer=%%i)
FOR /F "tokens=3* delims= " %%i in ('reg query HKLM\HARDWARE\DESCRIPTION\System\BIOS /v BaseBoardProduct') DO (SET BaseBoardProduct=%%i)
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /t REG_SZ /v Manufacturer /d "%BaseBoardManufacturer%" /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /t REG_SZ /v Model /d "%BaseBoardProduct%" /f
start /b /wait Reg Add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d "0x00000002" /f
start /b Reg Add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d "0x00000000" /f
cd /D "%strelec%\SSTR\WLANProfile"
for /f "tokens=*" %%i in ('dir /b') do netsh.exe wlan add profile filename="%%i" user=all
exit
)
