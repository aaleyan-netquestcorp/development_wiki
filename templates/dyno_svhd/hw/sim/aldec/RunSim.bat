%echo off
Title "Launching the TSE Simulation:"

echo.
echo **************************************************************
echo Configure the windows environment here:
echo **************************************************************

rem set path_to_modelsim=c:\modeltech64_10.5g\win64
rem call :doesFileExist %path_to_modelsim%
rem 
rem set path=%path_to_modelsim%;%PATH%
rem set QUARTUS_VERSION=16.1
rem 	   
rem set QUARTUS_ROOTDIR=C:\intelFPGA\16.1\quartus
rem IF EXIST %QUARTUS_ROOTDIR% ( echo QUARTUS_ROOTDIR=%QUARTUS_ROOTDIR% ) ^
rem   ELSE ( echo Missing %QUARTUS_ROOTDIR% & pause & Exit /b)

echo.
echo **************************************************************
echo Opening Modelsim with All Debug features enabled ...
echo **************************************************************

rem C:\Aldec\Active-HDL-11.1-x64\BIN\avhdl.exe

where avhdl
  if %ERRORLEVEL% neq 0 (
    echo avhdl wasn't found ) ^
  else (
    echo Launching simulation using this command: start avhdl -do sim.do
    start avhdl.exe -do run.do design.adf )


set /p MESSAGE=Hit ENTER to finish...


:doesFileExist
  IF EXIST %~1 ( echo Found %~1 ) ^
  ELSE ( echo Can NOT find %~1 & pause & cmd /c exit -1073741510)
  EXIT /B 0