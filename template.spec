Name:                           # The base name of the package, which should match the SPEC file name
Version:	                    # The upstream version number of the software
Release:	1%{?dist}           # The number of times this version of the software was released
Summary:	                    # A brief, one-line summary of the package

Group:		                    # Used to define how the packaged software should be grouped with other packages
License:	                    # The license of the software being packaged
URL:		                    # The full URL for more information about the program
Source0:	                    # Path or URL to the compressed archive of the upstream source code. This should point to an accessible and reliable storage of the archive. More SourceX directives can be added, incrementing the number each time (ex: Source1, Source2, Source3, etc.)

BuildRequires:	                # List of packages required for building the program written in a compiled language (must be separated by comma or whitespace)
Requires:	                    # List of packages required by the software to run once installed (must be separated by comma or whitespace)

%description                    # A full description of the software packaged in the RPM


%prep                           # Command(s) to prepare the software to be built (ex: unpacking the archive in Source0). This can contain a shell script.
%setup -q                       # %setup ensures that we are working in the right directory, removes residues of previous builds, unpacks the source tarball, and sets up some default privileges. Option -q limits verbosity of %setup macro. Only tar -xof is executed instead of tar -xvvof. This option has to be used as first.


%build                          # Command(s) for actually building the software into machine code (for compiled languages) or byte code (for some interpreted languages).
%configure                      # Command to call a configuration script
make %{?_smp_mflags}            # This macro is often used to pass to Makefile (make) and to set a number of concurrent processes during the build phase. By default, it is set to -jX, where X is a number of cores. If you alter the number of cores, you can speed up or slow down a build of packages.


%install                        # Command(s) for copying the desired build artifacts from the %builddir (where the build happens) to the %buildroot directory (which contains the directory structure with the files to be packaged). This is only run when creating a package, not when the end-user installs the package. 
make install DESTDIR=%{buildroot}   # Automates installation of built software to our destination directory, %buildroot (via DESTDIR command). "Buildroot" is a chroot environment, which means that the build artifacts are placed here using the same filesystem hierarchy as will be in the end user’s system, with "buildroot" acting as the root directory. The placement of build artifacts should comply with the filesystem hierarchy standard of the end user’s system.


%files                          # The list of files that will be installed in the end user’s system
%doc                            # Identifies the file listed as documentation and it will be installed and labeled as such by RPM. In the event code examples are included, care should be taken to remove executable mode from the file. (Example: %doc README)



%changelog                      # A record of changes that have happened to the package between different Version or Release builds.
