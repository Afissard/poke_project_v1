/*
To compile the project, just run the make.bat locate at the project root
You can found the main.gb in the bin folder

The ressources that I use :
Github page of the GBDK 2020 lib : https://github.com/gbdk-2020/gbdk-2020
YT playlist to learn how to program with GBDK 2020 : 
https://www.youtube.com/playlist?list=PLeEj4c2zF7PaFv5MPYhNAkBGrkx4iPGJo

*/
// libs :
#include <gb/gb.h>
#include <stdio.h>

// game assets :
#include "..\asset\sprite_1.c"  // a demo sprite

void main(){
    uint8_t currentSpriteIndex = 0;     // unsigned int of 8 byte because of speed and memory optimisation
    set_sprite_data(0,2, sprite_1);     // add to sprite memory the 2 tile of sprite_1
    set_sprite_tile(0,0);               // 1st sprite load from the 1st tile
    move_sprite(0, 88, 78);             // move the 1st sprite to the coord x=88 & y=78
    SHOW_SPRITES;                       // update the sprites layer ...

    while(1){   // game loop
        if(currentSpriteIndex == 0){
            currentSpriteIndex = 1;
            scroll_sprite(0, 10, 0);    // move the 1st sprite of 10 pixels
        }
        else{
            currentSpriteIndex = 0;
            scroll_sprite(0, -10, 0);    // move the 1st sprite of 10 pixels
        }
        set_sprite_tile(0, currentSpriteIndex);
        

        delay(1000); // TODO : FIND AN NON BLOCKING WAIT FUNCTION
    }
}