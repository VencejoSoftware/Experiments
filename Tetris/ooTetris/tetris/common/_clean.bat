cd .
for /r %1 %%R in (__history) do if exist "%%R" (rd /s /q "%%R")

del *.exe /s
del *.dll /s
del *.dcu /s
del *.~*~ /s
del *.~ddp /s
del *.ddp /s
del *.~pas /s
del *.~dfm /s
del *.ddp /s
del *.log /s
