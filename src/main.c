/*
Current objectives of the project :
Having a small map to demonstrate all the mechaniques currently implement :
- Having collision detection of the player -> and event (door, speak to pnj).
- Having diffrent GUI : start menu, inventory, dialogue with a pnj, battle menu
- Battle systeme (customisable for the demo)

TODO list :
- find a better option to replace the 'delay()' (non blocking timer...)
- fix the bug that make the player move faster in diagonal than in horizontal/vertical line.

Compilation & execution :
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
// Sprites
#include "..\asset\sprites\sprite_1.c"              // a demo sprite
// Maps :
#include "..\asset\backgrounds\overworld_tile_1.c"  // tile of the map for the demo
#include "..\asset\backgrounds\overworld_map_1.c"   // map for the demo

uint8_t demo_sprite(uint8_t currentSpriteIndex){
    /*
    Fonction for playing with sprite animation, 
    should desapear in a near future
    */
    if(currentSpriteIndex == 0){
        currentSpriteIndex = 1;
        scroll_sprite(0, 10, 0);    // move the 1st sprite of 10 pixels
    }
    else{
        currentSpriteIndex = 0;
        scroll_sprite(0, -10, 0);    // move the 1st sprite of 10 pixels
    }
    set_sprite_tile(0, currentSpriteIndex);
    return currentSpriteIndex;
}

void player_move(uint8_t keys){
    /*
    fonction to move the player sprite across the map :
    the player sprite dont realy move but the background move 
    and the player stay at the center

    The origin point of an orthonormal frame for computer is in the
    top left of the screen and not in the botom left like in math.
    So for exemple to go up you have to do : y-up_value
    */
    if(keys & J_LEFT){              // LEFT button
        //scroll_sprite(0, -1, 0);
        scroll_bkg(-1,0);
    }
    if(keys & J_RIGHT){             // RIGHT button
        //scroll_sprite(0, 1, 0);
        scroll_bkg(1,0);
    }
    if(keys & J_UP){                // UP button
        //scroll_sprite(0, 0, -1);
        scroll_bkg(0,-1);
    }
    if(keys & J_DOWN){              // DOWN button
        //scroll_sprite(0, 0, 1);
        scroll_bkg(0,1);
    }
}

void main(){
    // Setup :
    // Joypad :
    uint8_t keys;                       // store the joypad() value

    /* DISPLAY :
    There is three layer of rendering :
    - screen layer (UI and text)
    - sprite layer (sprites)
    - background layer (backround)
    */
    // Sprites :
    uint8_t currentSpriteIndex = 0;     // unsigned int of 8 byte because of speed and memory optimisation
    set_sprite_data(0, 2, sprite_1);    // add to sprite memory the 2 tile of sprite_1
    set_sprite_tile(0,0);               // 1st sprite load from the 1st tile
    move_sprite(0, 88, 78);             // move the 1st sprite to the coord x=88 & y=78
    SHOW_SPRITES;                       // show the sprites layer
    // Backgrounds :
    set_bkg_data(0, 36, overworld_tile_1);      // add to background memory the 37 tile of the overworld_map_1
    set_bkg_tiles(0,0, 40,36, overworld_map_1); // show the map load from the tile set of the background
    SHOW_BKG;                                   // show the background layer

    DISPLAY_ON; // turn ON the screen

    // Game Loop :
    while(1){
        keys = joypad();    // the value is updated each time the loop restart

        //currentSpriteIndex = demo_sprite(currentSpriteIndex);
        player_move(keys);

        delay(10);          // TODO : FIND AN NON BLOCKING WAIT FUNCTION
    }
}