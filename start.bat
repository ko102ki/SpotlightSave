@echo off
echo Running powershell script...
powershell -NoProfile -ExecutionPolicy Unrestricted .\SpotlightSave.ps1
echo Finished!
pause > nul
exit