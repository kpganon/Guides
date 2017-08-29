SET WEBMPY_PATH="C:\Users\%USERNAME%\webm.py"
echo %~1
SET FILE1=%~1
%WEBMPY_PATH% -i %FILE1% -vh 720 -l 12 -mt "$2" -vp8 -o "%USERPROFILE%\Desktop\%Time:~+0,2%_%Time:~3,2%_%Time:~6,2%.webm"
pause
