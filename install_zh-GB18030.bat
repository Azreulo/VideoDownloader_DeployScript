rem - coding:gb18030; mode:batch -
:: You-Get ��װ�ű� 
:: Author: Lussac
:: Last updated: 2019/04/18
:: Version: 0.1.1
:: http://blog.lussac.net
@echo off
set version=0.1.1
set date=2019/04/18

:: START OF TRANSLATION
title You-Get ��װ�ű�  -- By Lussac
:: Notification
set warning==========��װ����������رձ�����!!!=========
set no-python-exe=δ�ҵ�Python��װ����
set info-add-python-to-path1=��������װPythonʱ��Ҫ�ȹ�ѡ"Add Python to PATH"�ٵ��"Install Now"����ؼǵ��ȹ�ѡ��
set info-add-python-to-path2=���������⣬����y����Enter�Լ���:
set no-ffmpeg-zip=δ�ҵ�FFmpegѹ������
set already-installed=�Ѱ�װ��
:: Procedure
set exit=��������˳���
set run-bat-again=��رձ����ں��������д˽ű�!!!
set please-wait=��װ���ѹ��Ҫһ��ʱ�䣬�����ĵȴ�!!!
set step1=1. ��װ Python
set step2=2. ��װ You-Get
set step3=3. ��װ FFmpeg
set step4=4. ʹ�� You-Get
set opening=���ڴ�
set installing-youget=���ڰ�װ You-Get...
set unzipng=���ڽ�ѹ
:: Guides of download and update batches
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
:: Quick start batch content
set download-bat=You-Get������Ƶ
set update-bat=You-Get������
set create-bat-done=�������洴��You-Get �����ű�"%download-bat%" �� ���½ű�"%update-bat%" ��
set download-bat-content=start cmd /k "title %download-bat%&&echo %dl-guide1%&&echo %dl-guide2%&&echo.&&echo %dl-guide3%&&echo %dl-guide4%&&echo.&&echo %dl-guide5%&&echo.&&echo %dl-guide6%&&echo %dl-guide7%"
set update-bat-content=start cmd /k "title %update-bat%&&echo %up-guide1%&&you-get -V&&echo %up-guide2%&&pip install --upgrade you-get&&echo %up-guide3%&&echo %exit%&&pause>NUL&&exit"
:: (set desktop=����)
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
:: Check whether python-x.x.x.exe exist
for /f "delims=" %%i in ('dir /b /a:a python*.exe') do (set PythonExe-FileName=%%i&goto loop)
echo %no-python-exe%
echo %exit%
pause>NUL
exit

:loop 
echo %info-add-python-to-path1%
set /p flag=%info-add-python-to-path2%
If NOT DEFINED flag goto loop
If /i %flag%==y (goto install-python) else (goto loop)

:install-python
echo.&echo %opening% %PythonExe-FileName%...&echo %please-wait%
start /wait %PythonExe-FileName% & echo %PythonExe-FileName% %already-installed%
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
:: Check whether ffmpeg-x.x.x.zip exist
for /f "delims=" %%i in ('dir /b /a:a ffmpeg*.zip') do (set FFmpegZip-FileName=%%i&goto install-ffmpeg)
echo %no-ffmpeg-zip%
echo %exit%
pause>NUL
exit

:install-ffmpeg
echo %unzipng% %FFmpegZip-FileName% ...&echo %please-wait%
unzip -oq %FFmpegZip-FileName% -d C:\
move C:\ffmpeg* C:\ffmpeg
::setx "Path" "%Path%;C:\ffmpeg\bin" /m
setx "Path" "%Path%;C:\ffmpeg\bin"
echo FFmpeg %already-installed%

:: Step 4
echo.&echo %step4%
:: Create two quick-start batches to use and update You-Get
echo %download-bat-content% > %USERPROFILE%\Desktop\%download-bat%.bat
echo %update-bat-content%  > %USERPROFILE%\Desktop\%update-bat%.bat
::echo %download-bat-content% > %USERPROFILE%\%desktop%\%download-bat%.bat
::echo %update-bat-content%  > %USERPROFILE%\%desktop%\%update-bat%.bat
echo %create-bat-done%
echo.&echo %exit%
pause>NUL
exit