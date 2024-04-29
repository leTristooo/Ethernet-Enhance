@echo off
title Network Tweaks for Lower Ping

echo Tweaking Network and Ethernet Settings for Lower Ping...
echo.

:: Disable Nagle's Algorithm
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f
echo Nagle's Algorithm disabled. [1]
echo.

:: Increase Network Throttling Index
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
echo Network Throttling Index increased. [2]
echo.

:: Optimize TCP/IP Settings
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set global ecncapability=enabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global initialRto=2000
netsh int tcp set global maxSynRetransmissions=2
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global chimney=disabled
echo TCP/IP Settings optimized. [3] [4]
echo.

:: Disable Large Send Offload
netsh int tcp set global lso=disabled
echo Large Send Offload disabled. [5]
echo.

:: Disable Receive Side Scaling
netsh int tcp set global rss=disabled
echo Receive Side Scaling disabled. [6]
echo.

:: Disable Packet Coalescing
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisablePacketCoalescing /t REG_DWORD /d 1 /f
echo Packet Coalescing disabled. [7]
echo.

:: Flush DNS Cache
ipconfig /flushdns
echo DNS Cache flushed.
echo.

echo Network and Ethernet tweaks applied for lower ping.
pause
