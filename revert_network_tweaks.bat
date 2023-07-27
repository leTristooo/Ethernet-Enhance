@echo off
title Revert Network Tweaks

echo Reverting Network and Ethernet Settings...
echo.

:: Re-enable Nagle's Algorithm
for /f "tokens=1-3 delims= " %%a in ('netsh interface ipv4 show interfaces') do (
    if not "%%c"=="" (
        reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%c" /v TcpAckFrequency /f
        reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%%c" /v TCPNoDelay /f
    )
)
echo Nagle's Algorithm re-enabled.
echo.

:: Reset Network Throttling Index to default value
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f
echo Network Throttling Index reset to default.
echo.

:: Reset TCP/IP Settings to default
netsh int tcp set global autotuninglevel=normal ecncapability=default timestamps=default
netsh int tcp set supplemental internet congestionprovider=default
echo TCP/IP Settings reset to default.
echo.

:: Flush DNS Cache
ipconfig /flushdns
echo DNS Cache flushed.
echo.

echo Network and Ethernet tweaks reverted.
pause

