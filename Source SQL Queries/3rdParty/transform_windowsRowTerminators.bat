for /f "delims=" %%G in (%1\Features_pif30.tsv) do echo %%G >> %1\Features_%2_PIF30.csv 
for /f "delims=" %%G in (%1\Features_pif45.tsv) do echo %%G >> %1\Features_%2_PIF45.csv 
for /f "delims=" %%G in (%1\Features_pif60.tsv) do echo %%G >> %1\Features_%2_PIF60.csv 
for /f "delims=" %%G in (%1\Features_pif75.tsv) do echo %%G >> %1\Features_%2_PIF75.csv 
for /f "delims=" %%G in (%1\Features_pif90.tsv) do echo %%G >> %1\Features_%2_PIF90.csv 
for /f "delims=" %%G in (%1\Features_pif105.tsv) do echo %%G >> %1\Features_%2_PIF105.csv 
for /f "delims=" %%G in (%1\Features_pif120.tsv) do echo %%G >> %1\Features_%2_PIF120.csv 