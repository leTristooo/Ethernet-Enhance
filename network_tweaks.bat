@echo off
title Network Tweaks

echo Tweaking Network and Ethernet Settings...
echo.

:: Disable Nagle's Algorithm
for /f "tokens=1-3 delims= " %%a in ('netsh interface ipv4 show interfaces') do (
    if not "%%c"=="" (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%c" /v TcpAckFrequency /t REG_DWORD /d 1 /f
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%c" /v TCPNoDelay /t REG_DWORD /d 1 /f
    )
)
echo Nagle's Algorithm disabled.
echo.

:: Increase Network Throttling Index
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
echo Network Throttling Index increased.
echo.

:: Optimize TCP/IP Settings
netsh int tcp set global autotuninglevel=normal ecncapability=disabled timestamps=disabled
netsh int tcp set supplemental internet congestionprovider=ctcp
echo TCP/IP Settings optimized.
echo.

:: Flush DNS Cache
ipconfig /flushdns
echo DNS Cache flushed.
echo.

echo Network and Ethernet tweaks applied.
pause

