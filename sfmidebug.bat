if /I %foldercheck% EQU SonicForces goto rootfolder
if /I %foldercheck% EQU exec goto execfolder
if /I %foldercheck% NEQ SonicForces if /I %foldercheck% NEQ exec (
set worklocation=INCOMPATIBLE\
set workmode=NONE
goto :end
)


:execfolder
cd ..
cd ..
cd ..
cd ..
title Sonic Forces Mod Installer %fmiver% (Exec Folder Mode)
set worklocation=.\build\main\projects\exec\
set workmode=EXEC
goto :end
::Game Root Folder Mode
:rootfolder
set worklocation=
title Sonic Forces Mod Installer %fmiver% (Root Folder Mode)
set workmode=ROOT
goto :end


:end
cls
set debug_startup=TRUE
echo You're starting SFMI in debug mode...
echo Proceed?
set /p answer=(Y/N)
if /i %answer% EQU Y (goto proceed)
if /i %answer% EQU N (set debug_startup=FALSE)

:proceed
cls