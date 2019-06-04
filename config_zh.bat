rem - Encoding:gb2312; Mode:Batch; Language:zh-CN; LineEndings:CRLF -
:: You-Get(��ɫ��) ���ýű�
:: Author: Lussac
:: Version: embed-0.2.1
:: Last updated: 2019/06/04
:: https://blog.lussac.net
@echo off
set version=embed-0.2.1
set date=2019/06/04
:: START OF TRANSLATION
set title=You-Get(��ɫ��) ���ýű�
:: Notification
set please-newDir=����һ���½����ļ��������д˽ű���
set already-config=�����á�
set config-ok=��������ɡ�
set please-init=����ִ�� You-Get ��ʼ���á�
set exit=��������˳���
:: Procedure
set unzipping=���ڽ�ѹ
set please-choose=������ѡ�����Ų����س�: 
set open-webpage=���ڴ���ҳ
:: Guides of download batch
set dl-guide-embed1=���ڴ���ɫ�棬Ӧʹ��"yg"������"you-get"���
set dl-guide-embed2=������ƶ����������������ļ��У����������� "config_zh.bat" ��ѡ���޸� "yg.cmd"��
set dl-guide1=������Ƶ������Ϊ��
set dl-guide2=yg+�ո�+��Ƶ��ַ
set dl-guide3=���磺
set dl-guide4=yg https://v.youku.com/v_show/id_aBCdefGh.html
set dl-guide5=Ĭ��������������ȡ������ļ�Ĭ�ϱ����� Download Ŀ¼��
set dl-guide6=�������ѡ�������ȡ�����Ĭ��·���������˽�You-Get�������÷�����ο��ٷ�wiki��
set dl-guide7=https://github.com/soimort/you-get/wiki/����˵��
:: Contents of download batch
set download-bat=You-Get������Ƶ
set create-bat-done=�Ѵ��� You-Get �����ű�"%download-bat%"��
set download-bat-content=start cmd /k "title %download-bat%&&echo %dl-guide-embed1%&&echo %dl-guide-embed2%&&echo.&&echo.&&echo %dl-guide1%&&echo %dl-guide2%&&echo.&&echo %dl-guide3%&&echo %dl-guide4%&&echo.&&echo %dl-guide5%&&echo.&&echo.&&echo %dl-guide6%&&echo %dl-guide7%"
:: Welcome Info
set opt1=[1] �������� You-Get (�� FFmpeg)
set opt2=[2] ���� FFmpeg
set opt3=[3] ���� You-Get
set opt4=[4] �޸� "yg.cmd"
set opt5=[5] ���´˽ű� (����GitHub)
:: END OF TRANSLATION

:: Start of Configuration
title %title%  -- By Lussac
set root=%cd%
set pySrc=%root%\python-embed
set ygSrc=%root%\you-get

:menu
cd %root%
cls
echo =============================================
echo =============================================
echo === %title%  (By Lussac) ===
echo =============================================
echo ===== Version: %version% (%date%) =====
echo =============================================
echo =============================================
echo.
echo.&echo  %opt1%
echo.&echo  %opt2%
echo.&echo  %opt3%
echo.&echo  %opt4%
echo.&echo  %opt5% 
echo.&echo.
echo =============================================
set a=0
set /p a=%please-choose%
echo.
if "%a%"=="1" goto init-config
if "%a%"=="2" goto config-ffmpeg
if "%a%"=="3" goto upgrade-youget
if "%a%"=="4" goto reset-ygcmd
if "%a%"=="5" goto update
goto menu

rem ================= OPTION 1 =================

:init-config
:: Only allow "res" and this batch (totally 2) in this folder when initial configuration.
for /f "delims=" %%i in (' dir /b ') do ( set /a isNewDir+=1 )
if %isNewDir% GTR 2 ( echo %please-newDir% & goto EXIT )

call :Commom
del /Q sources.txt >NUL 2>NUL
wget -q --no-check-certificate https://raw.githubusercontent.com/LussacZheng/you-get_install_win/embed/res/sources.txt
::https://stackoverflow.com/questions/4686464/how-to-show-wget-progress-bar-only
wget -q --show-progress --progress=bar:force:noscroll --no-check-certificate -nc -i sources.txt
::if exist .wget-hsts del .wget-hsts

if exist "%pySrc%" goto check-youget-zip

