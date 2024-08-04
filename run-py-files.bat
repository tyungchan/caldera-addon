@echo off
echo Running first script...
python dga_sim3.py
if %ERRORLEVEL% neq 0 (
    echo First script did not complete successfully.
    pause
    exit /b %ERRORLEVEL%
)
echo First script completed. Running second script...
python worm.py
if %ERRORLEVEL% neq 0 (
    echo Second script did not complete successfully.
    pause
    exit /b %ERRORLEVEL%
)
echo Second script completed.
pause