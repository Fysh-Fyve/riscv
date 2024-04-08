--! \file rom_pkg.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use work.fysh_fyve.all;
--! @endcond

--! Autogenerated package containing the ROM.\n
package rom is
  constant rom_arr : mem_t (0 to ROM_NUM_WORDS-1) := (
    x"37210100",
    x"ef00001a",
    x"63000000",
    x"6b050000",
    x"67800000",
    x"b7050000",
    x"83a5c536",
    x"83a50500",
    x"33d5a500",
    x"13751500",
    x"67800000",
    x"130101ff",
    x"23261100",
    x"23248100",
    x"23229100",
    x"b7040000",
    x"03a50437",
    x"b7150100",
    x"1384d5dc",
    x"93050400",
    x"ef00c00e",
    x"33058500",
    x"23a8a436",
    x"8320c100",
    x"03248100",
    x"83244100",
    x"13010101",
    x"67800000",
    x"b7050000",
    x"23a8a536",
    x"67800000",
    x"37050000",
    x"0325c536",
    x"03250500",
    x"67800000",
    x"b7050000",
    x"83a5c536",
    x"23a0a500",
    x"67800000",
    x"37060000",
    x"03268636",
    x"83260600",
    x"13071000",
    x"3315a700",
    x"63880500",
    x"33e5a600",
    x"2320a600",
    x"67800000",
    x"1345f5ff",
    x"33f5a600",
    x"2320a600",
    x"67800000",
    x"37060000",
    x"0326c636",
    x"83260600",
    x"13071000",
    x"3315a700",
    x"63880500",
    x"33e5a600",
    x"2320a600",
    x"67800000",
    x"1345f5ff",
    x"33f5a600",
    x"2320a600",
    x"67800000",
    x"37050000",
    x"03254536",
    x"03250500",
    x"67800000",
    x"9305f000",
    x"63eea500",
    x"13152500",
    x"b7050000",
    x"9385052d",
    x"3385a500",
    x"03250500",
    x"67800000",
    x"13050000",
    x"67800000",
    x"13060000",
    x"63000502",
    x"9316f501",
    x"93d6f641",
    x"b3f6b600",
    x"3386c600",
    x"13551500",
    x"93951500",
    x"e31405fe",
    x"13050600",
    x"67800000",
    x"130101ff",
    x"23261100",
    x"23248100",
    x"1315d501",
    x"1355a501",
    x"93f57500",
    x"33e5a500",
    x"13040508",
    x"13050400",
    x"eff01ff0",
    x"13050400",
    x"8320c100",
    x"03248100",
    x"13010101",
    x"67800000",
    x"130101fe",
    x"232e1100",
    x"232c8100",
    x"232a9100",
    x"23282101",
    x"23263101",
    x"13058001",
    x"93050000",
    x"eff09fed",
    x"13059001",
    x"93050000",
    x"eff0dfec",
    x"1305a001",
    x"93050000",
    x"eff01fec",
    x"1305b001",
    x"93050000",
    x"eff05feb",
    x"37040000",
    x"232a0436",
    x"b7040000",
    x"23ac0436",
    x"37090000",
    x"232e0936",
    x"b7090000",
    x"13050040",
    x"23a0a938",
    x"6f00c000",
    x"13051500",
    x"232ea936",
    x"03254437",
    x"83a58437",
    x"eff05ff4",
    x"83a58437",
    x"03254437",
    x"93852500",
    x"eff05ff3",
    x"83a58437",
    x"03254437",
    x"93853500",
    x"eff05ff2",
    x"03254437",
    x"83a58437",
    x"13051500",
    x"93851500",
    x"eff01ff1",
    x"03254437",
    x"83a58437",
    x"13051500",
    x"93854500",
    x"eff0dfef",
    x"03254437",
    x"83a58437",
    x"13052500",
    x"eff0dfee",
    x"03254437",
    x"83a58437",
    x"13052500",
    x"93852500",
    x"eff09fed",
    x"03254437",
    x"83a58437",
    x"13052500",
    x"93853500",
    x"eff05fec",
    x"0325c937",
    x"83a50938",
    x"e342b5f6",
    x"83254437",
    x"13050000",
    x"93851500",
    x"93f57500",
    x"232ab436",
    x"232e0936",
    x"6ff09ff4",
    x"3f000000",
    x"06000000",
    x"5b000000",
    x"4f000000",
    x"66000000",
    x"6d000000",
    x"7d000000",
    x"07000000",
    x"7f000000",
    x"6f000000",
    x"77000000",
    x"7c000000",
    x"39000000",
    x"5e000000",
    x"79000000",
    x"71000000",
    x"10000000",
    x"00000000",
    x"017a5200",
    x"017c0101",
    x"1b0c0200",
    x"18000000",
    x"18000000",
    x"3cfeffff",
    x"3c000000",
    x"00440e10",
    x"48810188",
    x"02000000",
    x"1c000000",
    x"34000000",
    x"5cfeffff",
    x"2c010000",
    x"00440e20",
    x"54810188",
    x"02890392",
    x"04930500",
    x"00000000",
    x"e4beadde",
    x"e8beadde",
    x"efbeadde",
    others => (31 downto 0 => '0')
    );
