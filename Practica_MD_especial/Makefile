MAKEFILE = Makefile
exe = simple
fcomp = gfortran #ifort # /opt/intel/compiler70/ia32/bin/ifc  
# Warning: the debugger doesn't get along with the optimization options
# So: not use -O3 WITH -g option
flags = -cpp -O3  
# Remote compilation
OBJS = ziggurat.o simple.o verlet_positions.o energy.o positions.o movie_vtf.o write_parameters.o energy_cin.o thermal_wall_sphere.o

.SUFFIXES:            # this deletes the default suffixes 
.SUFFIXES: .f90 .o    # this defines the extensions I want 

.f90.o:  
	$(fcomp) -c $(flags) $< 
        

$(exe):  $(OBJS) Makefile 
	$(fcomp) $(flags) -o $(exe) $(OBJS) 


clean:
	rm ./*.o ./*.mod	


simple.o: simple.f90 ziggurat.o verlet_positions.o energy.o positions.o movie_vtf.o write_parameters.o energy_cin.o thermal_wall_sphere.f90

