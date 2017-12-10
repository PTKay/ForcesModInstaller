@echo off
for %%* in (.) do set foldercheck=%%~nx*
set fmiver=1.7.1
title Sonic Forces Mod Installer %fmiver%

if /I %foldercheck% EQU SonicForces goto rootfolder
if /I %foldercheck% EQU exec goto execfolder
if /I %foldercheck% NEQ SonicForces if /I %foldercheck% NEQ SonicForces (
  echo ERROR
  echo ----------
  echo This bat file/mod folder isn't in a compatible folder.
  echo Please put this file/folder in the SonicForces or the exec folder and try again.
  pause >nul
  exit
)

:execfolder
cd ..
cd ..
cd ..
cd ..
title Sonic Forces Mod Installer %fmiver% (Exec Folder Mode)
set worklocation=.\build\main\projects\exec\
goto fmibegin

::Game Root Folder Mode
:rootfolder
set worklocation=
title Sonic Forces Mod Installer %fmiver% (Root Folder Mode)
goto fmibegin

:fmibegin
if not exist "%worklocation%PackCPK.exe" (
  echo ERROR
  echo ----------
  echo Could not find PackCPK.exe!
  pause >nul
  exit
)

if not exist "%worklocation%CpkMaker.dll" (
  echo ERROR
  echo ----------
  echo Could not find CpkMaker.dll!
  echo Please get CpkMaker.dll from this archive and extract it to the this folder:
  echo https://goo.gl/8Gs5jx
  pause >nul
  exit
)

if exist ".\build\main\projects\exec\d3d11.dll" if exist ".\build\main\projects\exec\HedgeModManager.exe" (
  echo WARNING
  echo ----------
  echo An instalation of the HedgeModManager code loader 
  echo was detected. Please uninstall the code loader 
  echo to avoid conflicts. 
  echo. 
  echo Press any key to proceed anyway 
  pause >nul
)

md %worklocation%mods
md .\image\x64\disk\mod_installer\
echo Do not delete these folders! These serve as cache for the mod installer! > .\image\x64\disk\mod_installer\readme.txt
if not exist ".\build\main\projects\exec\CpkMaker.dll" if exist ".\build\main\projects\exec\HedgeModManager.exe" (
xcopy /y "CpkMaker.dll" ".\build\main\projects\exec\"
)
cls

if "%~1" EQU "" goto normal


:dragdrop
if not exist %~1\mod.ini (
  cls
  echo Not a valid mod folder.
  echo Forgot to create mod.ini?
  pause >nul
  exit
)

if exist (%~1\sfmi.ini) (
  for /f "tokens=1,2 delims==" %%a in (%~1\sfmi.ini) do (
  if /I %%a==cpk set cpk=%%b
)

  for /f "tokens=1,2 delims==" %%a in (%~1\sfmi.ini) do (
  if /I %%a==custominstall set custom=%%b
)

  for /f "tokens=1,2 delims==" %%a in (%~1\sfmi.ini) do (
  if /I %%a==custominstallbat set custombat=%%b
)
) else (
set cpk=wars_patch
set custom=false
set custombat=
)

  if "%~1" EQU "" (goto normal)
  for /f "tokens=1,2 delims==" %%a in (%~1\mod.ini) do (
  if /I %%a==title set title=%%b
)
  
  for /f "tokens=1,2 delims==" %%a in (%~1\mod.ini) do (
  if /I %%a==author set author=%%b
)

  if exist "%~1/disk/*.cpk"


  echo Do you want to install %title% by %author%?
  echo (Installs to %cpk%)
  echo.
  set /p confirm=(Y/N)
  if /i %confirm% EQU y goto install
  if /i %confirm% EQU n goto end

:install
echo --------------------------
if not exist ".\image\x64\disk\%cpk%.cpk.backup" (
  echo No backup detected, backing up %cpk%.cpk as %cpk%.cpk.backup...
  echo f|xcopy /y ".\image\x64\disk\%cpk%.cpk" ".\image\x64\disk\%cpk%.cpk.backup" >nul
) else (
  echo Backup of %cpk%.cpk already detected, proceeding instalation...
  echo You have 7 seconds to close this window if this is wrong...
  echo.
  echo If you already installed mods with this, just press any key
  timeout /t 7 >nul
)
echo --------------------------

if /I %custom% EQU true (
  goto custom
  )

