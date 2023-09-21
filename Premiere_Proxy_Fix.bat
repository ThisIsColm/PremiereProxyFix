@echo off
setlocal enabledelayedexpansion

set "input_folder=X:\Path\To\Input\Folder\input"
set "output_folder=X:\Path\To\Output\Folder\output"

:: Ensure the output folder exists
mkdir "%output_folder%" 2>nul

:: Loop through all .mp4 files in the input folder
for %%i in ("%input_folder%\*.mp4") do (
  :: Get the filename without the path and extension
  set "input_file=%%~nxi"

  :: Output file path
  set "output_file=%output_folder%\!input_file!"

  :: Use FFmpeg to change audio channels to 8
  ffmpeg -i "%%i" -c:v copy -filter_complex "[0:a]pan=8c|c0=c0|c1=c1|c2=c2|c3=c3|c4=c4|c5=c5|c6=c6|c7=c7[aout]" -map 0:v -map "[aout]" -c:a aac -strict experimental "!output_file!"

  echo Audio channels changed to 8 for !input_file!
  
)

:: Pause to prevent the terminal from closing immediately at the end
pause
