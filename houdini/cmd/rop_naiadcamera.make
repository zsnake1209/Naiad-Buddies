# Makefile helper for GNU make utility.
#
# To use, create your own file named 'Makefile' with something like this:
#       DSONAME = SOP_MySOP.so (or SOP_MySOP.dll for Windows)
#       SOURCES = SOP_MySOP.C
#       include $(HFS)/toolkit/makefiles/Makefile.gnu
# Then you just need to invoke make from the same directory.
#
# Complete list of variables used by this file:
#   OPTIMIZER   Override the optimization level (optional, defaults to -O2)
#   INCDIRS     Specify any additional include directories.
#   LIBDIRS     Specify any addition library include directories
#   SOURCES     List all .C files required to build the DSO or App
#   DSONAME     Name of the desired output DSO file (if applicable)
#   APPNAME     Name of the desires output application (if applicable)
#   INSTDIR     Directory to be installed. If not specified, this will
#               default to the the HOME houdini directory.
#   ICONS       Name of the icon files to install (optionial)

#Make sure that your NAIAD_PATH variable is set up and that the LD_LIBRARY_PATH includes $(NAIAD_PATH)/lib

#You shouldn't need to touch anything below this line.

#NAIAD_INC=-I$(NAIAD_PATH)/server/include/Ng -I$(NAIAD_PATH)/server/include/Nb -I$(NAIAD_PATH)/server/include/em -I$(NAIAD_PATH)/server/include/system -I$(NAIAD_PATH)/include/Ni -I$(NAIAD_PATH)/include/Ng -I$(NAIAD_PATH)/include/Nb -I$(NAIAD_PATH)/include/em -I$(NAIAD_PATH)/include/system
NAIAD_INC=-I$(NAIAD_PATH)/server/include/Ng -I$(NAIAD_PATH)/server/include/Nb -I$(NAIAD_PATH)/server/include/em -I$(NAIAD_PATH)/server/include/system -I$(NAIAD_PATH)/server/include/Ni -I$(NAIAD_PATH)/server/include/Ng -I$(NAIAD_PATH)/server/include/Nb -I$(NAIAD_PATH)/server/include/em -I$(NAIAD_PATH)/server/include/system

# a) this library no longer requires the dynamics server (libNi), but
#    can just link against the free Naiad Base libarary (libNb)
# b) One should no longer link with imf or svml as they are now statically
#    linked to both libNb and libNi

NAIAD_LIBS=-lNb -liomp5 -lpthread

LIBDIRS=-L$(HFS)/python/lib -L$(NAIAD_PATH)/server/lib -L$(NAIAD_PATH)/lib -Wl,-rpath=$(HFS)/dsolib
INCDIRS= -O2 -Iinclude -I$(HFS)/toolkit/include $(NAIAD_INC)
LIBS=$(NAIAD_LIBS)
DSONAME=bin/ROP_NaiadCamera.so
SOURCES= src/rop_naiadcam/ROP_NaiadCam.C

ifeq ("$(HOUDINI_MAJOR_RELEASE).$(HOUDINI_MINOR_RELEASE)", "10.5")
	#Include a locally modified (fixed) makefile for Houdini 10.5
	include Makefile_10_5.gnu
else
	include $(HFS)/toolkit/makefiles/Makefile.gnu
endif

