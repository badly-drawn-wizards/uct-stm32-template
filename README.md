What is this?
==
This is a template project for the UCT STM32F0 development board. It was
developed for my own use, but I attempt to make it accessible for others.

What is required for this?
==

To use this template you need to have installed:
- GNU make
- An arm-none-eabi compiler toolchain
- OpenOCD
and also have their respective bin directories in the PATH environment variable.

I also assume you are running the commands on a POSIX shell. A shell on Linux,
Cygwin or the Windows Subsystem for Linux should be fine.

How do I use this?
==
You can clone this repository using the git version control utility. If you are
allergic to [distributed tree models](https://xkcd.com/1597/) of version control
you can also download a zip file of this repository. This project template
consists of the following

- A `Makefile` to facilitate building and running your program on the UCT
  development board.

  - A Makefile consists of multiple targets which you may invoke by running
    `make <TARGET>`. For this Makefile you can run:

    - `make build` - Compile and link all the source files into the final binary
      under `dist/main.elf`

    - `make clean` - Remove everything under the `dist` folder. Useful if you
      want a fresh start, or made some changes in the Makefile.

    - `make openocd` - Runs OpenOCD in the foreground.

    - `make openocd &` - Runs OpenOCD in the background.

    - `make debug` - Runs gdb with the `gdb.txt` script that will connect to the
      running OpenOCD, loads the `main.elf` binary onto the development board and
      runs it to completion or until gdb is interrupted by pressing Ctrl+C

  - There may be some variables in the Makefile which you may need to modify
    such as

    - PROJECT\_FILES - The listing of source files under the `src` directory to
      be compiled.

    - OPENOCD\_DIR - The location of the OpenOCD installation.

    - STM\_PERIPH\_DIR - The location of the STM32F0xx StdPeriph library. You
      can leave this as is and follow the instructions located in the `vendor`
      folder

    - TOOLCHAIN\_LIBS - The location of the toolchain libraries (I'll add more
      options for other distributions later)

- `gdb.txt` - The script that runs on gdb when you run `make debug`.

- `linker.ld` - The linker script. This tells the linker program how code,
  constants and variables are mapped onto the ROM and RAM on your development
  board. This script is not mine and may be replaced in the future because of my
  not invented by me syndrome.

- `.gitignore` - Tells the git version control utility to ignore the build
  artifacts under the `dist` directory. It is irrelevant if you do not use
  git. You should be using git.
  
- `.dir-locals.el` - Tells Emacs about the project. It is irrelevant if you do
  not use Emacs. You don't have to use Emacs, but it is really cool.
