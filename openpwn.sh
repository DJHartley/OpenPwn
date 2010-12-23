#!/bin/sh
EXTENSION=$1
LEXTENSION=$(echo $1 | tr 'A-Z' 'a-z')
mkdir $LEXTENSION
cd $LEXTENSION
mkdir src
mkdir includes
mkdir build

cat > README << __END
OpenPwn - DarkMalloc
$EXTENSION has been created with OpenPwn - http://OpenPwn.org/
Not for use in commercial products - $EXTENSION should be Open-Source!

OpenPwn has neatly organised the required files into an includes and a src folder. All you need to do, in the directory that this README is in, is run make and the processor of the device your want this payload to run on. For example, for the iPhone 3G, iPhone 2G or iPod Touch 1G, you simply need to do: make s5l8900

Payload: $EXTENSION
Author: $USER

__END

cat > Makefile << __END
# Makefile for $EXTENSION
# $EXTENSION has been created with OpenPwn - http://OpenPwn.org/
# Not for use in commercial products - $EXTENSION should be Open-Source!

s5l8900:
	@cd src;make s5l8900;cd ..;

s5l8920:
	@cd src;make s5l8920;cd ..;
	
s5l8720:
	@cd src;make s5l8720;cd ..;
	
s5l8922:
	@cd src;make s5l8922;cd ..;
	
s5l8930:
	@cd src;make s5l8930; cd ..;

package:
	tar cjf $LEXTENSION.tar.gz includes src build README Makefile

__END

cd src

cat > entry.S << __END
@ OpenPwn - DarkMalloc
@ $EXTENSION has been created with OpenPwn - http://OpenPwn.org/
@ Not for use in commercial products - $EXTENSION should be Open-Source!

.arm
.text
_start:
.global _start
  @ store registers
  stmfd  sp!, {r0-r12,lr}
  
  @ branch with link to the main function
  bl   main
  
  ldmfd  sp!, {r0-r12,pc}
  
__END

cat > main.c << __END
// OpenPwn - DarkMalloc
// $EXTENSION has been created with OpenPwn - http://OpenPwn.org/
// Not for use in commercial products - $EXTENSION should be Open-Source!

#include "commands.h"

typedef unsigned short uint16_t;
typedef unsigned long uint32_t;

//Macros (used for writing to memory addresses)
#define SET_REG16(x, y) (*((volatile uint16_t*)(x)) = (y))
#define SET_REG32(x, y) (*((volatile uint32_t*)(x)) = (y))
//End of Macros

int main(int argc, CmdArg* argv) {


}

__END

cat > Makefile << __END

# Makefile for $EXTENSION
# $EXTENSION has been created with OpenPwn - http://OpenPwn.org/
# Not for use in commercial products - $EXTENSION should be Open-Source!


s5l8900:
	arm-elf-gcc entry.S main.c -I../includes -o ../build/test.elf -nostdlib -mthumb-interwork -lc -lgcc -Ttext=0x09000000
	arm-elf-objcopy -O binary ../build/test.elf ../build/test.bin

s5l8920:
	arm-elf-gcc entry.S main.c -I../includes -o ../build/test.elf -nostdlib -mthumb-interwork -lc -lgcc -Ttext=0x41000000
	arm-elf-objcopy -O binary ../build/test.elf ../build/test.bin

s5l8922:
	arm-elf-gcc entry.S main.c -I../includes -o ../build/test.elf -nostdlib -mthumb-interwork -lc -lgcc -Ttext=0x41000000
	arm-elf-objcopy -O binary ../build/test.elf ../build/test.bin
	
s5l8720:
	arm-elf-gcc entry.S main.c -I../includes -o ../build/test.elf -nostdlib -mthumb-interwork -lc -lgcc -Ttext=0x09000000
	arm-elf-objcopy -O binary ../build/test.elf ../build/test.bin

s5l8930:
	arm-elf-gcc entry.S main.c -I../includes -o ../build/test.elf -nostdlib -mthumb-interwork -lc -lgcc -Ttext=0x41000000
	arm-elf-objcopy -O binary ../build/test.elf ../build/test.bin

__END


cd ../includes

cat > commands.h << __END
// OpenPwn - DarkMalloc
// $EXTENSION has been created with OpenPwn - http://OpenPwn.org/
// Not for use in commercial products - $EXTENSION should be Open-Source!

//Commands.h is used to correctly pass arguments to your payloads main function.

enum {
    kCmdArgTypeString = 0,
    kCmdArgTypeInteger = 1
};

typedef struct CmdArg {
    signed int unk1;
    unsigned int uinteger;
    signed int integer;
    unsigned int type;
    unsigned char* string;
} CmdArg;


__END

echo "$EXTENSION has been created!"
echo "Thanks for using OpenPwn! - http://OpenPwn.org/"