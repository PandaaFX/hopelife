rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
SOURCES = $(call rwildcard, ./, *.lua)

README.md: $(SOURCES)
	-robocopy . //fivem.sszt.ml/server-data/resources/[wtf]/wtf_ev /MIR /FFT /Z /XA:H /W:5 \
		/XD .git
	copy /b README.md +,,