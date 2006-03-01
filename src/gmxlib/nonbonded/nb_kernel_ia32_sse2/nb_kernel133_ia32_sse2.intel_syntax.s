;#
;# $Id$
;#
;# Gromacs 4.0                         Copyright (c) 1991-2003 
;# David van der Spoel, Erik Lindahl
;#
;# This program is free software; you can redistribute it and/or
;# modify it under the terms of the GNU General Public License
;# as published by the Free Software Foundation; either version 2
;# of the License, or (at your option) any later version.
;#
;# To help us fund GROMACS development, we humbly ask that you cite
;# the research papers on the package. Check out http://www.gromacs.org
;# 
;# And Hey:
;# Gnomes, ROck Monsters And Chili Sauce
;#
;# These files require GNU binutils 2.10 or later, since we
;# use intel syntax for portability, or a recent version 
;# of NASM that understands Extended 3DNow and SSE2 instructions.
;# (NASM is normally only used with MS Visual C++).
;# Since NASM and gnu as disagree on some definitions and use 
;# completely different preprocessing options I have to introduce a
;# trick: NASM uses ';' for comments, while gnu as uses '#' on x86.
;# Gnu as treats ';' as a line break, i.e. ignores it. This is the
;# reason why all comments need both symbols...
;# The source is written for GNU as, with intel syntax. When you use
;# NASM we redefine a couple of things. The false if-statement around 
;# the following code is seen by GNU as, but NASM doesn't see it, so 
;# the code inside is read by NASM but not gcc.

; .if 0    # block below only read by NASM
%define .section	section
%define .long		dd
%define .align		align
%define .globl		global
;# NASM only wants 'dword', not 'dword ptr'.
%define ptr
.equiv          .equiv                  2
   %1 equ %2
%endmacro
; .endif                   # End of NASM-specific block
; .intel_syntax noprefix   # Line only read by gnu as



