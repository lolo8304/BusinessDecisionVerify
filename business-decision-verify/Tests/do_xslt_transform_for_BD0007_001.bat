@echo off
rem call allg_einstellungen_ee.bat
call allg_einstellungen_axa_wiai.bat
set bdid=BD0007_001
set bdinput=BD0007_001_example_v1.3
set feminput=FEM0007_001
call allg_info
echo .
call bd_generate_views %bdid% %bdinput% %feminput%
call bd_generate_bre_code %bdid% %bdinput% %feminput%
call bd_generate_testcase %bdid% %bdinput% %feminput%
pause