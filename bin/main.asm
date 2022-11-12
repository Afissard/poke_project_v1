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
	.globl _set_sprite_data
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
;.\src\main.c:18: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;.\src\main.c:19: UINT8 currentSpriteIndex = 0;   // unsigned int of 8 byte because of speed and memory optimisation
	ld	c, #0x00
;.\src\main.c:20: set_sprite_data(0,2, sprite_1); // add to sprite memory the 2 tile of sprite_1
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
;.\src\main.c:23: SHOW_SPRITES;                   // update the sprites layer ...
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;.\src\main.c:25: while(1){   // game loop
00105$:
;.\src\main.c:26: if(currentSpriteIndex == 0){
	ld	a, c
	or	a, a
;.\src\main.c:27: currentSpriteIndex = 1;
;.\src\main.c:30: currentSpriteIndex = 0;
	ld	c, #0x01
	jr	Z, 00103$
	ld	c, #0x00
00103$:
;C:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;.\src\main.c:34: delay(1000); // TODO : FIND AN NON BLOCKING WAIT FUNCTION
	push	bc
	ld	de, #0x03e8
	call	_delay
	pop	bc
;.\src\main.c:36: }
	jr	00105$
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