.globl nb_kernel133_ia32_sse2
.globl _nb_kernel133_ia32_sse2
nb_kernel133_ia32_sse2:	
_nb_kernel133_ia32_sse2:	
.equiv          nb133_p_nri,            8
.equiv          nb133_iinr,             12
.equiv          nb133_jindex,           16
.equiv          nb133_jjnr,             20
.equiv          nb133_shift,            24
.equiv          nb133_shiftvec,         28
.equiv          nb133_fshift,           32
.equiv          nb133_gid,              36
.equiv          nb133_pos,              40
.equiv          nb133_faction,          44
.equiv          nb133_charge,           48
.equiv          nb133_p_facel,          52
.equiv          nb133_argkrf,           56
.equiv          nb133_argcrf,           60
.equiv          nb133_Vc,               64
.equiv          nb133_type,             68
.equiv          nb133_p_ntype,          72
.equiv          nb133_vdwparam,         76
.equiv          nb133_Vvdw,             80
.equiv          nb133_p_tabscale,       84
.equiv          nb133_VFtab,            88
.equiv          nb133_invsqrta,         92
.equiv          nb133_dvda,             96
.equiv          nb133_p_gbtabscale,     100
.equiv          nb133_GBtab,            104
.equiv          nb133_p_nthreads,       108
.equiv          nb133_count,            112
.equiv          nb133_mtx,              116
.equiv          nb133_outeriter,        120
.equiv          nb133_inneriter,        124
.equiv          nb133_work,             128
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb133_ixO,              0
.equiv          nb133_iyO,              16
.equiv          nb133_izO,              32
.equiv          nb133_ixH1,             48
.equiv          nb133_iyH1,             64
.equiv          nb133_izH1,             80
.equiv          nb133_ixH2,             96
.equiv          nb133_iyH2,             112
.equiv          nb133_izH2,             128
.equiv          nb133_ixM,              144
.equiv          nb133_iyM,              160
.equiv          nb133_izM,              176
.equiv          nb133_iqH,              192
.equiv          nb133_iqM,              208
.equiv          nb133_dxO,              224
.equiv          nb133_dyO,              240
.equiv          nb133_dzO,              256
.equiv          nb133_dxH1,             272
.equiv          nb133_dyH1,             288
.equiv          nb133_dzH1,             304
.equiv          nb133_dxH2,             320
.equiv          nb133_dyH2,             336
.equiv          nb133_dzH2,             352
.equiv          nb133_dxM,              368
.equiv          nb133_dyM,              384
.equiv          nb133_dzM,              400
.equiv          nb133_qqH,              416
.equiv          nb133_qqM,              432
.equiv          nb133_c6,               448
.equiv          nb133_c12,              464
.equiv          nb133_tsc,              480
.equiv          nb133_fstmp,            496
.equiv          nb133_vctot,            512
.equiv          nb133_Vvdwtot,          528
.equiv          nb133_fixO,             544
.equiv          nb133_fiyO,             560
.equiv          nb133_fizO,             576
.equiv          nb133_fixH1,            592
.equiv          nb133_fiyH1,            608
.equiv          nb133_fizH1,            624
.equiv          nb133_fixH2,            640
.equiv          nb133_fiyH2,            656
.equiv          nb133_fizH2,            672
.equiv          nb133_fixM,             688
.equiv          nb133_fiyM,             704
.equiv          nb133_fizM,             720
.equiv          nb133_fjx,              736
.equiv          nb133_fjy,              752
.equiv          nb133_fjz,              768
.equiv          nb133_half,             784
.equiv          nb133_three,            800
.equiv          nb133_two,              816
.equiv          nb133_rinvH1,           832
.equiv          nb133_rinvH2,           848
.equiv          nb133_rinvM,            864
.equiv          nb133_krsqH1,           880
.equiv          nb133_krsqH2,           896
.equiv          nb133_krsqM,            912
.equiv          nb133_rsqO,             960
.equiv          nb133_is3,              976
.equiv          nb133_ii3,              980
.equiv          nb133_ntia,             984
.equiv          nb133_innerjjnr,        988
.equiv          nb133_innerk,           992
.equiv          nb133_n,                996
.equiv          nb133_nn1,              1000
.equiv          nb133_nri,              1004
.equiv          nb133_nouter,           1008
.equiv          nb133_ninner,           1012
.equiv          nb133_salign,           1016
	push ebp
	mov ebp,esp	
    	push eax
    	push ebx
    	push ecx
    	push edx
	push esi
	push edi
	sub esp, 1020		;# local stack space 
	mov  eax, esp
	and  eax, 0xf
	sub esp, eax
	mov [esp + nb133_salign], eax
	emms

	;# Move args passed by reference to stack
	mov ecx, [ebp + nb133_p_nri]
	mov ecx, [ecx]
	mov [esp + nb133_nri], ecx

	;# zero iteration counters
	mov eax, 0
	mov [esp + nb133_nouter], eax
	mov [esp + nb133_ninner], eax

	mov eax, [ebp + nb133_p_tabscale]
	movsd xmm3, [eax]
	shufpd xmm3, xmm3, 0
	movapd [esp + nb133_tsc], xmm3

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double 0.5 IEEE (hex)
	mov ebx, 0x3fe00000
	mov [esp + nb133_half], eax
	mov [esp + nb133_half+4], ebx
	movsd xmm1, [esp + nb133_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# 1.0
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# 2.0
	addpd  xmm3, xmm2	;# 3.0
	movapd [esp + nb133_half], xmm1
	movapd [esp + nb133_two], xmm2
	movapd [esp + nb133_three], xmm3

	;# assume we have at least one i particle - start directly 
	mov   ecx, [ebp + nb133_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [ecx]	    ;# ebx =ii 

	mov   edx, [ebp + nb133_charge]
	movsd xmm3, [edx + ebx*8 + 8]	
	movsd xmm4, [edx + ebx*8 + 24]	
	mov esi, [ebp + nb133_p_facel]
	movsd xmm5, [esi]
	mulsd  xmm3, xmm5
	mulsd  xmm4, xmm5

	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	movapd [esp + nb133_iqH], xmm3
	movapd [esp + nb133_iqM], xmm4
	
	mov   edx, [ebp + nb133_type]
	mov   ecx, [edx + ebx*4]
	shl   ecx, 1
	mov edi, [ebp + nb133_p_ntype]
	imul  ecx, [edi]      ;# ecx = ntia = 2*ntype*type[ii0] 
	mov   [esp + nb133_ntia], ecx		
.nb133_threadloop:
        mov   esi, [ebp + nb133_count]          ;# pointer to sync counter
        mov   eax, [esi]
.nb133_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock
        cmpxchg [esi], ebx                      ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb133_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [esp + nb133_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [esp + nb133_n], eax
        mov [esp + nb133_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb133_outerstart
        jmp .nb133_end

.nb133_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [esp + nb133_nouter]
	mov [esp + nb133_nouter], ebx

.nb133_outer:
	mov   eax, [ebp + nb133_shift]      ;# eax = pointer into shift[] 
	mov   ebx, [eax+esi*4]		;# ebx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [esp + nb133_is3],ebx    	;# store is3 

	mov   eax, [ebp + nb133_shiftvec]   ;# eax = base of shiftvec[] 

	movsd xmm0, [eax + ebx*8]
	movsd xmm1, [eax + ebx*8 + 8]
	movsd xmm2, [eax + ebx*8 + 16] 

	mov   ecx, [ebp + nb133_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [ecx+esi*4]	    ;# ebx =ii 

	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	movapd xmm6, xmm0
	movapd xmm7, xmm1

	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   eax, [ebp + nb133_pos]    ;# eax = base of pos[]  
	mov   [esp + nb133_ii3], ebx

	addsd xmm3, [eax + ebx*8] 	;# ox
	addsd xmm4, [eax + ebx*8 + 8] 	;# oy
	addsd xmm5, [eax + ebx*8 + 16]	;# oz	
	addsd xmm6, [eax + ebx*8 + 24] 	;# h1x
	addsd xmm7, [eax + ebx*8 + 32] 	;# h1y
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	shufpd xmm6, xmm6, 0
	shufpd xmm7, xmm7, 0
	movapd [esp + nb133_ixO], xmm3
	movapd [esp + nb133_iyO], xmm4
	movapd [esp + nb133_izO], xmm5
	movapd [esp + nb133_ixH1], xmm6
	movapd [esp + nb133_iyH1], xmm7

	movsd xmm6, xmm2
	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm6, [eax + ebx*8 + 40] ;# h1z
	addsd xmm0, [eax + ebx*8 + 48] ;# h2x
	addsd xmm1, [eax + ebx*8 + 56] ;# h2y
	addsd xmm2, [eax + ebx*8 + 64] ;# h2z
	addsd xmm3, [eax + ebx*8 + 72] ;# mx
	addsd xmm4, [eax + ebx*8 + 80] ;# my
	addsd xmm5, [eax + ebx*8 + 88] ;# mz

	shufpd xmm6, xmm6, 0
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [esp + nb133_izH1], xmm6
	movapd [esp + nb133_ixH2], xmm0
	movapd [esp + nb133_iyH2], xmm1
	movapd [esp + nb133_izH2], xmm2
	movapd [esp + nb133_ixM], xmm3
	movapd [esp + nb133_iyM], xmm4
	movapd [esp + nb133_izM], xmm5

	;# clear vctot and i forces 
	xorpd xmm4, xmm4
	movapd [esp + nb133_vctot], xmm4
	movapd [esp + nb133_Vvdwtot], xmm4
	movapd [esp + nb133_fixO], xmm4
	movapd [esp + nb133_fiyO], xmm4
	movapd [esp + nb133_fizO], xmm4
	movapd [esp + nb133_fixH1], xmm4
	movapd [esp + nb133_fiyH1], xmm4
	movapd [esp + nb133_fizH1], xmm4
	movapd [esp + nb133_fixH2], xmm4
	movapd [esp + nb133_fiyH2], xmm4
	movapd [esp + nb133_fizH2], xmm4
	movapd [esp + nb133_fixM], xmm4
	movapd [esp + nb133_fiyM], xmm4
	movapd [esp + nb133_fizM], xmm4
	
	mov   eax, [ebp + nb133_jindex]
	mov   ecx, [eax + esi*4]	     ;# jindex[n] 
	mov   edx, [eax + esi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   esi, [ebp + nb133_pos]
	mov   edi, [ebp + nb133_faction]	
	mov   eax, [ebp + nb133_jjnr]
	shl   ecx, 2
	add   eax, ecx
	mov   [esp + nb133_innerjjnr], eax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [esp + nb133_ninner]
	mov   [esp + nb133_ninner], ecx
	add   edx, 0
	mov   [esp + nb133_innerk], edx    ;# number of innerloop atoms 
	jge   .nb133_unroll_loop
	jmp   .nb133_checksingle
.nb133_unroll_loop:
	;# twice unrolled innerloop here 
	mov   edx, [esp + nb133_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [edx]	
	mov   ebx, [edx + 4]

	add dword ptr [esp + nb133_innerjjnr],  8	;# advance pointer (unrolled 2) 

	mov esi, [ebp + nb133_charge]    ;# base of charge[] 
	
	movlpd xmm3, [esi + eax*8]
	movhpd xmm3, [esi + ebx*8]
	movapd xmm4, xmm3
	mulpd  xmm3, [esp + nb133_iqM]
	mulpd  xmm4, [esp + nb133_iqH]

	movd  mm0, eax		;# use mmx registers as temp storage 
	movd  mm1, ebx

	movapd  [esp + nb133_qqM], xmm3
	movapd  [esp + nb133_qqH], xmm4
	
	mov esi, [ebp + nb133_type]
	mov eax, [esi + eax*4]
	mov ebx, [esi + ebx*4]
	mov esi, [ebp + nb133_vdwparam]
	shl eax, 1	
	shl ebx, 1	
	mov edi, [esp + nb133_ntia]
	add eax, edi
	add ebx, edi

	movlpd xmm6, [esi + eax*8]	;# c6a
	movlpd xmm7, [esi + ebx*8]	;# c6b
	movhpd xmm6, [esi + eax*8 + 8]	;# c6a c12a 
	movhpd xmm7, [esi + ebx*8 + 8]	;# c6b c12b 
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [esp + nb133_c6], xmm4
	movapd [esp + nb133_c12], xmm6
	
	mov esi, [ebp + nb133_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	

	;# move two coordinates to xmm0-xmm2 
	movlpd xmm0, [esi + eax*8]
	movlpd xmm1, [esi + eax*8 + 8]
	movlpd xmm2, [esi + eax*8 + 16]
	movhpd xmm0, [esi + ebx*8]
	movhpd xmm1, [esi + ebx*8 + 8]
	movhpd xmm2, [esi + ebx*8 + 16]		

	;# move ixO-izO to xmm4-xmm6 
	movapd xmm4, [esp + nb133_ixO]
	movapd xmm5, [esp + nb133_iyO]
	movapd xmm6, [esp + nb133_izO]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# store dr 
	movapd [esp + nb133_dxO], xmm4
	movapd [esp + nb133_dyO], xmm5
	movapd [esp + nb133_dzO], xmm6
	;# square it 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm4, xmm5
	addpd xmm4, xmm6
	movapd xmm7, xmm4
	;# rsqO in xmm7 

	;# move ixH1-izH1 to xmm4-xmm6 
	movapd xmm4, [esp + nb133_ixH1]
	movapd xmm5, [esp + nb133_iyH1]
	movapd xmm6, [esp + nb133_izH1]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# store dr 
	movapd [esp + nb133_dxH1], xmm4
	movapd [esp + nb133_dyH1], xmm5
	movapd [esp + nb133_dzH1], xmm6
	;# square it 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm6, xmm5
	addpd xmm6, xmm4
	;# rsqH1 in xmm6 

	;# move ixH2-izH2 to xmm3-xmm5  
	movapd xmm3, [esp + nb133_ixH2]
	movapd xmm4, [esp + nb133_iyH2]
	movapd xmm5, [esp + nb133_izH2]

	;# calc dr 
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2

	;# store dr 
	movapd [esp + nb133_dxH2], xmm3
	movapd [esp + nb133_dyH2], xmm4
	movapd [esp + nb133_dzH2], xmm5
	;# square it 
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	addpd xmm5, xmm4
	addpd xmm5, xmm3

	;# move ixM-izM to xmm2-xmm4  
	movapd xmm3, [esp + nb133_iyM]
	movapd xmm4, [esp + nb133_izM]
	subpd  xmm3, xmm1
	subpd  xmm4, xmm2
	movapd xmm2, [esp + nb133_ixM]
	subpd  xmm2, xmm0	

	;# store dr 
	movapd [esp + nb133_dxM], xmm2
	movapd [esp + nb133_dyM], xmm3
	movapd [esp + nb133_dzM], xmm4
	;# square it 
	mulpd xmm2,xmm2
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	addpd xmm4, xmm3
	addpd xmm4, xmm2	
	;# rsqM in xmm4, rsqH2 in xmm5, rsqH1 in xmm6, rsqO in xmm7 
	movapd [esp + nb133_rsqO], xmm7
	
	;# start with rsqH1 - put seed in xmm2 
	cvtpd2ps xmm2, xmm6	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2
	
	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulpd   xmm2, xmm6	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm6, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subpd xmm1, xmm6	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133_half] ;# rinv 
	movapd  [esp + nb133_rinvH1], xmm1	

	;# rsqH2 - seed in xmm2 
	cvtpd2ps xmm2, xmm5	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulpd   xmm2, xmm5	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm5, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subpd xmm1, xmm5	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133_half] ;# rinv 
	movapd  [esp + nb133_rinvH2], xmm1	
	
	;# rsqM - seed in xmm2 
	cvtpd2ps xmm2, xmm4	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulpd   xmm2, xmm4	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm4, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subpd xmm1, xmm4	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133_half] ;# rinv 
	movapd  [esp + nb133_rinvM], xmm1	

		
	;# rsqO - put seed in xmm2 
	cvtpd2ps xmm2, xmm7	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm4, [esp + nb133_three]
	mulpd   xmm2, xmm7	;# rsq*lu*lu 
	subpd   xmm4, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm4, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm4, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm4
	mulpd xmm4, xmm4	;# lu*lu 
	mulpd xmm7, xmm4	;# rsq*lu*lu 
	movapd xmm4, [esp + nb133_three]
	subpd xmm4, xmm7	;# 3-rsq*lu*lu 
	mulpd xmm4, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm4, [esp + nb133_half] ;# rinv 
	movapd  xmm7, xmm4	;# rinvO in xmm7 
	
	movapd xmm4, [esp + nb133_rsqO]
	movapd xmm0, xmm7
	;# LJ table interaction.
	mulpd xmm4, xmm7	;# xmm4=r 
	mulpd xmm4, [esp + nb133_tsc]
	
	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	pslld mm6, 3		;# idx *= 8 
	
	movd mm0, eax	
	movd mm1, ebx

	mov  esi, [ebp + nb133_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6

	;# dispersion 
	movlpd xmm4, [esi + eax*8]	;# Y1 	
	movlpd xmm3, [esi + ebx*8]	;# Y2 
	movhpd xmm4, [esi + eax*8 + 8]	;# Y1 F1 	
	movhpd xmm3, [esi + ebx*8 + 8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + eax*8 + 16]	;# G1
	movlpd xmm3, [esi + ebx*8 + 16]	;# G2
	movhpd xmm6, [esi + eax*8 + 24]	;# G1 H1 	
	movhpd xmm3, [esi + ebx*8 + 24]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm7, [esp + nb133_two]	;# two*Heps2 
	addpd  xmm7, xmm6
	addpd  xmm7, xmm5 ;# xmm7=FF 
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 

	movapd xmm4, [esp + nb133_c6]
	mulpd  xmm7, xmm4	 ;# fijD 
	mulpd  xmm5, xmm4	 ;# Vvdw6 

	;# put scalar force on stack Update Vvdwtot directly 
	addpd  xmm5, [esp + nb133_Vvdwtot]
	xorpd  xmm3, xmm3
	mulpd  xmm7, [esp + nb133_tsc]
	subpd  xmm3, xmm7
	movapd [esp + nb133_fstmp], xmm3
	movapd [esp + nb133_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [esi + eax*8 + 32]	;# Y1 	
	movlpd xmm3, [esi + ebx*8 + 32]	;# Y2 
	movhpd xmm4, [esi + eax*8 + 40]	;# Y1 F1 	
	movhpd xmm3, [esi + ebx*8 + 40]	;# Y2 F2 

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + eax*8 + 48]	;# G1
	movlpd xmm3, [esi + ebx*8 + 48]	;# G2
	movhpd xmm6, [esi + eax*8 + 56]	;# G1 H1 	
	movhpd xmm3, [esi + ebx*8 + 56]	;# G2 H2 

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm7, [esp + nb133_two]	;# two*Heps2 
	addpd  xmm7, xmm6
	addpd  xmm7, xmm5 ;# xmm7=FF 
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	
	movapd xmm4, [esp + nb133_c12]
	mulpd  xmm7, xmm4 
	mulpd  xmm5, xmm4  
	
	addpd  xmm5, [esp + nb133_Vvdwtot]
	movapd xmm3, [esp + nb133_fstmp]
	mulpd  xmm7, [esp + nb133_tsc]
	subpd  xmm3, xmm7
	movapd [esp + nb133_Vvdwtot], xmm5

	mulpd  xmm3, xmm0
		
		
	movapd xmm0, [esp + nb133_dxO]
	movapd xmm1, [esp + nb133_dyO]
	movapd xmm2, [esp + nb133_dzO]

	movd eax, mm0	
	movd ebx, mm1

	mov    edi, [ebp + nb133_faction]
	mulpd  xmm0, xmm3
	mulpd  xmm1, xmm3
	mulpd  xmm2, xmm3
	
	;# update O forces 
	movapd xmm3, [esp + nb133_fixO]
	movapd xmm4, [esp + nb133_fiyO]
	movapd xmm7, [esp + nb133_fizO]
	addpd  xmm3, xmm0
	addpd  xmm4, xmm1
	addpd  xmm7, xmm2
	movapd [esp + nb133_fixO], xmm3
	movapd [esp + nb133_fiyO], xmm4
	movapd [esp + nb133_fizO], xmm7
	;# update j forces with water O 
	movapd [esp + nb133_fjx], xmm0
	movapd [esp + nb133_fjy], xmm1
	movapd [esp + nb133_fjz], xmm2

	;# H1 interactions 
	movapd  xmm6, [esp + nb133_rinvH1] 
	movapd  xmm4, xmm6
	mulpd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulpd   xmm6, [esp + nb133_qqH] ;# vcoul 
	mulpd   xmm4, xmm6    ;# fscal
	addpd   xmm6, [esp + nb133_vctot]
	movapd  [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxH1]
	movapd xmm1, [esp + nb133_dyH1]
	movapd xmm2, [esp + nb133_dzH1]
	mulpd  xmm0, xmm4
	mulpd  xmm1, xmm4
	mulpd  xmm2, xmm4

	;# update H1 forces 
	movapd xmm3, [esp + nb133_fixH1]
	movapd xmm4, [esp + nb133_fiyH1]
	movapd xmm7, [esp + nb133_fizH1]
	addpd  xmm3, xmm0
	addpd  xmm4, xmm1
	addpd  xmm7, xmm2
	movapd [esp + nb133_fixH1], xmm3
	movapd [esp + nb133_fiyH1], xmm4
	movapd [esp + nb133_fizH1], xmm7
	;# update j forces with water H1 
	addpd  xmm0, [esp + nb133_fjx]
	addpd  xmm1, [esp + nb133_fjy]
	addpd  xmm2, [esp + nb133_fjz]
	movapd [esp + nb133_fjx], xmm0
	movapd [esp + nb133_fjy], xmm1
	movapd [esp + nb133_fjz], xmm2

	;# H2 interactions 
	movapd  xmm6, [esp + nb133_rinvH2] 
	movapd  xmm4, xmm6
	mulpd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulpd   xmm6, [esp + nb133_qqH] ;# vcoul 
	mulpd   xmm4, xmm6    ;# fscal
	addpd  xmm6, [esp + nb133_vctot]
	movapd [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxH2]
	movapd xmm1, [esp + nb133_dyH2]
	movapd xmm2, [esp + nb133_dzH2]
	mulpd  xmm0, xmm4
	mulpd  xmm1, xmm4
	mulpd  xmm2, xmm4

	;# update H2 forces 
	movapd xmm3, [esp + nb133_fixH2]
	movapd xmm4, [esp + nb133_fiyH2]
	movapd xmm7, [esp + nb133_fizH2]
	addpd  xmm3, xmm0
	addpd  xmm4, xmm1
	addpd  xmm7, xmm2
	movapd [esp + nb133_fixH2], xmm3
	movapd [esp + nb133_fiyH2], xmm4
	movapd [esp + nb133_fizH2], xmm7
	;# update j forces with water H2
	addpd  xmm0, [esp + nb133_fjx]
	addpd  xmm1, [esp + nb133_fjy]
	addpd  xmm2, [esp + nb133_fjz]
	movapd [esp + nb133_fjx], xmm0
	movapd [esp + nb133_fjy], xmm1
	movapd [esp + nb133_fjz], xmm2

	;# M interactions 
	movapd  xmm6, [esp + nb133_rinvM] 
	movapd  xmm4, xmm6
	mulpd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulpd   xmm6, [esp + nb133_qqM] ;# vcoul 
	mulpd   xmm4, xmm6    ;# fscal
	addpd  xmm6, [esp + nb133_vctot]
	movapd [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxM]
	movapd xmm1, [esp + nb133_dyM]
	movapd xmm2, [esp + nb133_dzM]
	mulpd  xmm0, xmm4
	mulpd  xmm1, xmm4
	mulpd  xmm2, xmm4

	;# update H2 forces 
	movapd xmm3, [esp + nb133_fixM]
	movapd xmm4, [esp + nb133_fiyM]
	movapd xmm7, [esp + nb133_fizM]
	addpd  xmm3, xmm0
	addpd  xmm4, xmm1
	addpd  xmm7, xmm2
	movapd [esp + nb133_fixM], xmm3
	movapd [esp + nb133_fiyM], xmm4
	movapd [esp + nb133_fizM], xmm7

	mov edi, [ebp + nb133_faction]
	;# update j forces 
	addpd  xmm0, [esp + nb133_fjx]
	addpd  xmm1, [esp + nb133_fjy]
	addpd  xmm2, [esp + nb133_fjz]
	movlpd xmm3, [edi + eax*8]
	movlpd xmm4, [edi + eax*8 + 8]
	movlpd xmm5, [edi + eax*8 + 16]
	movhpd xmm3, [edi + ebx*8]
	movhpd xmm4, [edi + ebx*8 + 8]
	movhpd xmm5, [edi + ebx*8 + 16]
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2
	movlpd [edi + eax*8], xmm3
	movlpd [edi + eax*8 + 8], xmm4
	movlpd [edi + eax*8 + 16], xmm5
	movhpd [edi + ebx*8], xmm3
	movhpd [edi + ebx*8 + 8], xmm4
	movhpd [edi + ebx*8 + 16], xmm5
	
	;# should we do one more iteration? 
	sub dword ptr [esp + nb133_innerk],  2
	jl   .nb133_checksingle
	jmp  .nb133_unroll_loop
.nb133_checksingle:	
	mov   edx, [esp + nb133_innerk]
	and   edx, 1
	jnz  .nb133_dosingle
	jmp  .nb133_updateouterdata
.nb133_dosingle:
	mov   edx, [esp + nb133_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [edx]	
	add dword ptr [esp + nb133_innerjjnr],  4	

	mov esi, [ebp + nb133_charge]    ;# base of charge[] 

	xorpd xmm3, xmm3
	movlpd xmm3, [esi + eax*8]
	movapd xmm4, xmm3
	mulsd  xmm3, [esp + nb133_iqM]
	mulsd  xmm4, [esp + nb133_iqH]

	movd  mm0, eax		;# use mmx registers as temp storage 

	movapd  [esp + nb133_qqM], xmm3
	movapd  [esp + nb133_qqH], xmm4
	
	mov esi, [ebp + nb133_type]
	mov eax, [esi + eax*4]
	mov esi, [ebp + nb133_vdwparam]
	shl eax, 1	
	mov edi, [esp + nb133_ntia]
	add eax, edi

	movlpd xmm6, [esi + eax*8]	;# c6a
	movhpd xmm6, [esi + eax*8 + 8]	;# c6a c12a 

	xorpd xmm7, xmm7
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [esp + nb133_c6], xmm4
	movapd [esp + nb133_c12], xmm6
	
	mov esi, [ebp + nb133_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 

	;# move coordinates to xmm0-xmm2 
	movlpd xmm0, [esi + eax*8]
	movlpd xmm1, [esi + eax*8 + 8]
	movlpd xmm2, [esi + eax*8 + 16]

	;# move ixO-izO to xmm4-xmm6 
	movapd xmm4, [esp + nb133_ixO]
	movapd xmm5, [esp + nb133_iyO]
	movapd xmm6, [esp + nb133_izO]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# store dr 
	movapd [esp + nb133_dxO], xmm4
	movapd [esp + nb133_dyO], xmm5
	movapd [esp + nb133_dzO], xmm6
	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm4, xmm5
	addsd xmm4, xmm6
	movapd xmm7, xmm4
	;# rsqO in xmm7 
	movapd [esp + nb133_rsqO], xmm7
	
	;# move ixH1-izH1 to xmm4-xmm6 
	movapd xmm4, [esp + nb133_ixH1]
	movapd xmm5, [esp + nb133_iyH1]
	movapd xmm6, [esp + nb133_izH1]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# store dr 
	movapd [esp + nb133_dxH1], xmm4
	movapd [esp + nb133_dyH1], xmm5
	movapd [esp + nb133_dzH1], xmm6
	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm6, xmm5
	addsd xmm6, xmm4
	;# rsqH1 in xmm6 

	;# move ixH2-izH2 to xmm3-xmm5  
	movapd xmm3, [esp + nb133_ixH2]
	movapd xmm4, [esp + nb133_iyH2]
	movapd xmm5, [esp + nb133_izH2]

	;# calc dr 
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2

	;# store dr 
	movapd [esp + nb133_dxH2], xmm3
	movapd [esp + nb133_dyH2], xmm4
	movapd [esp + nb133_dzH2], xmm5
	;# square it 
	mulsd xmm3,xmm3
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	addsd xmm5, xmm4
	addsd xmm5, xmm3
	;# move ixM-izM to xmm2-xmm4  
	movapd xmm3, [esp + nb133_iyM]
	movapd xmm4, [esp + nb133_izM]
	subpd  xmm3, xmm1
	subpd  xmm4, xmm2
	movapd xmm2, [esp + nb133_ixM]
	subpd  xmm2, xmm0	

	;# store dr 
	movapd [esp + nb133_dxM], xmm2
	movapd [esp + nb133_dyM], xmm3
	movapd [esp + nb133_dzM], xmm4
	;# square it 
	mulpd xmm2,xmm2
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	addpd xmm4, xmm3
	addpd xmm4, xmm2	
	;# rsqM in xmm4, rsqH2 in xmm5, rsqH1 in xmm6, rsqO in xmm7 

	;# start with rsqH1 - put seed in xmm2 
	cvtsd2ss xmm2, xmm6	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulsd   xmm2, xmm6	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm6, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subsd xmm1, xmm6	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133_half] ;# rinv 
	movapd [esp + nb133_rinvH1], xmm1
	
	;# rsqH2 - seed in xmm2 
	cvtsd2ss xmm2, xmm5	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulsd   xmm2, xmm5	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm5, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subsd xmm1, xmm5	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133_half] ;# rinv 
	movapd [esp + nb133_rinvH2], xmm1
	
	;# rsqM - seed in xmm2 
	cvtsd2ss xmm2, xmm4
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133_three]
	mulsd   xmm2, xmm4	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm4, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133_three]
	subsd xmm1, xmm4	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133_half] ;# rinv 
	movapd [esp + nb133_rinvM], xmm1

	;# rsqO - put seed in xmm2 
	cvtsd2ss xmm2, xmm7	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movsd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movsd  xmm4, [esp + nb133_three]
	mulsd   xmm2, xmm7	;# rsq*lu*lu 
	subsd   xmm4, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm4, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm4, [esp + nb133_half] ;# iter1 ( new lu) 

	movsd xmm3, xmm4
	mulsd xmm4, xmm4	;# lu*lu 
	mulsd xmm7, xmm4	;# rsq*lu*lu 
	movsd xmm4, [esp + nb133_three]
	subsd xmm4, xmm7	;# 3-rsq*lu*lu 
	mulsd xmm4, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm4, [esp + nb133_half] ;# rinv 
	movsd  xmm7, xmm4	;# rinvO in xmm7 
	
	movsd xmm4, [esp + nb133_rsqO]
	movapd xmm0, xmm7
	;# LJ table interaction.
	mulsd xmm4, xmm7	;# xmm4=r 
	mulsd xmm4, [esp + nb133_tsc]
	
	cvttsd2si ebx, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, ebx
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	shl ebx, 3

	mov  esi, [ebp + nb133_VFtab]

	;# dispersion 
	movlpd xmm4, [esi + ebx*8]	;# Y1 	
	movhpd xmm4, [esi + ebx*8 + 8]	;# Y1 F1 	
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + ebx*8 + 16]	;# G1
	movhpd xmm6, [esi + ebx*8 + 24]	;# G1 H1 	
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm7, [esp + nb133_two]	;# two*Heps2 
	addsd  xmm7, xmm6
	addsd  xmm7, xmm5 ;# xmm7=FF 
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 

	movsd xmm4, [esp + nb133_c6]
	mulsd  xmm7, xmm4	 ;# fijD 
	mulsd  xmm5, xmm4	 ;# Vvdw6 

	;# put scalar force on stack Update Vvdwtot directly 
	addsd  xmm5, [esp + nb133_Vvdwtot]
	xorpd  xmm3, xmm3
	mulsd  xmm7, [esp + nb133_tsc]
	subsd  xmm3, xmm7
	movsd [esp + nb133_fstmp], xmm3
	movsd [esp + nb133_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [esi + ebx*8 + 32]	;# Y1 	
	movhpd xmm4, [esi + ebx*8 + 40]	;# Y1 F1 	

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + ebx*8 + 48]	;# G1
	movhpd xmm6, [esi + ebx*8 + 56]	;# G1 H1 	

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm7, [esp + nb133_two]	;# two*Heps2 
	addsd  xmm7, xmm6
	addsd  xmm7, xmm5 ;# xmm7=FF 
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	
	movsd xmm4, [esp + nb133_c12]
	mulsd  xmm7, xmm4 
	mulsd  xmm5, xmm4  
	
	addsd  xmm5, [esp + nb133_Vvdwtot]
	movsd xmm3, [esp + nb133_fstmp]
	mulsd  xmm7, [esp + nb133_tsc]
	subsd  xmm3, xmm7
	movsd [esp + nb133_Vvdwtot], xmm5

	mulsd  xmm3, xmm0
		
		
	movsd xmm0, [esp + nb133_dxO]
	movsd xmm1, [esp + nb133_dyO]
	movsd xmm2, [esp + nb133_dzO]

	mov    edi, [ebp + nb133_faction]
	mulsd  xmm0, xmm3
	mulsd  xmm1, xmm3
	mulsd  xmm2, xmm3

	;# update O forces 
	movapd xmm3, [esp + nb133_fixO]
	movapd xmm4, [esp + nb133_fiyO]
	movapd xmm7, [esp + nb133_fizO]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm7, xmm2
	movsd [esp + nb133_fixO], xmm3
	movsd [esp + nb133_fiyO], xmm4
	movsd [esp + nb133_fizO], xmm7
	;# update j forces with water O 
	movsd [esp + nb133_fjx], xmm0
	movsd [esp + nb133_fjy], xmm1
	movsd [esp + nb133_fjz], xmm2

	;# H1 interactions
	movsd  xmm6, [esp + nb133_rinvH1] 
	movsd  xmm4, xmm6
	mulsd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulsd   xmm6, [esp + nb133_qqH] ;# vcoul 
	mulsd   xmm4, xmm6    ;# fscal
	addsd  xmm6, [esp + nb133_vctot]
	movsd [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxH1]
	movapd xmm1, [esp + nb133_dyH1]
	movapd xmm2, [esp + nb133_dzH1]
	mulsd  xmm0, xmm4
	mulsd  xmm1, xmm4
	mulsd  xmm2, xmm4

	;# update H1 forces 
	movapd xmm3, [esp + nb133_fixH1]
	movapd xmm4, [esp + nb133_fiyH1]
	movapd xmm7, [esp + nb133_fizH1]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm7, xmm2
	movsd [esp + nb133_fixH1], xmm3
	movsd [esp + nb133_fiyH1], xmm4
	movsd [esp + nb133_fizH1], xmm7
	;# update j forces with water H1 
	addsd  xmm0, [esp + nb133_fjx]
	addsd  xmm1, [esp + nb133_fjy]
	addsd  xmm2, [esp + nb133_fjz]
	movsd [esp + nb133_fjx], xmm0
	movsd [esp + nb133_fjy], xmm1
	movsd [esp + nb133_fjz], xmm2

	;# H2 interactions 
	movsd  xmm6, [esp + nb133_rinvH2] 
	movsd  xmm4, xmm6
	mulsd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulsd   xmm6, [esp + nb133_qqH] ;# vcoul 
	mulsd   xmm4, xmm6    ;# fscal
	addsd  xmm6, [esp + nb133_vctot]
	movsd [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxH2]
	movapd xmm1, [esp + nb133_dyH2]
	movapd xmm2, [esp + nb133_dzH2]
	mulsd  xmm0, xmm4
	mulsd  xmm1, xmm4
	mulsd  xmm2, xmm4

	;# update H2 forces 
	movapd xmm3, [esp + nb133_fixH2]
	movapd xmm4, [esp + nb133_fiyH2]
	movapd xmm7, [esp + nb133_fizH2]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm7, xmm2
	movsd [esp + nb133_fixH2], xmm3
	movsd [esp + nb133_fiyH2], xmm4
	movsd [esp + nb133_fizH2], xmm7
	;# update j forces with water H2 
	addsd  xmm0, [esp + nb133_fjx]
	addsd  xmm1, [esp + nb133_fjy]
	addsd  xmm2, [esp + nb133_fjz]
	movsd [esp + nb133_fjx], xmm0
	movsd [esp + nb133_fjy], xmm1
	movsd [esp + nb133_fjz], xmm2

	;# M interactions 
	movsd  xmm6, [esp + nb133_rinvM] 
	movsd  xmm4, xmm6
	mulsd   xmm4, xmm4	;# xmm6=rinv, xmm4=rinvsq 
	mulsd   xmm6, [esp + nb133_qqM] ;# vcoul 
	mulsd   xmm4, xmm6    ;# fscal
	addsd  xmm6, [esp + nb133_vctot]
	movsd [esp + nb133_vctot], xmm6

	movapd xmm0, [esp + nb133_dxM]
	movapd xmm1, [esp + nb133_dyM]
	movapd xmm2, [esp + nb133_dzM]
	mulsd  xmm0, xmm4
	mulsd  xmm1, xmm4
	mulsd  xmm2, xmm4

	;# update M forces 
	movapd xmm3, [esp + nb133_fixM]
	movapd xmm4, [esp + nb133_fiyM]
	movapd xmm7, [esp + nb133_fizM]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm7, xmm2
	movsd [esp + nb133_fixM], xmm3
	movsd [esp + nb133_fiyM], xmm4
	movsd [esp + nb133_fizM], xmm7

	mov edi, [ebp + nb133_faction]
	;# update j forces 
	addsd  xmm0, [esp + nb133_fjx]
	addsd  xmm1, [esp + nb133_fjy]
	addsd  xmm2, [esp + nb133_fjz]
	movlpd xmm3, [edi + eax*8]
	movlpd xmm4, [edi + eax*8 + 8]
	movlpd xmm5, [edi + eax*8 + 16]
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2
	movlpd [edi + eax*8], xmm3
	movlpd [edi + eax*8 + 8], xmm4
	movlpd [edi + eax*8 + 16], xmm5

.nb133_updateouterdata:
	mov   ecx, [esp + nb133_ii3]
	mov   edi, [ebp + nb133_faction]
	mov   esi, [ebp + nb133_fshift]
	mov   edx, [esp + nb133_is3]

	;# accumulate  Oi forces in xmm0, xmm1, xmm2 
	movapd xmm0, [esp + nb133_fixO]
	movapd xmm1, [esp + nb133_fiyO]
	movapd xmm2, [esp + nb133_fizO]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [edi + ecx*8]
	movsd  xmm4, [edi + ecx*8 + 8]
	movsd  xmm5, [edi + ecx*8 + 16]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [edi + ecx*8],     xmm3
	movsd  [edi + ecx*8 + 8], xmm4
	movsd  [edi + ecx*8 + 16], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	movapd xmm6, xmm0
	movsd xmm7, xmm2
	unpcklpd xmm6,xmm1 

	;# accumulate H1i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [esp + nb133_fixH1]
	movapd xmm1, [esp + nb133_fiyH1]
	movapd xmm2, [esp + nb133_fizH1]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [edi + ecx*8 + 24]
	movsd  xmm4, [edi + ecx*8 + 32]
	movsd  xmm5, [edi + ecx*8 + 40]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [edi + ecx*8 + 24], xmm3
	movsd  [edi + ecx*8 + 32], xmm4
	movsd  [edi + ecx*8 + 40], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# accumulate H2i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [esp + nb133_fixH2]
	movapd xmm1, [esp + nb133_fiyH2]
	movapd xmm2, [esp + nb133_fizH2]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [edi + ecx*8 + 48]
	movsd  xmm4, [edi + ecx*8 + 56]
	movsd  xmm5, [edi + ecx*8 + 64]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [edi + ecx*8 + 48], xmm3
	movsd  [edi + ecx*8 + 56], xmm4
	movsd  [edi + ecx*8 + 64], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# accumulate Mi forces in xmm0, xmm1, xmm2 
	movapd xmm0, [esp + nb133_fixM]
	movapd xmm1, [esp + nb133_fiyM]
	movapd xmm2, [esp + nb133_fizM]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [edi + ecx*8 + 72]
	movsd  xmm4, [edi + ecx*8 + 80]
	movsd  xmm5, [edi + ecx*8 + 88]
	addsd  xmm3, xmm0
	addsd  xmm4, xmm1
	addsd  xmm5, xmm2
	movsd  [edi + ecx*8 + 72], xmm3
	movsd  [edi + ecx*8 + 80], xmm4
	movsd  [edi + ecx*8 + 88], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# increment fshift force 
	movlpd xmm3, [esi + edx*8]
	movhpd xmm3, [esi + edx*8 + 8]
	movsd  xmm4, [esi + edx*8 + 16]
	addpd  xmm3, xmm6
	addsd  xmm4, xmm7
	movlpd [esi + edx*8],      xmm3
	movhpd [esi + edx*8 + 8],  xmm3
	movsd  [esi + edx*8 + 16], xmm4

	;# get n from stack
	mov esi, [esp + nb133_n]
        ;# get group index for i particle 
        mov   edx, [ebp + nb133_gid]      	;# base of gid[]
        mov   edx, [edx + esi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [esp + nb133_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   eax, [ebp + nb133_Vc]
	addsd xmm7, [eax + edx*8] 
	;# move back to mem 
	movsd [eax + edx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [esp + nb133_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   eax, [ebp + nb133_Vvdw]
	addsd xmm7, [eax + edx*8] 
	;# move back to mem 
	movsd [eax + edx*8], xmm7 
	
       ;# finish if last 
        mov ecx, [esp + nb133_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb133_outerend

        ;# not last, iterate outer loop once more!  
        mov [esp + nb133_n], esi
        jmp .nb133_outer
.nb133_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [esp + nb133_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb133_end
        ;# non-zero, do one more workunit
        jmp   .nb133_threadloop
.nb133_end:
	emms

	mov eax, [esp + nb133_nouter]
	mov ebx, [esp + nb133_ninner]
	mov ecx, [ebp + nb133_outeriter]
	mov edx, [ebp + nb133_inneriter]
	mov [ecx], eax
	mov [edx], ebx

	mov eax, [esp + nb133_salign]
	add esp, eax
	add esp, 1020
	pop edi
	pop esi
    	pop edx
    	pop ecx
    	pop ebx
    	pop eax
	leave
	ret




.globl nb_kernel133nf_ia32_sse2
.globl _nb_kernel133nf_ia32_sse2
nb_kernel133nf_ia32_sse2:	
_nb_kernel133nf_ia32_sse2:	
.equiv          nb133nf_p_nri,            8
.equiv          nb133nf_iinr,             12
.equiv          nb133nf_jindex,           16
.equiv          nb133nf_jjnr,             20
.equiv          nb133nf_shift,            24
.equiv          nb133nf_shiftvec,         28
.equiv          nb133nf_fshift,           32
.equiv          nb133nf_gid,              36
.equiv          nb133nf_pos,              40
.equiv          nb133nf_faction,          44
.equiv          nb133nf_charge,           48
.equiv          nb133nf_p_facel,          52
.equiv          nb133nf_argkrf,           56
.equiv          nb133nf_argcrf,           60
.equiv          nb133nf_Vc,               64
.equiv          nb133nf_type,             68
.equiv          nb133nf_p_ntype,          72
.equiv          nb133nf_vdwparam,         76
.equiv          nb133nf_Vvdw,             80
.equiv          nb133nf_p_tabscale,       84
.equiv          nb133nf_VFtab,            88
.equiv          nb133nf_invsqrta,         92
.equiv          nb133nf_dvda,             96
.equiv          nb133nf_p_gbtabscale,     100
.equiv          nb133nf_GBtab,            104
.equiv          nb133nf_p_nthreads,       108
.equiv          nb133nf_count,            112
.equiv          nb133nf_mtx,              116
.equiv          nb133nf_outeriter,        120
.equiv          nb133nf_inneriter,        124
.equiv          nb133nf_work,             128
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb133nf_ixO,              0
.equiv          nb133nf_iyO,              16
.equiv          nb133nf_izO,              32
.equiv          nb133nf_ixH1,             48
.equiv          nb133nf_iyH1,             64
.equiv          nb133nf_izH1,             80
.equiv          nb133nf_ixH2,             96
.equiv          nb133nf_iyH2,             112
.equiv          nb133nf_izH2,             128
.equiv          nb133nf_ixM,              144
.equiv          nb133nf_iyM,              160
.equiv          nb133nf_izM,              176
.equiv          nb133nf_iqH,              192
.equiv          nb133nf_iqM,              208
.equiv          nb133nf_qqH,              224
.equiv          nb133nf_qqM,              240
.equiv          nb133nf_c6,               256
.equiv          nb133nf_c12,              272
.equiv          nb133nf_tsc,              288
.equiv          nb133nf_vctot,            304
.equiv          nb133nf_Vvdwtot,          320
.equiv          nb133nf_half,             336
.equiv          nb133nf_three,            352
.equiv          nb133nf_two,              368
.equiv          nb133nf_rinvH1,           384
.equiv          nb133nf_rinvH2,           400
.equiv          nb133nf_rinvM,            416
.equiv          nb133nf_krsqH1,           432
.equiv          nb133nf_krsqH2,           448
.equiv          nb133nf_krsqM,            464
.equiv          nb133nf_rsqO,             512
.equiv          nb133nf_is3,              528
.equiv          nb133nf_ii3,              532
.equiv          nb133nf_ntia,             536
.equiv          nb133nf_innerjjnr,        540
.equiv          nb133nf_innerk,           544
.equiv          nb133nf_n,                548
.equiv          nb133nf_nn1,              552
.equiv          nb133nf_nri,              556
.equiv          nb133nf_nouter,           560
.equiv          nb133nf_ninner,           564
.equiv          nb133nf_salign,           568
	push ebp
	mov ebp,esp	
    	push eax
    	push ebx
    	push ecx
    	push edx
	push esi
	push edi
	sub esp, 572		;# local stack space 
	mov  eax, esp
	and  eax, 0xf
	sub esp, eax
	mov [esp + nb133nf_salign], eax
	emms

	;# Move args passed by reference to stack
	mov ecx, [ebp + nb133nf_p_nri]
	mov ecx, [ecx]
	mov [esp + nb133nf_nri], ecx

	;# zero iteration counters
	mov eax, 0
	mov [esp + nb133nf_nouter], eax
	mov [esp + nb133nf_ninner], eax

	mov eax, [ebp + nb133nf_p_tabscale]
	movsd xmm3, [eax]
	shufpd xmm3, xmm3, 0
	movapd [esp + nb133nf_tsc], xmm3

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double 0.5 IEEE (hex)
	mov ebx, 0x3fe00000
	mov [esp + nb133nf_half], eax
	mov [esp + nb133nf_half+4], ebx
	movsd xmm1, [esp + nb133nf_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# 1.0
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# 2.0
	addpd  xmm3, xmm2	;# 3.0
	movapd [esp + nb133nf_half], xmm1
	movapd [esp + nb133nf_two], xmm2
	movapd [esp + nb133nf_three], xmm3

	;# assume we have at least one i particle - start directly 
	mov   ecx, [ebp + nb133nf_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [ecx]	    ;# ebx =ii 

	mov   edx, [ebp + nb133nf_charge]
	movsd xmm3, [edx + ebx*8 + 8]	
	movsd xmm4, [edx + ebx*8 + 24]	
	mov esi, [ebp + nb133nf_p_facel]
	movsd xmm5, [esi]
	mulsd  xmm3, xmm5
	mulsd  xmm4, xmm5

	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	movapd [esp + nb133nf_iqH], xmm3
	movapd [esp + nb133nf_iqM], xmm4
	
	mov   edx, [ebp + nb133nf_type]
	mov   ecx, [edx + ebx*4]
	shl   ecx, 1
	mov edi, [ebp + nb133nf_p_ntype]
	imul  ecx, [edi]      ;# ecx = ntia = 2*ntype*type[ii0] 
	mov   [esp + nb133nf_ntia], ecx		
.nb133nf_threadloop:
        mov   esi, [ebp + nb133nf_count]          ;# pointer to sync counter
        mov   eax, [esi]
.nb133nf_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock
        cmpxchg [esi], ebx                      ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb133nf_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [esp + nb133nf_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [esp + nb133nf_n], eax
        mov [esp + nb133nf_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb133nf_outerstart
        jmp .nb133nf_end

.nb133nf_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [esp + nb133nf_nouter]
	mov [esp + nb133nf_nouter], ebx

.nb133nf_outer:
	mov   eax, [ebp + nb133nf_shift]      ;# eax = pointer into shift[] 
	mov   ebx, [eax+esi*4]		;# ebx=shift[n] 
	
	lea   ebx, [ebx + ebx*2]    ;# ebx=3*is 
	mov   [esp + nb133nf_is3],ebx    	;# store is3 

	mov   eax, [ebp + nb133nf_shiftvec]   ;# eax = base of shiftvec[] 

	movsd xmm0, [eax + ebx*8]
	movsd xmm1, [eax + ebx*8 + 8]
	movsd xmm2, [eax + ebx*8 + 16] 

	mov   ecx, [ebp + nb133nf_iinr]       ;# ecx = pointer into iinr[] 	
	mov   ebx, [ecx+esi*4]	    ;# ebx =ii 

	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	movapd xmm6, xmm0
	movapd xmm7, xmm1

	lea   ebx, [ebx + ebx*2]	;# ebx = 3*ii=ii3 
	mov   eax, [ebp + nb133nf_pos]    ;# eax = base of pos[]  
	mov   [esp + nb133nf_ii3], ebx

	addsd xmm3, [eax + ebx*8] 	;# ox
	addsd xmm4, [eax + ebx*8 + 8] 	;# oy
	addsd xmm5, [eax + ebx*8 + 16]	;# oz	
	addsd xmm6, [eax + ebx*8 + 24] 	;# h1x
	addsd xmm7, [eax + ebx*8 + 32] 	;# h1y
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	shufpd xmm6, xmm6, 0
	shufpd xmm7, xmm7, 0
	movapd [esp + nb133nf_ixO], xmm3
	movapd [esp + nb133nf_iyO], xmm4
	movapd [esp + nb133nf_izO], xmm5
	movapd [esp + nb133nf_ixH1], xmm6
	movapd [esp + nb133nf_iyH1], xmm7

	movsd xmm6, xmm2
	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm6, [eax + ebx*8 + 40] ;# h1z
	addsd xmm0, [eax + ebx*8 + 48] ;# h2x
	addsd xmm1, [eax + ebx*8 + 56] ;# h2y
	addsd xmm2, [eax + ebx*8 + 64] ;# h2z
	addsd xmm3, [eax + ebx*8 + 72] ;# mx
	addsd xmm4, [eax + ebx*8 + 80] ;# my
	addsd xmm5, [eax + ebx*8 + 88] ;# mz

	shufpd xmm6, xmm6, 0
	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [esp + nb133nf_izH1], xmm6
	movapd [esp + nb133nf_ixH2], xmm0
	movapd [esp + nb133nf_iyH2], xmm1
	movapd [esp + nb133nf_izH2], xmm2
	movapd [esp + nb133nf_ixM], xmm3
	movapd [esp + nb133nf_iyM], xmm4
	movapd [esp + nb133nf_izM], xmm5

	;# clear vctot
	xorpd xmm4, xmm4
	movapd [esp + nb133nf_vctot], xmm4
	movapd [esp + nb133nf_Vvdwtot], xmm4
	
	mov   eax, [ebp + nb133nf_jindex]
	mov   ecx, [eax + esi*4]	     ;# jindex[n] 
	mov   edx, [eax + esi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   esi, [ebp + nb133nf_pos]
	mov   edi, [ebp + nb133nf_faction]	
	mov   eax, [ebp + nb133nf_jjnr]
	shl   ecx, 2
	add   eax, ecx
	mov   [esp + nb133nf_innerjjnr], eax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [esp + nb133nf_ninner]
	mov   [esp + nb133nf_ninner], ecx
	add   edx, 0
	mov   [esp + nb133nf_innerk], edx    ;# number of innerloop atoms 
	jge   .nb133nf_unroll_loop
	jmp   .nb133nf_checksingle
.nb133nf_unroll_loop:
	;# twice unrolled innerloop here 
	mov   edx, [esp + nb133nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [edx]	
	mov   ebx, [edx + 4]

	add dword ptr [esp + nb133nf_innerjjnr],  8	;# advance pointer (unrolled 2) 

	mov esi, [ebp + nb133nf_charge]    ;# base of charge[] 
	
	movlpd xmm3, [esi + eax*8]
	movhpd xmm3, [esi + ebx*8]
	movapd xmm4, xmm3
	mulpd  xmm3, [esp + nb133nf_iqM]
	mulpd  xmm4, [esp + nb133nf_iqH]

	movd  mm0, eax		;# use mmx registers as temp storage 
	movd  mm1, ebx

	movapd  [esp + nb133nf_qqM], xmm3
	movapd  [esp + nb133nf_qqH], xmm4
	
	mov esi, [ebp + nb133nf_type]
	mov eax, [esi + eax*4]
	mov ebx, [esi + ebx*4]
	mov esi, [ebp + nb133nf_vdwparam]
	shl eax, 1	
	shl ebx, 1	
	mov edi, [esp + nb133nf_ntia]
	add eax, edi
	add ebx, edi

	movlpd xmm6, [esi + eax*8]	;# c6a
	movlpd xmm7, [esi + ebx*8]	;# c6b
	movhpd xmm6, [esi + eax*8 + 8]	;# c6a c12a 
	movhpd xmm7, [esi + ebx*8 + 8]	;# c6b c12b 
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [esp + nb133nf_c6], xmm4
	movapd [esp + nb133nf_c12], xmm6
	
	mov esi, [ebp + nb133nf_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 
	lea   ebx, [ebx + ebx*2]	

	;# move two coordinates to xmm0-xmm2 
	movlpd xmm0, [esi + eax*8]
	movlpd xmm1, [esi + eax*8 + 8]
	movlpd xmm2, [esi + eax*8 + 16]
	movhpd xmm0, [esi + ebx*8]
	movhpd xmm1, [esi + ebx*8 + 8]
	movhpd xmm2, [esi + ebx*8 + 16]		

	;# move ixO-izO to xmm4-xmm6 
	movapd xmm4, [esp + nb133nf_ixO]
	movapd xmm5, [esp + nb133nf_iyO]
	movapd xmm6, [esp + nb133nf_izO]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# square it 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm4, xmm5
	addpd xmm4, xmm6
	movapd xmm7, xmm4
	;# rsqO in xmm7 

	;# move ixH1-izH1 to xmm4-xmm6 
	movapd xmm4, [esp + nb133nf_ixH1]
	movapd xmm5, [esp + nb133nf_iyH1]
	movapd xmm6, [esp + nb133nf_izH1]

	;# calc dr 
	subpd xmm4, xmm0
	subpd xmm5, xmm1
	subpd xmm6, xmm2

	;# square it 
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	mulpd xmm6,xmm6
	addpd xmm6, xmm5
	addpd xmm6, xmm4
	;# rsqH1 in xmm6 

	;# move ixH2-izH2 to xmm3-xmm5  
	movapd xmm3, [esp + nb133nf_ixH2]
	movapd xmm4, [esp + nb133nf_iyH2]
	movapd xmm5, [esp + nb133nf_izH2]

	;# calc dr 
	subpd xmm3, xmm0
	subpd xmm4, xmm1
	subpd xmm5, xmm2

	;# square it 
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	mulpd xmm5,xmm5
	addpd xmm5, xmm4
	addpd xmm5, xmm3

	;# move ixM-izM to xmm2-xmm4  
	movapd xmm3, [esp + nb133nf_iyM]
	movapd xmm4, [esp + nb133nf_izM]
	subpd  xmm3, xmm1
	subpd  xmm4, xmm2
	movapd xmm2, [esp + nb133nf_ixM]
	subpd  xmm2, xmm0	

	;# square it 
	mulpd xmm2,xmm2
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	addpd xmm4, xmm3
	addpd xmm4, xmm2	
	;# rsqM in xmm4, rsqH2 in xmm5, rsqH1 in xmm6, rsqO in xmm7 
	movapd [esp + nb133nf_rsqO], xmm7
	
	;# start with rsqH1 - put seed in xmm2 
	cvtpd2ps xmm2, xmm6	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2
	
	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulpd   xmm2, xmm6	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm6, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subpd xmm1, xmm6	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd  [esp + nb133nf_rinvH1], xmm1	

	;# rsqH2 - seed in xmm2 
	cvtpd2ps xmm2, xmm5	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulpd   xmm2, xmm5	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm5, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subpd xmm1, xmm5	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd  [esp + nb133nf_rinvH2], xmm1	
	
	;# rsqM - seed in xmm2 
	cvtpd2ps xmm2, xmm4	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulpd   xmm2, xmm4	;# rsq*lu*lu 
	subpd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulpd xmm1, xmm1	;# lu*lu 
	mulpd xmm4, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subpd xmm1, xmm4	;# 3-rsq*lu*lu 
	mulpd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd  [esp + nb133nf_rinvM], xmm1	

		
	;# rsqO - put seed in xmm2 
	cvtpd2ps xmm2, xmm7	
	rsqrtps xmm2, xmm2
	cvtps2pd xmm2, xmm2

	movapd  xmm3, xmm2
	mulpd   xmm2, xmm2
	movapd  xmm4, [esp + nb133nf_three]
	mulpd   xmm2, xmm7	;# rsq*lu*lu 
	subpd   xmm4, xmm2	;# 30-rsq*lu*lu 
	mulpd   xmm4, xmm3	;# lu*(3-rsq*lu*lu) 
	mulpd   xmm4, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm4
	mulpd xmm4, xmm4	;# lu*lu 
	mulpd xmm7, xmm4	;# rsq*lu*lu 
	movapd xmm4, [esp + nb133nf_three]
	subpd xmm4, xmm7	;# 3-rsq*lu*lu 
	mulpd xmm4, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulpd xmm4, [esp + nb133nf_half] ;# rinv 
	movapd  xmm7, xmm4	;# rinvO in xmm7 
	
	
	
	movapd xmm4, [esp + nb133nf_rsqO]
	movapd xmm0, xmm7
	;# LJ table interaction.
	mulpd xmm4, xmm7	;# xmm4=r 
	mulpd xmm4, [esp + nb133nf_tsc]
	
	cvttpd2pi mm6, xmm4	;# mm6 = lu idx 
	cvtpi2pd xmm5, mm6
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	pslld mm6, 3		;# idx *= 8 
	
	mov  esi, [ebp + nb133nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6

	;# dispersion 
	movlpd xmm4, [esi + eax*8]	;# Y1 	
	movlpd xmm3, [esi + ebx*8]	;# Y2 
	movhpd xmm4, [esi + eax*8 + 8]	;# Y1 F1 	
	movhpd xmm3, [esi + ebx*8 + 8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + eax*8 + 16]	;# G1
	movlpd xmm3, [esi + ebx*8 + 16]	;# G2
	movhpd xmm6, [esi + eax*8 + 24]	;# G1 H1 	
	movhpd xmm3, [esi + ebx*8 + 24]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 

	movapd xmm4, [esp + nb133nf_c6]
	mulpd  xmm5, xmm4	 ;# Vvdw6 

	;# Update Vvdwtot directly 
	addpd  xmm5, [esp + nb133nf_Vvdwtot]
	movapd [esp + nb133nf_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [esi + eax*8 + 32]	;# Y1 	
	movlpd xmm3, [esi + ebx*8 + 32]	;# Y2 
	movhpd xmm4, [esi + eax*8 + 40]	;# Y1 F1 	
	movhpd xmm3, [esi + ebx*8 + 40]	;# Y2 F2 

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + eax*8 + 48]	;# G1
	movlpd xmm3, [esi + ebx*8 + 48]	;# G2
	movhpd xmm6, [esi + eax*8 + 56]	;# G1 H1 	
	movhpd xmm3, [esi + ebx*8 + 56]	;# G2 H2 

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	
	movapd xmm4, [esp + nb133nf_c12]
	mulpd  xmm5, xmm4  
	
	addpd  xmm5, [esp + nb133nf_Vvdwtot]
	movapd [esp + nb133nf_Vvdwtot], xmm5

	;# H1/H2/M interactions 
	movapd  xmm6, [esp + nb133nf_rinvH1] 
	addpd   xmm6, [esp + nb133nf_rinvH2] 
	movapd  xmm7, [esp + nb133nf_rinvM] 
	mulpd   xmm6, [esp + nb133nf_qqH]
	mulpd   xmm7, [esp + nb133nf_qqM]
	addpd   xmm6, xmm7
	addpd   xmm6, [esp + nb133nf_vctot]
	movapd  [esp + nb133nf_vctot], xmm6
	
	;# should we do one more iteration? 
	sub dword ptr [esp + nb133nf_innerk],  2
	jl   .nb133nf_checksingle
	jmp  .nb133nf_unroll_loop
.nb133nf_checksingle:	
	mov   edx, [esp + nb133nf_innerk]
	and   edx, 1
	jnz  .nb133nf_dosingle
	jmp  .nb133nf_updateouterdata
.nb133nf_dosingle:
	mov   edx, [esp + nb133nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [edx]	
	add dword ptr [esp + nb133nf_innerjjnr],  4	

	mov esi, [ebp + nb133nf_charge]    ;# base of charge[] 

	xorpd xmm3, xmm3
	movlpd xmm3, [esi + eax*8]
	movapd xmm4, xmm3
	mulsd  xmm3, [esp + nb133nf_iqM]
	mulsd  xmm4, [esp + nb133nf_iqH]

	movd  mm0, eax		;# use mmx registers as temp storage 

	movapd  [esp + nb133nf_qqM], xmm3
	movapd  [esp + nb133nf_qqH], xmm4
	
	mov esi, [ebp + nb133nf_type]
	mov eax, [esi + eax*4]
	mov esi, [ebp + nb133nf_vdwparam]
	shl eax, 1	
	mov edi, [esp + nb133nf_ntia]
	add eax, edi

	movlpd xmm6, [esi + eax*8]	;# c6a
	movhpd xmm6, [esi + eax*8 + 8]	;# c6a c12a 

	xorpd xmm7, xmm7
	movapd xmm4, xmm6
	unpcklpd xmm4, xmm7
	unpckhpd xmm6, xmm7
	
	movd  eax, mm0
	movd  ebx, mm1
	movapd [esp + nb133nf_c6], xmm4
	movapd [esp + nb133nf_c12], xmm6
	
	mov esi, [ebp + nb133nf_pos]       ;# base of pos[] 

	lea   eax, [eax + eax*2]     ;# replace jnr with j3 

	;# move coordinates to xmm0-xmm2 
	movlpd xmm0, [esi + eax*8]
	movlpd xmm1, [esi + eax*8 + 8]
	movlpd xmm2, [esi + eax*8 + 16]

	;# move ixO-izO to xmm4-xmm6 
	movapd xmm4, [esp + nb133nf_ixO]
	movapd xmm5, [esp + nb133nf_iyO]
	movapd xmm6, [esp + nb133nf_izO]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm4, xmm5
	addsd xmm4, xmm6
	movapd xmm7, xmm4
	;# rsqO in xmm7 
	movapd [esp + nb133nf_rsqO], xmm7
	
	;# move ixH1-izH1 to xmm4-xmm6 
	movapd xmm4, [esp + nb133nf_ixH1]
	movapd xmm5, [esp + nb133nf_iyH1]
	movapd xmm6, [esp + nb133nf_izH1]

	;# calc dr 
	subsd xmm4, xmm0
	subsd xmm5, xmm1
	subsd xmm6, xmm2

	;# square it 
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	mulsd xmm6,xmm6
	addsd xmm6, xmm5
	addsd xmm6, xmm4
	;# rsqH1 in xmm6 

	;# move ixH2-izH2 to xmm3-xmm5  
	movapd xmm3, [esp + nb133nf_ixH2]
	movapd xmm4, [esp + nb133nf_iyH2]
	movapd xmm5, [esp + nb133nf_izH2]

	;# calc dr 
	subsd xmm3, xmm0
	subsd xmm4, xmm1
	subsd xmm5, xmm2

	;# square it 
	mulsd xmm3,xmm3
	mulsd xmm4,xmm4
	mulsd xmm5,xmm5
	addsd xmm5, xmm4
	addsd xmm5, xmm3
	;# move ixM-izM to xmm2-xmm4  
	movapd xmm3, [esp + nb133nf_iyM]
	movapd xmm4, [esp + nb133nf_izM]
	subpd  xmm3, xmm1
	subpd  xmm4, xmm2
	movapd xmm2, [esp + nb133nf_ixM]
	subpd  xmm2, xmm0	

	;# square it 
	mulpd xmm2,xmm2
	mulpd xmm3,xmm3
	mulpd xmm4,xmm4
	addpd xmm4, xmm3
	addpd xmm4, xmm2	
	;# rsqM in xmm4, rsqH2 in xmm5, rsqH1 in xmm6, rsqO in xmm7 

	;# start with rsqH1 - put seed in xmm2 
	cvtsd2ss xmm2, xmm6	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulsd   xmm2, xmm6	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm6, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subsd xmm1, xmm6	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd [esp + nb133nf_rinvH1], xmm1
	
	;# rsqH2 - seed in xmm2 
	cvtsd2ss xmm2, xmm5	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulsd   xmm2, xmm5	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm5, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subsd xmm1, xmm5	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd [esp + nb133nf_rinvH2], xmm1
	
	;# rsqM - seed in xmm2 
	cvtsd2ss xmm2, xmm4
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movapd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movapd  xmm1, [esp + nb133nf_three]
	mulsd   xmm2, xmm4	;# rsq*lu*lu 
	subsd   xmm1, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm1, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm1, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movapd xmm3, xmm1
	mulsd xmm1, xmm1	;# lu*lu 
	mulsd xmm4, xmm1	;# rsq*lu*lu 
	movapd xmm1, [esp + nb133nf_three]
	subsd xmm1, xmm4	;# 3-rsq*lu*lu 
	mulsd xmm1, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm1, [esp + nb133nf_half] ;# rinv 
	movapd [esp + nb133nf_rinvM], xmm1

	;# rsqO - put seed in xmm2 
	cvtsd2ss xmm2, xmm7	
	rsqrtss xmm2, xmm2
	cvtss2sd xmm2, xmm2

	movsd  xmm3, xmm2
	mulsd   xmm2, xmm2
	movsd  xmm4, [esp + nb133nf_three]
	mulsd   xmm2, xmm7	;# rsq*lu*lu 
	subsd   xmm4, xmm2	;# 30-rsq*lu*lu 
	mulsd   xmm4, xmm3	;# lu*(3-rsq*lu*lu) 
	mulsd   xmm4, [esp + nb133nf_half] ;# iter1 ( new lu) 

	movsd xmm3, xmm4
	mulsd xmm4, xmm4	;# lu*lu 
	mulsd xmm7, xmm4	;# rsq*lu*lu 
	movsd xmm4, [esp + nb133nf_three]
	subsd xmm4, xmm7	;# 3-rsq*lu*lu 
	mulsd xmm4, xmm3	;# lu*(	3-rsq*lu*lu) 
	mulsd xmm4, [esp + nb133nf_half] ;# rinv 
	movsd  xmm7, xmm4	;# rinvO in xmm7 
	
	movsd xmm4, [esp + nb133nf_rsqO]
	movapd xmm0, xmm7
	;# LJ table interaction.
	mulsd xmm4, xmm7	;# xmm4=r 
	mulsd xmm4, [esp + nb133nf_tsc]
	
	cvttsd2si ebx, xmm4	;# mm6 = lu idx 
	cvtsi2sd xmm5, ebx
	subpd xmm4, xmm5
	movapd xmm1, xmm4	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 

	shl ebx, 3

	mov  esi, [ebp + nb133nf_VFtab]

	;# dispersion 
	movlpd xmm4, [esi + ebx*8]	;# Y1 	
	movhpd xmm4, [esi + ebx*8 + 8]	;# Y1 F1 	
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + ebx*8 + 16]	;# G1
	movhpd xmm6, [esi + ebx*8 + 24]	;# G1 H1 	
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# dispersion table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 

	movsd xmm4, [esp + nb133nf_c6]
	mulsd  xmm5, xmm4	 ;# Vvdw6 

	;# put scalar force on stack Update Vvdwtot directly 
	addsd  xmm5, [esp + nb133nf_Vvdwtot]
	movsd [esp + nb133nf_Vvdwtot], xmm5

	;# repulsion 
	movlpd xmm4, [esi + ebx*8 + 32]	;# Y1 	
	movhpd xmm4, [esi + ebx*8 + 40]	;# Y1 F1 	

	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movlpd xmm6, [esi + ebx*8 + 48]	;# G1
	movhpd xmm6, [esi + ebx*8 + 56]	;# G1 H1 	

	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	
	;# table ready, in xmm4-xmm7 	
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	
	movsd xmm4, [esp + nb133nf_c12]
	mulsd  xmm5, xmm4  
	
	addsd  xmm5, [esp + nb133nf_Vvdwtot]
	movsd [esp + nb133nf_Vvdwtot], xmm5

	;# H1/H2/M interactions 
	movsd  xmm6, [esp + nb133nf_rinvH1] 
	addsd  xmm6, [esp + nb133nf_rinvH2] 
	movsd  xmm7, [esp + nb133nf_rinvM] 
	mulsd  xmm6, [esp + nb133nf_qqH]
	mulsd  xmm7, [esp + nb133nf_qqM]
	addsd  xmm6, xmm7
	addsd  xmm6, [esp + nb133nf_vctot]
	movsd  [esp + nb133nf_vctot], xmm6
	
.nb133nf_updateouterdata:
	;# get n from stack
	mov esi, [esp + nb133nf_n]
        ;# get group index for i particle 
        mov   edx, [ebp + nb133nf_gid]      	;# base of gid[]
        mov   edx, [edx + esi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [esp + nb133nf_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   eax, [ebp + nb133nf_Vc]
	addsd xmm7, [eax + edx*8] 
	;# move back to mem 
	movsd [eax + edx*8], xmm7 
	
	;# accumulate total lj energy and update it 
	movapd xmm7, [esp + nb133nf_Vvdwtot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 

	;# add earlier value from mem 
	mov   eax, [ebp + nb133nf_Vvdw]
	addsd xmm7, [eax + edx*8] 
	;# move back to mem 
	movsd [eax + edx*8], xmm7 
	
       ;# finish if last 
        mov ecx, [esp + nb133nf_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jecxz .nb133nf_outerend

        ;# not last, iterate outer loop once more!  
        mov [esp + nb133nf_n], esi
        jmp .nb133nf_outer
.nb133nf_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [esp + nb133nf_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jecxz .nb133nf_end
        ;# non-zero, do one more workunit
        jmp   .nb133nf_threadloop
.nb133nf_end:
	emms

	mov eax, [esp + nb133nf_nouter]
	mov ebx, [esp + nb133nf_ninner]
	mov ecx, [ebp + nb133nf_outeriter]
	mov edx, [ebp + nb133nf_inneriter]
	mov [ecx], eax
	mov [edx], ebx

	mov eax, [esp + nb133nf_salign]
	add esp, eax
	add esp, 572
	pop edi
	pop esi
    	pop edx
    	pop ecx
    	pop ebx
    	pop eax
	leave
	ret

