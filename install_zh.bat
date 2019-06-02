rem - Encoding:gb2312; Mode:Batch; Language:zh-CN; LineEndings:CRLF -
:: You-Get ��װ�ű�
:: Author: Lussac
:: Version: 0.2.1
:: Last updated: 2019/06/02
:: https://blog.lussac.net
@echo off
set version=0.2.1
set date=2019/06/02

:: START OF TRANSLATION
title You-Get ��װ�ű�  -- By Lussac
:: Notification
set warning========== ��װ������ ����رձ����� =========
set no-python-exe=δ�ҵ�Python��װ����
set info-add-python-to-path1=��������װPythonʱ��Ҫ�ȹ�ѡ"Add Python to PATH"�ٵ��"Install Now / Customize installation"����ؼǵ��ȹ�ѡ��
set info-add-python-to-path2=���������⣬����y����Enter�Լ���:
set no-ffmpeg-zip=δ�ҵ�FFmpegѹ������
set already-installed=�Ѱ�װ��
set no-unzip-exe=δ�ҵ� "unzip.exe" ��
:: Procedure
set exit=��������˳���
set run-bat-again=��رձ����ں��������� install_zh-latest.bat.
set please-wait=��װ���ѹ��Ҫһ��ʱ�䣬�����ĵȴ�...
set step1=1. ��װ Python
set step2=2. ��װ You-Get
set step3=3. ��װ FFmpeg
set step4=4. ʹ�� You-Get
set opening=���ڴ�
set installing-youget=���ڰ�װ You-Get...
set unzipping=���ڽ�ѹ
:: Guides of download and upgrade batches
set dl-guide1=������Ƶ������Ϊ��
set dl-guide2=you-get+�ո�+��Ƶ��ַ
set dl-guide3=���磺
set dl-guide4=you-get https://v.youku.com/v_show/id_aBCdefGh.html
set dl-guide5=Ĭ��������������ȡ������ļ�Ĭ�ϱ����ڵ�ǰ�ű����ڵ�Ŀ¼��
set dl-guide6=�������ѡ�������ȡ�����Ĭ��·���������˽�You-Get�������÷�����ο��ٷ�wiki��
set dl-guide7=https://github.com/soimort/you-get/wiki/����˵��
set up-guide1=��ǰ�汾��
set up-guide2=���ڼ�����...
set up-guide3=������ɣ��������°汾��
:: Contents of download and upgrade batches
set download-bat=You-Get������Ƶ
set upgrade-bat=You-Get������
set create-bat-done=�������洴�� You-Get �����ű�"%download-bat%" �� ���½ű�"%upgrade-bat%" ��
set download-bat-content=start cmd /k "title %download-bat%&&echo %dl-guide1%&&echo %dl-guide2%&&echo.&&echo %dl-guide3%&&echo %dl-guide4%&&echo.&&echo %dl-guide5%&&echo.&&echo %dl-guide6%&&echo %dl-guide7%"
set upgrade-bat-content=start cmd /k "title %upgrade-bat%&&echo %up-guide1%&&you-get -V&&echo.&&echo %up-guide2%&&python -m pip install --upgrade pip&&pip install --upgrade you-get&&echo.&&echo %up-guide3%&&echo %exit%&&pause>NUL&&exit"
:: Welcome Info
cls
echo =============================================
echo =============================================
echo ======== You-Get��װ�ű� (By Lussac) ========
echo =============================================
echo ======== Version: %version% (%date%) ========
echo =============================================
echo =============================================
:: END OF TRANSLATION

:: Start of Installation
echo.&echo %warning%

:: Step 1
echo.&echo %step1%
:: Check whether Python already installed
echo %PATH%|findstr /i "Python">NUL&&goto install-youget||goto check-python-exe

:check-python-exe
:: Check whether "python-x.x.x.exe" exist
for /f "delims=" %%i in ('dir /b /a:a python*.exe') do (set pyExe=%%i&goto loop)
echo.&echo %no-python-exe%
goto EOF

:loop 
echo %info-add-python-to-path1%
set /p flag=%info-add-python-to-path2%
If NOT DEFINED flag goto loop
If /i %flag%==y (goto install-python) else (goto loop)

:install-python
echo.&echo %opening% %pyExe%...&echo %please-wait%
start /wait %pyExe% & echo %pyExe% %already-installed%
echo.&echo %run-bat-again%
pause>NUL
exit

:: Step 2
:install-youget
echo Python %already-installed%
echo.&echo %step2%
echo %installing-youget%&echo %please-wait%
echo.
pip3 install you-get
echo.
echo You-Get %already-installed%

:: Step 3
echo.&echo %step3%
:: Check whether FFmpeg already installed
echo %PATH%|findstr /i "ffmpeg">NUL&&goto start-youget||goto check-ffmpeg-zip

:check-ffmpeg-zip
:: Check whether "ffmpeg-x.x.x.zip" exist
for /f "delims=" %%i in ('dir /b /a:a ffmpeg*.zip') do (set FFmpegZip=%%i&goto install-ffmpeg)
echo.&echo %no-ffmpeg-zip%
goto EOF

:install-ffmpeg
echo %unzipping% %FFmpegZip% ...&echo %please-wait%
:: Check whether "unzip.exe" exist
for /f "delims=" %%i in ('dir /b /a:a unzip.exe') do (goto install-ffmpeg_unzipping)
echo.&echo %no-unzip-exe%
goto EOF

:install-ffmpeg_unzipping
unzip -oq %FFmpegZip% -d C:\
move C:\ffmpeg* C:\ffmpeg
::setx "Path" "%Path%;C:\ffmpeg\bin" /m
setx "Path" "%Path%;C:\ffmpeg\bin"

:: Step 4
:start-youget
echo FFmpeg %already-installed%
echo.&echo %step4%
:: Create two quick-start batches to use and upgrade You-Get
echo %download-bat-content% > %USERPROFILE%\Desktop\%download-bat%.bat
echo %upgrade-bat-content%  > %USERPROFILE%\Desktop\%upgrade-bat%.bat
echo %create-bat-done%

:: END OF FILE
:EOF
echo.&echo %exit%
pause>NUL
exit