@echo off
title Network Tweaks

echo Tweaking Network and Ethernet Settings...
echo.

:: Disable Nagle's Algorithm
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f
echo Nagle's Algorithm disabled.
echo.

:: Increase Network Throttling Index
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
echo Network Throttling Index increased.
echo.

:: Optimize TCP/IP Settings
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global chimney=enabled
echo TCP/IP Settings optimized.
echo.

:: Flush DNS Cache
ipconfig /flushdns
echo DNS Cache flushed.
echo.

echo Network and Ethernet tweaks applied.
pause
