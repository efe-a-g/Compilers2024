# Compilers

This repo contains the lab materials for Compilers, written by Mike Spivey. Last edited by Mike Spivey in 2023, cloned by Matty Hoban from a private repo in 2024. Many thanks to Joe Pitt-Francis for help with the retrieval of the latter. A small amendment to the tests in lab4 was made as access to the Raspberry Pi has ended - test run on an emulator instead. 

The following subdirectories are in this repo:

* lab1:        Code for Lab 1 -- expressions and statements
* lab2:        Code for Lab 2 -- arrays
* lab3:        Code for Lab 3 -- procedures
* lab4:        Code for Lab 4 -- machine code
* keiko:       Keiko bytecode interpreter
* lib:        Shared utility routines
* tools:       Tools for Lab 4
* ppc4:        Complete picoPascal compiler for Keiko


## CS Departmental Setup 

If you are cloning this repo into a CS Lab machine then you should have all the resources needed to complete the lab tasks. There are options for text editors/IDEs, with Geany recommended by Mike Spivey in previous iterations of the course. Mercurial was also recommended as a version control platform, but you can use this or Git, and interchange between them, if you do wish. It's recommended to use version control so you can generate diffs, i.e. files logging changes made in files within the repo; this is useful for the Christmas assignment.

If you wish to use the resources outside of the lab machines, there are instructions below.

## Your Own Environment

The code was developed within a Unix environment (using tclsh commands in the executable files), so to get everything working you need something similar. The following, written largely by Mike Spivey, will hopefully allow you to do everything on your own machine. 

### Install Linux on a PC

Mike Spivey used Debian on a laptop to prepare the lab exercises. If you also have Debian or another Debian-based distribution such as Ubuntu, then you can set up the software you need with these commands:

```
$ sudo apt-get install mercurial mercurial-git gcc tcl ocaml-nox
$ sudo apt-get install qemu-user gcc-arm-linux-gnueabihf
```

This installs:

* Mercurial for version control, with the hg-git extension to access Git repositories.
* GCC to compile the Keiko assembler and runtime system.
* TCL, needed to generate the Kieko interpreter from an abstract description, and by the make setup to interpret error messages from OCaml.
* OCaml, needed to compile the compilers written in the course. (The -nox variant does not include the libraries needed for writing X Window applications in OCaml, which are irrelevant to the course.)
* The user-mode parts of QEMU, needed to run ARM code output by the Lab 4 compiler.
* The ARM version of GCC, needed to compile the startup and library code that goes with our compiler output. This brings with it the ARM assembler and linker. Gnueabihf denotes the calling convention used on the Raspberry Pi: it is the Gnu variant of the ARM Extended Application Binary Interface with Hardware Floating-point. Note: This is different from the compiler gcc-arm-none-eabi that we used for the Digital Systems course.

If you like, you can also install the Geany programming environment that Mike Spivey has recommended for use in the labs, together with the project organizer plugin, which is helpful for editing multi-file programs like the compilers.

```
$ sudo apt-get install geany geany-plugin-projectoganizer
```

You will then have an environment that approximates closely the setup we have in the software lab.

### Using an Apple machine

The lab materials work well on a Mac (or an Intel-based one, anyway) with the help of MacPorts. You can set things up by following these steps:

* Install MacPorts itself following the instructions at https://www.macports.org/install.php. This involves installing Apple XCode and its command-line components, which will also be needed later.
* Install the needed components with `sudo port install mercurial ocaml`.

You can now download and compile the lab software just as under Linux, and Labs 1, 2 and 3 will work perfectly.

It is possible to build the compiler for Lab4, but without the ARM version of GCC or QEMU installed, you will not be able to test locally the code output by the compiler. Options for testing the code include the following.

* Use `make test2` to test by connecting to the Software Lab machines. To do this remotely, you will need to connect to the Oxford VPN first, because the Lab machines don't allow SSH access from outside the Oxford network. If you forget to connect to the VPN, the symptom is that the process will just hang.

In theory, versions of GCC for the ARM and QEMU exist for the Mac, but getting them to work and to work together may be more trouble than it's worth. If you do decide to try it, note that it is `gcc-arm-linux-gnueabihf` that you need, and not `gcc-arm-none-eabi`, which is designed for programming ARM-based microcontrollers on the bare metal (like the micro:bit that's used in the Digital Systems course). It doesn't help much with running the compiler output from Lab 4 to have an ARM-based Mac with 'Apple silicon', because those chips implement only the 64-bit instruction set that is called ARM64 or AARCH64, and omit the option to implement the ARM32 instruction set also.

### Using a Windows machine

You can install VirtualBox and a preconfigured 'virtual appliance' on Windows or an (Intel-based) Mac, by following the steps that are given by a pdf on the course webpage, called VirtualBox.pdf

Alternatively, see below.

Dominik Koller writes: In Windows 10, you can use the Linux Subsystem to run a shell and Linux software without installing a second operating system or virtual machine.

* Follow [these instructions](https://learn.microsoft.com/en-us/windows/wsl/install) to set up the Linux Subsystem.
* Dominik suggests [installing Ubuntu via the Microsoft Store](https://apps.microsoft.com/detail/9nblggh4msv6?activetab=pivot%3Aoverviewtab&hl=en-us&gl=US)
* Your subsystem is now an App in Windows which you can run like a terminal.
* In the subsystem, install optional software as detailed above in the Linux section.

For later parts of the course, Julia Irvine (Balliol College) confirms that it is possible to install `qemu-arm` under WSL and use it to run the ARM code output by our compilers. A number of small adjustments are needed:

* The ARM version of GCC needs the flag `--march=armv6+fp` in place of `--march=armv6` and you should edit the value of the ARMGCC variable in lab4/Makefile appropriately. This may be a change needed for recent versions of GCC on all hosts.
* Commands that use `diff` to compare object code become confused by the fact that the Windows version of the OCaml library uses CR/LF line endings for output, or alternatively that the Windows version of Git (if that is what you are using) may convert line endings. Add the `--strip-trailing-cr `flag to invocations of `diff` to compensate.

When editing files in Windows and compiling them with the tools we are building in the course, you may need to make sure the files use Unix line endings (simple line feed, LF) instead of default Windows line endings (carriage return line feed, CRLF). You should change this in the text editor you are using in Windows.

It's possible to build the Oxford Oberon-2 Compiler (also written in OCaml, and also targetting Keiko) on earlier versions of Windows with the help of Cygwin, a Windows environment that simulates Unix without the kernel support Microsoft added in Windows 10. But the number of special tricks and workarounds needed to get this to work is formidable. Adding QEMU into the mix takes us beyond Advanced Spells and Potions into the territory of Defence Against the Dark Arts. All told, it's probably simpler just to go with VirtualBox. 