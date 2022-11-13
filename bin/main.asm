;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _demo_sprite
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _sprite_1
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_sprite_1::
	.ds 32
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;.\src\main.c:18: uint8_t demo_sprite(uint8_t currentSpriteIndex){
;	---------------------------------
; Function demo_sprite
; ---------------------------------
_demo_sprite::
;.\src\main.c:19: if(currentSpriteIndex == 0){
	or	a, a
	jr	NZ, 00102$
;.\src\main.c:20: currentSpriteIndex = 1;
	ld	c, #0x01
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (de)
	ld	(de), a
	inc	de
	ld	a, (de)
	add	a, #0x0a
	ld	(de), a
;.\src\main.c:21: scroll_sprite(0, 10, 0);    // move the 1st sprite of 10 pixels
	jr	00103$
00102$:
;.\src\main.c:24: currentSpriteIndex = 0;
	ld	c, #0x00
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (de)
	ld	(de), a
	inc	de
	ld	a, (de)
	add	a, #0xf6
	ld	(de), a
;.\src\main.c:25: scroll_sprite(0, -10, 0);    // move the 1st sprite of 10 pixels
00103$:
;C:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;.\src\main.c:28: return currentSpriteIndex;
	ld	a, c
;.\src\main.c:29: }
	ret
;.\src\main.c:31: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;.\src\main.c:34: set_sprite_data(0,2, sprite_1);     // add to sprite memory the 2 tile of sprite_1
	ld	de, #_sprite_1
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;C:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;C:/gbdk/include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;.\src\main.c:37: SHOW_SPRITES;                       // show the sprites layer
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;.\src\main.c:46: while(1){   
00107$:
;.\src\main.c:49: switch(joypad()){
	call	_joypad
	ld	c, a
	dec	a
	jr	Z, 00102$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x04
	jr	Z, 00103$
	sub	a, #0x08
	jr	Z, 00104$
	jr	00105$
;.\src\main.c:55: case J_LEFT : scroll_sprite(0, -1, 0); break;
00101$:
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	dec	a
	ld	(bc), a
;.\src\main.c:55: case J_LEFT : scroll_sprite(0, -1, 0); break;
	jr	00105$
;.\src\main.c:56: case J_RIGHT : scroll_sprite(0, 1, 0); break;
00102$:
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	inc	a
	ld	(bc), a
;.\src\main.c:56: case J_RIGHT : scroll_sprite(0, 1, 0); break;
	jr	00105$
;.\src\main.c:57: case J_UP : scroll_sprite(0, 0, -1); break;
00103$:
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	dec	a
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;.\src\main.c:57: case J_UP : scroll_sprite(0, 0, -1); break;
	jr	00105$
;.\src\main.c:58: case J_DOWN : scroll_sprite(0, 0, 1); break;
00104$:
;C:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;C:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	inc	a
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;.\src\main.c:59: }
00105$:
;.\src\main.c:60: delay(10); // TODO : FIND AN NON BLOCKING WAIT FUNCTION
	ld	de, #0x000a
	call	_delay
;.\src\main.c:62: }
	jr	00107$
	.area _CODE
	.area _INITIALIZER
__xinit__sprite_1:
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xbd	; 189
	.db #0xc3	; 195
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbd	; 189
	.db #0xdb	; 219
	.db #0xa5	; 165
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0x66	; 102	'f'
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x89	; 137
	.db #0xf7	; 247
	.db #0xc3	; 195
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xc3	; 195
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x42	; 66	'B'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.area _CABS (ABS)