:check-python-zip
:: Get the full name of "python-3.x.x-embed*.zip" > %pyZip%
for /f "delims=" %%i in ('dir /b /a:a python*embed*.zip') do (set pyZip=%%i)
echo %unzipping% %pyZip%...
::https://superuser.com/questions/331148/7-zip-command-line-extract-silently-quietly
7za x %pyZip% -o"%pySrc%" > NUL

:check-youget-zip
echo Python-embed %already-config%
if exist "%ygSrc%" goto creat-bat
call :Setup-YouGet

:creat-bat
echo You-Get %already-config%
echo isInitialized:true>isInit.txt
cd ..
call :Create-ygcmd
echo %download-bat-content% > %download-bat%.bat
echo.
echo =============================================
echo %config-ok%
echo %create-bat-done%
echo =============================================
pause>NUL
goto menu

rem ================= OPTION 2 =================

:config-ffmpeg
:: Check whether FFmpeg already exists
echo %PATH%|findstr /i "ffmpeg">NUL && goto ffmpeg-config-ok

call :Commom
wget -q --no-check-certificate https://raw.githubusercontent.com/LussacZheng/you-get_install_win/embed/res/sources_ffmpeg.txt
wget -q --show-progress --progress=bar:force:noscroll --no-check-certificate -nc -i sources_ffmpeg.txt

for /f "delims=" %%i in ('dir /b /a:a ffmpeg*.zip') do (set FFmpegZip=%%i)
echo %unzipping% %FFmpegZip% ...
7za x %FFmpegZip% -oC:\ -aoa > NUL
move C:\ffmpeg* C:\ffmpeg > NUL
setx "Path" "%Path%;C:\ffmpeg\bin"

:ffmpeg-config-ok
echo.&echo FFmpeg %already-config%
pause>NUL
goto menu

rem ================= OPTION 3 =================

:upgrade-youget
if NOT exist res\isInit.txt call :Please-Initialize
call :Commom
del /Q you-get*.tar.gz >NUL 2>NUL
del /Q sources_youget.txt >NUL 2>NUL
rd /S /Q "%ygSrc%" >NUL 2>NUL
wget -q --no-check-certificate https://raw.githubusercontent.com/LussacZheng/you-get_install_win/embed/res/sources_youget.txt
wget -q --show-progress --progress=bar:force:noscroll --no-check-certificate -nc -i sources_youget.txt

call :Setup-YouGet
echo.&echo You-Get %already-config%
pause>NUL
goto menu

rem ================= OPTION 4 =================

:reset-ygcmd
if NOT exist res\isInit.txt call :Please-Initialize
call :Create-ygcmd
::echo @echo @"%%cd%%\python-embed\python.exe" "%%cd%%\you-get\you-get" -o Download %%%%*^>yg.cmd> re-config.cmd
echo.&echo %config-ok%
pause>NUL
goto menu

rem ================= OPTION 5 =================

:update
echo %open-webpage%...
start https://github.com/LussacZheng/you-get_install_win/tree/embed
pause>NUL
goto menu

rem ================= FUNCTION =================

:EXIT
echo.&echo %exit%
pause>NUL
exit

:Commom
if NOT exist res md res
cd res
call :Get-wget
goto :eof

:Get-wget
if NOT exist wget.exe (
    echo Downloading "wget.exe"...
    :: use ^) instead of )
    powershell (New-Object Net.WebClient^).DownloadFile('https://raw.githubusercontent.com/LussacZheng/you-get_install_win/embed/res/wget.exe', 'wget.exe'^)
)
goto :eof

:Setup-YouGet
for /f "delims=" %%i in ('dir /b /a:a you-get*.tar.gz') do (set ygZip=%%i)
echo %unzipping% %ygZip%...
:: https://superuser.com/questions/80019/how-can-i-unzip-a-tar-gz-in-one-step-using-7-zip
7za x %ygZip% -so | 7za x -aoa -si -ttar > NUL
set ygDir=%ygZip:~0,-7%
move %ygDir% "%root%\you-get" > NUL
goto :eof

:Create-ygcmd
echo @"%pySrc%\python.exe" "%ygSrc%\you-get" -o Download %%*> yg.cmd
goto :eof

:Please-Initialize
echo.&echo %please-init%
pause>NUL
goto menu
goto :eof