echo --------------------------
if exist "%~1\disk\*.cpk" (
echo CPK mod detected. Extracting files...
for %%x in (%~1\disk\*.cpk) do (
  set "cpkinstallation=%%x"
  goto CPKProceedDD
)
:CPKProceedDD
%worklocation%packcpk %cpkinstallation%
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
  if not exist "image\x64\disk\mod_installer\wars_modinstaller_%cpk%" (
  %worklocation%packcpk ".\image\x64\disk\%cpk%.cpk"
  rename %cpk% wars_modinstaller_%cpk%
  move wars_modinstaller_%cpk% ".\image\x64\disk\mod_installer\" >nul
) else (
  echo Extracted files already found, skipping extraction...
)
echo --------------------------
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
%worklocation%PackCPK ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" ".\image\x64\disk\%cpk%"
echo --------------------------
echo %title% >> mods\SFMIModsDB.ini
echo Done! Press any key to exit!
pause >nul
exit
)

echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
  if not exist "image\x64\disk\mod_installer\wars_modinstaller_%cpk%" (
  %worklocation%packcpk ".\image\x64\disk\%cpk%.cpk"
  rename %cpk% wars_modinstaller_%cpk%
  move wars_modinstaller_%cpk% ".\image\x64\disk\mod_installer\" >nul
) else (
  echo Extracted files already found, skipping extraction...
)
echo --------------------------
echo Copying files...
xcopy /s /y "%~1\disk\%cpk%" ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" >nul
echo --------------------------
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
%worklocation%PackCPK ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" ".\image\x64\disk\%cpk%"
echo --------------------------
echo %title% >> mods\SFMIModsDB.ini
echo Done! Press any key to exit!
pause >nul
exit

:normal
md %worklocation%mods
md .\image\x64\disk\mod_installer\
echo Do not delete these folders! These serve as cache for the mod installer! > .\image\x64\disk\mod_installer\readme.txt
cls
if not exist "mods" (md mods)
echo Type the mod folder to install that mod
echo Type "delete" to uninstall all currently installed mods
echo Type "refresh" to refresh the mod list
echo Type "check" to check currently installer mods
echo.
echo Mods available in the "mods" folder
echo ------------------------------------
::dir .\mods /ad /b
if /i %foldercheck% equ SonicForces (
cd mods
for /r %%a in (.) do @if exist "%%~fa\mod.ini" echo %%~nxa
cd ..
)
if /i %foldercheck% equ exec (
cd %worklocation%mods
for /r %%a in (.) do @if exist "%%~fa\mod.ini" echo %%~nxa
cd ..
cd ..
cd ..
cd ..
cd ..
)
echo ------------------------------------
echo.
set /p modfoldernormal=Mod folder: 
if /i "%modfoldernormal%" EQU delete goto uninstall
if /i "%modfoldernormal%" EQU refresh goto normal
if /i "%modfoldernormal%" EQU check goto check


if exist ("%worklocation%mods\%modfoldernormal%\sfmi.ini") (
  for /f "tokens=1,2 delims==" %%a in ("mods\%modfoldernormal%\sfmi.ini") do (
  if /I %%a==cpk set cpk=%%b
)

  for /f "tokens=1,2 delims==" %%a in ("%worklocation%mods\%modfoldernormal%\sfmi.ini") do (
  if /I %%a==custominstall set custom=%%b
)

  for /f "tokens=1,2 delims==" %%a in ("%worklocation%mods\%modfoldernormal%\sfmi.ini") do (
  if /I %%a==custominstallbat set custombat=%%b
)
) else (
set cpk=wars_patch
set custom=false
set custombat=
)


  for /f "tokens=1,2 delims==" %%a in (%worklocation%mods\%modfoldernormal%\mod.ini) do (
  if /I %%a==title set title=%%b
)

)
  for /f "tokens=1,2 delims==" %%a in (%worklocation%mods\%modfoldernormal%\mod.ini) do (
  if /I %%a==author set author=%%b
)

:confirmnormal

if not exist %worklocation%mods\%modfoldernormal% (
  cls
  echo Mod folder does not exist
  echo Maybe you added a space in the name?
  pause >nul
  goto normal
)

if not exist %worklocation%mods\%modfoldernormal%\mod.ini (
  cls
  echo Not a valid mod folder.
  echo Forgot to create mod.ini?
  pause >nul
  goto normal
)


