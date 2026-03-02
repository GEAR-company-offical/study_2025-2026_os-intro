@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM =========================
REM CONFIG
REM =========================
set "REPORT=report.md"
set "SLIDES=slides.md"
set "LINKS=links.md"
set "DIST=dist"
set "MARP=C:\Tools\marp-cli-v4.2.3-win\marp.exe"

REM =========================
REM CLEAN junk folders in root (never needed)
REM =========================
for %%D in ("DOCX" "PDF" "HTML" "dist)") do (
  if exist %%D (
    rmdir /s /q %%D 2>nul
    del /q %%D 2>nul
  )
)

REM =========================
REM PREP + CLEANUP (полная очистка dist)
REM =========================
if exist "%DIST%" (
  echo Cleaning %DIST% folder...
  rmdir /s /q "%DIST%" 2>nul
)
mkdir "%DIST%"

echo =============================
echo Building project...
echo Folder: %CD%
echo Output: %CD%\%DIST%
echo =============================

REM =========================
REM CHECKS
REM =========================
if not exist "%REPORT%" (echo [ERROR] %REPORT% not found & goto :fail)
if not exist "%SLIDES%" (echo [ERROR] %SLIDES% not found & goto :fail)
if not exist "%MARP%"   (echo [ERROR] marp.exe not found: %MARP% & goto :fail)

REM =========================
REM REPORT -> DOCX
REM =========================
echo.
echo [1/7] Report -> DOCX
pandoc "%REPORT%" -o "%DIST%\report.docx"
if errorlevel 1 goto :fail

REM =========================
REM REPORT -> PDF (Cyrillic-safe)
REM =========================
echo.
echo [2/7] Report -> PDF (xelatex + fonts)
pandoc "%REPORT%" -o "%DIST%\report.pdf" --pdf-engine=xelatex ^
  -V lang=ru ^
  -V mainfont="Times New Roman" ^
  -V sansfont="Arial" ^
  -V monofont="Consolas"
if errorlevel 1 goto :fail

copy /Y "%REPORT%" "%DIST%\report.md" >nul

REM =========================
REM SLIDES -> HTML (Marp)
REM =========================
echo.
echo [3/7] Slides -> HTML (Marp)
"%MARP%" "%SLIDES%" --html --allow-local-files -o "%DIST%\slides.html"
if errorlevel 1 goto :fail

REM --- Copy images so HTML works when you move dist/ somewhere else ---
echo.
echo [4/7] Copy images for HTML (src/assets -> dist)
if exist src (
  if not exist "%DIST%\src" mkdir "%DIST%\src"
  xcopy "src" "%DIST%\src" /E /I /Y >nul
)
if exist assets (
  if not exist "%DIST%\assets" mkdir "%DIST%\assets"
  xcopy "assets" "%DIST%\assets" /E /I /Y >nul
)

REM =========================
REM SLIDES -> PDF (Marp)
REM =========================
echo.
echo [5/7] Slides -> PDF (Marp)
"%MARP%" "%SLIDES%" --pdf --allow-local-files -o "%DIST%\slides.pdf"
if errorlevel 1 goto :fail

copy /Y "%SLIDES%" "%DIST%\slides.md" >nul

REM =========================
REM LINKS (optional)
REM =========================
echo.
echo [6/7] Links (optional)
if exist "%LINKS%" (
  copy /Y "%LINKS%" "%DIST%\links.md" >nul
)

REM =========================
REM SOURCES ZIP
REM =========================
echo.
echo [7/7] sources.zip
set "ZIPLIST=%REPORT%,%SLIDES%"
if exist "%LINKS%" set "ZIPLIST=!ZIPLIST!,%LINKS%"
if exist src set "ZIPLIST=!ZIPLIST!,src"
if exist assets set "ZIPLIST=!ZIPLIST!,assets"

powershell -NoProfile -Command ^
  "Compress-Archive -Force -Path %ZIPLIST% -DestinationPath '%DIST%\sources.zip'"

REM =========================
REM Очистка временных файлов (только если они появились в dist)
REM =========================
echo.
echo Checking for temporary files...
del /q "%DIST%\*.aux" "%DIST%\*.log" "%DIST%\*.out" "%DIST%\*.tex" "%DIST%\*.toc" "%DIST%\*.nav" "%DIST%\*.snm" "%DIST%\*.vrb" 2>nul


REM =========================
REM POST-CLEAN (root folder only)
REM =========================
echo.
echo Post-clean: remove junk in project root...

REM 1) Remove stray folders created by wrong outputs
for %%D in ("DOCX" "PDF" "HTML" "dist)") do (
  if exist %%D (
    rmdir /s /q %%D 2>nul
    del /q %%D 2>nul
  )
)

REM 2) Remove common LaTeX/Pandoc temp files in ROOT (not inside dist)
for %%E in (*.aux *.log *.out *.toc *.nav *.snm *.vrb *.synctex.gz *.tex) do (
  del /q "%%E" 2>nul
)



echo.
echo =============================
echo DONE ✅  Check dist\
echo =============================
pause
exit /b 0

:fail
echo.
echo =============================
echo BUILD FAILED ❌
echo See error messages above.
echo =============================
pause
exit /b 1