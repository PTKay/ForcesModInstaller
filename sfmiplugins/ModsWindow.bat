@echo off
for %%* in (.) do set modwindowfoldercheck=%%~nx*

if not defined fmiver (
  title SFMI PLUGIN
  echo ERROR
  echo ----------
  echo SFMI plugins won't work in standalone.
  echo ----------
  pause >nul
  exit
)

mode con:cols=50 lines=30

:begin
title SFMI Installed Mods [PLUGIN]
cls
echo Currently installed mods:
echo ---------
if not exist "%worklocation%mods\sfmimodsdb.ini" (
  echo No mods are currently installed
) else (
type "%worklocation%mods\sfmimodsdb.ini"
)
echo ---------
timeout /t 1 >nul
goto begin