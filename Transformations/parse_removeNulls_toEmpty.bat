@echo off
    setlocal enableextensions enabledelayedexpansion

    (for /f "usebackq tokens=* delims=," %%G in ("\\pfs-fps\home\jadrummond\My Documents\deliverables\recess\extract\Barnabas\BigSquid\Features.csv") do if not "%%G"=="" (
            set "line=%%G"
            set "line=!line:NULL=!"
            set "line=!line:UNKNOWN=!"
            echo(!line!
    )) > "\\pfs-fps\home\jadrummond\My Documents\deliverables\recess\extract\Barnabas\BigSquid\Features2.csv"

    endlocal