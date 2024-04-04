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
    x"ef00401b",
    x"63000000",
    x"6b050000",
    x"67800000",
    x"b7050000",
    x"83a5852e",
    x"83a50500",
    x"33d5a500",
    x"13751500",
    x"67800000",
    x"130101ff",
    x"23261100",
    x"23248100",
    x"23229100",
    x"b7040000",
    x"03a5c42e",
    x"b7150100",
    x"1384d5dc",
    x"93050400",
    x"ef00c00e",
    x"33058500",
    x"23a6a42e",
    x"8320c100",
    x"03248100",
    x"83244100",
    x"13010101",
    x"67800000",
    x"b7050000",
    x"23a6a52e",
    x"67800000",
    x"37050000",
    x"0325852e",
    x"03250500",
    x"67800000",
    x"b7050000",
    x"83a5852e",
    x"23a0a500",
    x"67800000",
    x"37060000",
    x"0326462e",
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
    x"0326862e",
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
    x"0325052e",
    x"03250500",
    x"67800000",
    x"9305f000",
    x"63eea500",
    x"13152500",
    x"b7050000",
    x"93854525",
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
    x"23229100",
    x"13840500",
    x"93040500",
    x"eff0dfef",
    x"137505f0",
    x"93943400",
    x"33649400",
    x"3365a400",
    x"13640508",
    x"13050400",
    x"eff01fef",
    x"13050400",
    x"8320c100",
    x"03248100",
    x"83244100",
    x"13010101",
    x"67800000",
    x"130101ff",
    x"23261100",
    x"13058001",
    x"93050000",
    x"eff05fed",
    x"13059001",
    x"93050000",
    x"eff09fec",
    x"1305a001",
    x"93050000",
    x"eff0dfeb",
    x"1305b001",
    x"93050000",
    x"eff01feb",
    x"13050000",
    x"93050000",
    x"eff01ff7",
    x"93052000",
    x"13050000",
    x"eff05ff6",
    x"93053000",
    x"13050000",
    x"eff09ff5",
    x"13051000",
    x"93051000",
    x"eff0dff4",
    x"13051000",
    x"93054000",
    x"eff01ff4",
    x"13052000",
    x"93050000",
    x"eff05ff3",
    x"13052000",
    x"93052000",
    x"eff09ff2",
    x"13052000",
    x"93053000",
    x"eff0dff1",
    x"6ff01ffa",
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
    x"b8feffff",
    x"50000000",
    x"00440e10",
    x"4c810188",
    x"02890300",
    x"14000000",
    x"34000000",
    x"ecfeffff",
    x"9c000000",
    x"00440e10",
    x"44810100",
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
--! 	sw	s1, 4(sp)                       # 4-byte Folded Spill
--! 	.cfi_offset ra, -4
--! 	.cfi_offset s0, -8
--! 	.cfi_offset s1, -12
--! 	mv	s0, a1
--! 	mv	s1, a0
--! 	call	fysh_gpio_read_all
--! 	andi	a0, a0, -256
--! 	slli	s1, s1, 3
--! 	or	s0, s0, s1
--! 	or	a0, s0, a0
--! 	ori	s0, a0, 128
--! 	mv	a0, s0
--! 	call	fysh_gpio_write_all
--! 	mv	a0, s0
--! 	lw	ra, 12(sp)                      # 4-byte Folded Reload
--! 	lw	s0, 8(sp)                       # 4-byte Folded Reload
--! 	lw	s1, 4(sp)                       # 4-byte Folded Reload
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
--! 	addi	sp, sp, -16
--! 	.cfi_def_cfa_offset 16
--! 	sw	ra, 12(sp)                      # 4-byte Folded Spill
--! 	.cfi_offset ra, -4
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
--! .LBB1_1:                                # %loop_cond
--!                                         # =>This Inner Loop Header: Depth=1
--! 	li	a0, 0
--! 	li	a1, 0
--! 	call	pixel
--! 	li	a1, 2
--! 	li	a0, 0
--! 	call	pixel
--! 	li	a1, 3
--! 	li	a0, 0
--! 	call	pixel
--! 	li	a0, 1
--! 	li	a1, 1
--! 	call	pixel
--! 	li	a0, 1
--! 	li	a1, 4
--! 	call	pixel
--! 	li	a0, 2
--! 	li	a1, 0
--! 	call	pixel
--! 	li	a0, 2
--! 	li	a1, 2
--! 	call	pixel
--! 	li	a0, 2
--! 	li	a1, 3
--! 	call	pixel
--! 	j	.LBB1_1
--! .Lfunc_end1:
--! 	.size	main, .Lfunc_end1-main
--! 	.cfi_endproc
--!                                         # -- End function
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
--!    o+) ><gpio> ~
--!    (+o (><gpio> &
--!          (<°}>< << ><{{{°>) ></*> keep everything in GPIO
--!                                   the same but the first 7 bits <*/><
--!         ) |
--!         (><{°> << ><{{{°>) | ><//> Output enable
--!         (><row> << ><{{°>) | ><//> Row is next higher 3 bits
--!         ><col> ~ ><//> Col is first 3 bits
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
--! 
--! ><(((@> [><{°>]
--! ><>
--!    [><(°>  >(pixel)  ><(°>  ] ~
--!    [><(°>  >(pixel)  ><{(°> ] ~
--!    [><(°>  >(pixel)  ><{{°> ] ~
--!    [><{°>  >(pixel)  ><{°>  ] ~
--!    [><{°>  >(pixel)  ><{((°>] ~
--!    [><{(°> >(pixel)  ><(°>  ] ~
--!    [><{(°> >(pixel)  ><{(°> ] ~
--!    [><{(°> >(pixel)  ><{{°> ] ~
--! <><
--! 
--! ><//> we're just being nice to LLVM
--! ><(°> ~
