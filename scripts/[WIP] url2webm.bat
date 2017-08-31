@echo OFF

:: Set utf-8 formatting for hangul filenames
::chcp 65001

echo kpganon's webm maker
echo version 0.9.7
echo.
echo https://github.com/kpganon?tab=repositories
echo.
echo ###############################################
echo ###############      BEGIN      ###############
echo ###############################################
echo.

:: Defaults

  :: Directories

SET WORKDIR=C:\Users\%USERNAME%\Desktop\work_dir
SET DESTDIR=C:\Users\%USERNAME%\Desktop

  :: WEBM settings

SET $VIDHEIGHT=720
SET $FILESIZE=3
SET $CODEC=vp8

  :: Youtube-dl output template
    ::Working
::SET $DLOUTPUT=C:\\Users\\HTPC\\Desktop\\work_dir\\%%(uploader)s_%%(title)s_%%(fps)s_FPS_%%(resolution)s.%%(ext)s

SET $DLOUTPUT=C:\\Users\\HTPC\\Desktop\\work_dir\\%%(uploader)s_%%(title)s_(%%(fps)s_FPS_%%(resolution)s).%%(ext)s

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Initiate dialogue & set variables

SET /P INPUTURL= Input video URL:
::SET /P WORKDIR= Temporary download folder (eg. C:\path\to\temp\a folder):
::SET /P DESTDIR= Destination folder (eg. C:\path\to\destination\folder):

:: Create WORK/DEST DIR & change directory

if not exist "%WORKDIR%" mkdir "%WORKDIR%"
if not exist "%DESTDIR%" mkdir "%DESTDIR%"
cd "%WORKDIR%"
echo.
echo Current directory is:
cd

:: Download video from url

::youtube-dl -f bestvideo+bestaudio %INPUTURL% --output "C:\\Users\\HTPC\\Desktop\\work_dir\\%%(uploader)s_%%(title)s_%%(fps)s_%%(resolution)s.%%(ext)s"

youtube-dl -f bestvideo+bestaudio %INPUTURL% --output "%$DLOUTPUT%"

:: Check if youtube-dl is running

SETLOCAL EnableExtensions
set EXE=youtube-dl.exe
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND
echo.
echo Youtube-dl.exe is not running. Moving on...
echo.
goto FIN

:FOUND
echo youtube-dl.exe is currently running.
:FIN

:: Set joined video path variable

::for /f %%i in ('dir /s/b/a-d/od/t:c') do set LAST=%%i
::echo %LAST%

::FOR /F "delims=|" %%I IN ('DIR "%DESTDIR%\*.*" /B /O:D') DO SET DLFILE=%%I
::echo.
::echo Last file added:
::echo %DLFILE%

::SET $VIDEO=%DLFILE%
::echo.
::echo The most recent file is
::echo %$VIDEO%
::echo.
::echo Variable set.

:: Move joined video from temp folder to destination folder
:: and set new file path variable

move "%WORKDIR%"\*.* "%DESTDIR%"
cd "%DESTDIR%"
echo current directory is:
cd
echo.
chcp 65001

::for /f %%i in ('dir /s/b/a-d/od/t:c') do set LAST2=%%i
::echo %LAST2%

::SET $VIDEO2=%LAST2%

FOR /F "delims=|" %%I IN ('DIR "C:\Users\HTPC\Desktop\dest_dir\*.*" /B /O:D') DO SET DLFILE=%%I
echo.
echo Last file added:
echo %DLFILE%

SET $VIDEO=%DLFILE%
echo.
echo The most recent file is
echo %$VIDEO%
echo.
echo Variable set.

:: Open file in MPV for manual start and end time selection

"%$VIDEO%"

SET /P $SS= Start time (eg. 01:20):
SET /P $TO= End time (eg. 01:29):

:: Convert video to webm by time

webm -i "%$VIDEO%" -ss "%$SS%" -to "%$TO%" -l "%$FILESIZE%" -"%$CODEC%" -vh "%$VIDHEIGHT%"

:: Get webm path and open in default video player for preview

::for /f %%i in ('dir /s/b/a-d/od/t:c') do set LAST3=%%i
::echo %LAST3%

::SET $VIDEO3=%LAST3%

FOR /F "delims=|" %%I IN ('DIR "C:\Users\HTPC\Desktop\dest_dir\*.webm" /B /O:D') DO SET OUTFILE=%%I
echo.
echo WEBM path:
echo %OUTFILE%
echo.
echo Variable set.

%OUTFILE%

chcp 437

:: End

echo "###############################################"
echo "###########        COMPLETED        ###########"
echo "###############################################"

pause