cls
echo Do you want to install %title% by %author%?
echo (Installs to "%cpk%")
echo.
set /p confirm=(Y/N)
if /i %confirm% EQU Y goto installnormal
if /i %confirm% EQU n goto normal

:installnormal
echo --------------------------
if not exist ".\image\x64\disk\%cpk%.cpk.backup" (
  echo No backup detected, backing up %cpk%.cpk as %cpk%.cpk.backup...
  echo f|xcopy /y ".\image\x64\disk\%cpk%.cpk" ".\image\x64\disk\%cpk%.cpk.backup" >nul
) else (
  echo Backup of %cpk%.cpk already detected, proceeding instalation...
  echo You have 7 seconds to close this window if this is wrong...
  echo.
  echo If you already installed mods with this, just press any key
  timeout /t 7 >nul
)
echo --------------------------

if /i %custom% EQU true (
  goto customnormal
  )

echo --------------------------
if exist "%worklocation%mods\%modfoldernormal%\disk\*.cpk" (
echo CPK mod detected. Extracting files...
for %%x in (%worklocation%mods\%modfoldernormal%\disk\*.cpk) do (
  set "cpkinstallation=%%x"
  goto CPKProceed
)
:cpkproceed
%worklocation%packcpk %cpkinstallation%
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
  if not exist "image\x64\disk\mod_installer\wars_modinstaller_%cpk%" (
  %worklocation%packcpk ".\image\x64\disk\%cpk%.cpk"
  rename %cpk% wars_modinstaller_%cpk%
  move wars_modinstaller_%cpk% ".\image\x64\disk\mod_installer\" >nul
) else (
  echo Extracted files already found, skipping extraction...
)
echo --------------------------
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
%worklocation%PackCPK ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" ".\image\x64\disk\%cpk%"
echo --------------------------
echo %title% >> mods\SFMIModsDB.ini
echo Done! Press any key to exit!
pause >nul
exit
)


if not exist "image\x64\disk\mod_installer\wars_modinstaller_%cpk%" (
  echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
  %worklocation%packcpk ".\image\x64\disk\%cpk%.cpk"
  rename %cpk% wars_modinstaller_%cpk%
  move wars_modinstaller_%cpk% ".\image\x64\disk\mod_installer\" >nul
) else (
  echo Extracted files already found, skipping extraction...
)
echo --------------------------
echo Copying files...
xcopy /s /y "%worklocation%mods\%modfoldernormal%\disk\%cpk%" ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" >nul
echo --------------------------
echo IF THIS LOOKS STUCK, DON'T DO ANYTHING! IT ISN'T!
%worklocation%PackCPK ".\image\x64\disk\mod_installer\wars_modinstaller_%cpk%" ".\image\x64\disk\%cpk%"
echo --------------------------
echo %title% >> %worklocation%mods\SFMIModsDB.ini
echo Done! Press any key to exit!
pause >nul
exit

:custom
call "%~1\%custombat%"
exit

:customnormal
call "mods\%modfoldernormal%\%custombat%"
exit

:check
cls
echo Currently installed mods:
echo ---------
if not exist "%worklocation%mods\sfmimodsdb.ini" (
  echo No mods are currently installed
) else (
type %worklocation%mods\sfmimodsdb.ini
)
echo ---------
echo Press any key to go back to the menu...
pause >nul
goto normal

:uninstall
cls
echo Currently installed mods:
echo ---------
if not exist "%worklocation%mods\sfmimodsdb.ini" (
  echo No mods are currently installed
) else (
type mods\sfmimodsdb.ini
)
echo ---------
echo This will uninstall all of your currently installed mods
set /p answer=Proceed (Y/N): 
if /i %answer% equ y goto uninstallyes
goto normal

:uninstallyes
if not exist "image\x64\disk\wars_patch.cpk.backup" (
echo ERROR
echo No backup of wars_patch.cpk detected [wars_patch.cpk.backup]!
echo Without a backup, the uninstaller cannot proceed.
pause >nul
goto normal
)

echo Uninstalling mods...
del image\x64\disk\wars_patch.cpk
ren image\x64\disk\wars_patch.cpk.backup wars_patch.cpk
del /q "image\x64\disk\mod_installer\*"
FOR /D %%p IN ("image\x64\disk\mod_installer\*.*") DO rmdir "%%p" /s /q
del /q %worklocation%mods\sfmimodsdb.ini
echo.
echo Done! Press any key to go back to the menu
pause >nul
goto normal

:end