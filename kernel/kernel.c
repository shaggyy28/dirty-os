#include "./include/drivers/screen.h"

char* vidmem = (char*) 0xB8000;
char X = 'A';
void main () {

    // clear_screen();
    // screen_init();
    // print("Hello");
    
    vidmem[0] = X;
    vidmem[1] = 0x96;
    clear_screen();
    screen_init();
    print("hello");
}

