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
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f
echo Network Throttling Index reset to default.
echo.

:: Reset TCP/IP Settings to default
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global congestionprovider=default
netsh int tcp set global ecncapability=default
netsh int tcp set global timestamps=default
netsh int tcp set global initialRto=default
netsh int tcp set global maxSynRetransmissions=default
netsh int tcp set global nonsackrttresiliency=default
netsh int tcp set global rsc=default
netsh int tcp set global chimney=disabled
echo TCP/IP Settings reset to default.
echo.

:: Enable Large Send Offload
netsh int tcp set global lso=enabled
echo Large Send Offload enabled.
echo.

:: Enable Receive Side Scaling
netsh int tcp set global rss=enabled
echo Receive Side Scaling enabled.
echo.

:: Enable Packet Coalescing
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisablePacketCoalescing /f
echo Packet Coalescing enabled.
echo.

:: Flush DNS Cache
ipconfig /flushdns
echo DNS Cache flushed.
echo.

echo Network and Ethernet tweaks reverted.
pause