end package rom;
--! From binary file fysh/simple-matrix.hex
--! 	.text
--! 	.attribute	4, 16
--! 	.attribute	5, "rv32i2p1"
--! 	.file	"simple-matrix.fysh"
--! 	.globl	pixel                           # -- Begin function pixel
--! 	.p2align	2
--! 	.type	pixel,@function
--! pixel:                                  # @pixel
--! 	.cfi_startproc
--! # %bb.0:                                # %entry
--! 	addi	sp, sp, -16
--! 	.cfi_def_cfa_offset 16
--! 	sw	ra, 12(sp)                      # 4-byte Folded Spill
--! 	sw	s0, 8(sp)                       # 4-byte Folded Spill
--! 	.cfi_offset ra, -4
--! 	.cfi_offset s0, -8
--! 	slli	a0, a0, 29
--! 	srli	a0, a0, 26
--! 	andi	a1, a1, 7
--! 	or	a0, a1, a0
--! 	addi	s0, a0, 128
--! 	mv	a0, s0
--! 	call	fysh_gpio_write_all
--! 	mv	a0, s0
--! 	lw	ra, 12(sp)                      # 4-byte Folded Reload
--! 	lw	s0, 8(sp)                       # 4-byte Folded Reload
--! 	addi	sp, sp, 16
--! 	ret
--! .Lfunc_end0:
--! 	.size	pixel, .Lfunc_end0-pixel
--! 	.cfi_endproc
--!                                         # -- End function
--! 	.globl	main                            # -- Begin function main
--! 	.p2align	2
--! 	.type	main,@function
--! main:                                   # @main
--! 	.cfi_startproc
--! # %bb.0:                                # %entry
--! 	addi	sp, sp, -32
--! 	.cfi_def_cfa_offset 32
--! 	sw	ra, 28(sp)                      # 4-byte Folded Spill
--! 	sw	s0, 24(sp)                      # 4-byte Folded Spill
--! 	sw	s1, 20(sp)                      # 4-byte Folded Spill
--! 	sw	s2, 16(sp)                      # 4-byte Folded Spill
--! 	sw	s3, 12(sp)                      # 4-byte Folded Spill
--! 	.cfi_offset ra, -4
--! 	.cfi_offset s0, -8
--! 	.cfi_offset s1, -12
--! 	.cfi_offset s2, -16
--! 	.cfi_offset s3, -20
--! 	li	a0, 24
--! 	li	a1, 0
--! 	call	pin_mode
--! 	li	a0, 25
--! 	li	a1, 0
--! 	call	pin_mode
--! 	li	a0, 26
--! 	li	a1, 0
--! 	call	pin_mode
--! 	li	a0, 27
--! 	li	a1, 0
--! 	call	pin_mode
--! 	lui	s0, %hi(.Lx)
--! 	sw	zero, %lo(.Lx)(s0)
--! 	lui	s1, %hi(.Ly)
--! 	sw	zero, %lo(.Ly)(s1)
--! 	lui	s2, %hi(.Lcount)
--! 	sw	zero, %lo(.Lcount)(s2)
--! 	lui	s3, %hi(.Lcount_lim)
--! 	li	a0, 1024
--! 	sw	a0, %lo(.Lcount_lim)(s3)
--! 	j	.LBB1_2
--! .LBB1_1:                                # %if_exit
--!                                         #   in Loop: Header=BB1_2 Depth=1
--! 	addi	a0, a0, 1
--! 	sw	a0, %lo(.Lcount)(s2)
--! .LBB1_2:                                # %loop_cond
--!                                         # =>This Inner Loop Header: Depth=1
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	call	pixel
--! 	lw	a1, %lo(.Ly)(s1)
--! 	lw	a0, %lo(.Lx)(s0)
--! 	addi	a1, a1, 2
--! 	call	pixel
--! 	lw	a1, %lo(.Ly)(s1)
--! 	lw	a0, %lo(.Lx)(s0)
--! 	addi	a1, a1, 3
--! 	call	pixel
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	addi	a0, a0, 1
--! 	addi	a1, a1, 1
--! 	call	pixel
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	addi	a0, a0, 1
--! 	addi	a1, a1, 4
--! 	call	pixel
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	addi	a0, a0, 2
--! 	call	pixel
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	addi	a0, a0, 2
--! 	addi	a1, a1, 2
--! 	call	pixel
--! 	lw	a0, %lo(.Lx)(s0)
--! 	lw	a1, %lo(.Ly)(s1)
--! 	addi	a0, a0, 2
--! 	addi	a1, a1, 3
--! 	call	pixel
--! 	lw	a0, %lo(.Lcount)(s2)
--! 	lw	a1, %lo(.Lcount_lim)(s3)
--! 	blt	a0, a1, .LBB1_1
--! # %bb.3:                                # %then
--!                                         #   in Loop: Header=BB1_2 Depth=1
--! 	lw	a1, %lo(.Lx)(s0)
--! 	li	a0, 0
--! 	addi	a1, a1, 1
--! 	andi	a1, a1, 7
--! 	sw	a1, %lo(.Lx)(s0)
--! 	sw	zero, %lo(.Lcount)(s2)
--! 	j	.LBB1_1
--! .Lfunc_end1:
--! 	.size	main, .Lfunc_end1-main
--! 	.cfi_endproc
--!                                         # -- End function
--! 	.type	.Lx,@object                     # @x
--! 	.section	.sbss,"aw",@nobits
--! 	.p2align	2, 0x0
--! .Lx:
--! 	.word	0                               # 0x0
--! 	.size	.Lx, 4
--! 
--! 	.type	.Ly,@object                     # @y
--! 	.p2align	2, 0x0
--! .Ly:
--! 	.word	0                               # 0x0
--! 	.size	.Ly, 4
--! 
--! 	.type	.Lcount,@object                 # @count
--! 	.p2align	2, 0x0
--! .Lcount:
--! 	.word	0                               # 0x0
--! 	.size	.Lcount, 4
--! 
--! 	.type	.Lcount_lim,@object             # @count_lim
--! 	.p2align	2, 0x0
--! .Lcount_lim:
--! 	.word	0                               # 0x0
--! 	.size	.Lcount_lim, 4
--! 
--! 	.section	".note.GNU-stack","",@progbits
--! ></*>
--! Simple 8x8 matrix!
--! C1 - JE1 - gpio[24]
--! C2 - JE2 - gpio[25]
--! C3 - JE3 - gpio[26]
--! R1 - JE4 - gpio[27]
--! R2 - JE5 - gpio[28]
--! R3 - JE6 - gpio[29]
--! EN - JE7 - gpio[30]
--! 
--! Buttons:
--! H - gpio[0]
--! J - gpio[1]
--! K - gpio[2]
--! L - gpio[3]
--! 
--! o x o o x x x x
--! x o x x o x x x
--! o x o o x x x x
--! x x x x x x x x
--! o x o o x x x x
--! x o x x o x x x
--! o x o o x x x x
--! x x x x x x x x
--! 
--! 0,0
--! 0,2
--! 0,3
--! 1,1
--! 1,4
--! 2,0
--! 2,2
--! 2,3
--! <*/><
--! 
--! >(pixel) ><row> ><col>
--! ><>
--!    (+o  (><{°> << ><{{{°>) | ><//> Output enable
--!         ((><row> & ><{{{°>) << ><{{°>) | ><//> Row is next higher 3 bits
--!         (><col> & ><{{{°>) ~ ><//> Col is first 3 bits
--! <><
--! 
--! ><//> It's little endian somehow so we gotta start at 24
--! ><//> Set buttons as input
--! [><{{(((°> >(pin_mode) ><(°>] ~
--! [><{{(({°> >(pin_mode) ><(°>] ~
--! [><{{({(°> >(pin_mode) ><(°>] ~
--! [><{{({{°> >(pin_mode) ><(°>] ~
--! 
--! ><//> TODO: Buttons
--! ><x> = ><(°> ~
--! ><y> = ><(°> ~
--! ><count> = ><(°> ~
--! ><count_lim> = ><{((((((((((°> ~
--! 
--! ><(((@> [><{°>] ><//> 1
--! ><>
--!    [><x>        >(pixel)  ><y>        ] ~ ><//> 0 0
--!    [><x>        >(pixel)  ><y> ><{(°> ] ~ ><//> 0 2
--!    [><x>        >(pixel)  ><y> ><{{°> ] ~ ><//> 0 3
--!    [><x> ><{°>  >(pixel)  ><y> ><{°>  ] ~ ><//> 1 1
--!    [><x> ><{°>  >(pixel)  ><y> ><{((°>] ~ ><//> 1 4
--!    [><x> ><{(°> >(pixel)  ><y>        ] ~ ><//> 2 0
--!    [><x> ><{(°> >(pixel)  ><y> ><{(°> ] ~ ><//> 2 2
--!    [><x> ><{(°> >(pixel)  ><y> ><{{°> ] ~ ><//> 2 3
--!    ><//> [>(wait increment) ><{((((((((((°> ] ~ ><//> 1024
--! 
--!    ><(((^> [><count> o≈ ><count_lim>]
--!    ><>
--!       ><x> = (><x> ><{°>) & ><{{{°> ~ ><//> x = (x + 1) & 7 (reset to 0 if 8)
--!       ><count> = ><(°> ~
--!    <><
--!    >><count> ~
--! <><
--! 
--! 
--! 
--! 
--! ><//> we're just being nice to LLVM
--! ><(°> ~
