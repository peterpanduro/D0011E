@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto c4a11a5b57594ec3beab8f952f03b875 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot DataMemory_tb_behav xil_defaultlib.DataMemory_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
