@echo off
title Revert Network Tweaks

echo Reverting Network and Ethernet Settings...
echo.

:: Re-enable Nagle's Algorithm
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /f
echo Nagle's Algorithm re-enabled.
echo.

:: Reset Network Throttling Index to default value
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f
echo Network Throttling Index reset to default.
echo.

:: Reset TCP/IP Settings to default
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global congestionprovider=default
netsh int tcp set global ecncapability=default
netsh int tcp set global timestamps=default
netsh int tcp set global chimney=disabled
echo TCP/IP Settings reset to default.
echo.

echo Network and Ethernet tweaks reverted.
pause
