@echo off     
setlocal enableextensions enabledelayedexpansion

(for /F "tokens=2-4 delim= /" %%G in ('date /t') do set mydate=%%I%%J%%G) 

FINDSTR /R /I /V "^$ (\d+)\s row(s) affected)" C:\Users\jadrummond\Documents\Features.csv>C:\Users\jadrummond\Documents\Features_+%mydate%+.csv

end local 