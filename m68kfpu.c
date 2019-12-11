/* ======================================================================== */
/* ========================= LICENSING & COPYRIGHT ======================== */
/* ======================================================================== */
/*
 *                                  MUSASHI
 *                                Version 3.32
 *
 * A portable Motorola M680x0 processor emulation engine.
 * Copyright Karl Stenerud.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include "m68kcpu.h"

extern void exit(int);

#if defined(_MSC_VER)
#  define NORETURN __declspec(noreturn)
#elif defined(__clang__) || defined(__GNUC__)
#  define NORETURN __attribute__((noreturn))
#else
#  define NORETURN
#endif

// TODO: Remove this and replace with a non-fatal signaling mechanism
static NORETURN void fatalerror(char *format, ...) {
      va_list ap;
      va_start(ap,format);
      vfprintf(stderr,format,ap);
      va_end(ap);
      exit(1);
}

#define FPCC_N			0x08000000
#define FPCC_Z			0x04000000
#define FPCC_I			0x02000000
#define FPCC_NAN		0x01000000

#define DOUBLE_INFINITY					(unsigned long long)(0x7ff0000000000000)
#define DOUBLE_EXPONENT					(unsigned long long)(0x7ff0000000000000)
#define DOUBLE_MANTISSA					(unsigned long long)(0x000fffffffffffff)

static inline void SET_CONDITION_CODES(fp_reg reg)
{
	REG_FPSR &= ~(FPCC_N|FPCC_Z|FPCC_I|FPCC_NAN);

	// sign flag
	if (reg.i & (unsigned long long)(0x8000000000000000))
	{
		REG_FPSR |= FPCC_N;
	}

	// zero flag
	if ((reg.i & (unsigned long long)(0x7fffffffffffffff)) == 0)
	{
		REG_FPSR |= FPCC_Z;
	}

	// infinity flag
	if ((reg.i & (unsigned long long)(0x7fffffffffffffff)) == DOUBLE_INFINITY)
	{
		REG_FPSR |= FPCC_I;
	}

	// NaN flag
	if (((reg.i & DOUBLE_EXPONENT) == DOUBLE_EXPONENT) && ((reg.i & DOUBLE_MANTISSA) != 0))
	{
		REG_FPSR |= FPCC_NAN;
	}
}

static inline int TEST_CONDITION(int condition)
{
	int n = (REG_FPSR & FPCC_N) != 0;
	int z = (REG_FPSR & FPCC_Z) != 0;
	int nan = (REG_FPSR & FPCC_NAN) != 0;
	int r = 0;
	switch (condition)
	{
		case 0x00:		return 0;							// False
		case 0x01:		return (z);							// Equal
		case 0x0e:		return (!z);						// Not Equal
		case 0x0f:		return 1;							// True
		case 0x02:	//OGT
		case 0x12:		return (!(nan || z || n));			// Greater Than
		case 0x03:	//OGE
		case 0x13:		return (z || !(nan || n));			// Greater or Equal
		case 0x04:	//OLT
		case 0x14:		return (n && !(nan || z));			// Less Than
		case 0x05:	//OLE
		case 0x15:		return (z || (n && !nan));			// Less Than or Equal
		case 0x0a:	//UGT
		case 0x1a:		return (nan || !(n || z));			// Not Less Than or Equal
		case 0x0b:	//UGE
		case 0x1b:		return (nan || z || !n);			// Not Less Than
		case 0x0c:	//ULT
		case 0x1c:		return (nan || (n && !z));			// Not Greater or Equal Than
		case 0x0d:	//ULE
		case 0x1d:		return (nan || z || n);				// Not Greater Than
		case 0x06:		return (!(nan || z));				// OGL
		case 0x09:		return (nan || z);				// UEQ
		case 0x07:		return (!nan);					// OR
		case 0x08:		return (nan);					// UN

		default:		fatalerror("M68040: test_condition: unhandled condition %02X\n", condition);
	}

	return r;
}

static uint8 READ_EA_8(int ea)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	switch (mode)
	{
		case 0:		// Dn
		{
			return REG_D[reg];
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_8();
			return m68ki_read_8(ea);
		}
		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_8();
			return m68ki_read_8(ea);
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					return m68ki_read_8(ea);
				}
				case 4:		// #<data>
				{
					return  OPER_I_8();
				}
				default:	fatalerror("MC68040: READ_EA_8: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: READ_EA_8: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
	}

	return 0;
}

static uint16 READ_EA_16(int ea)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	switch (mode)
	{
		case 0:		// Dn
		{
			return (uint16)(REG_D[reg]);
		}
		case 2:		// (An)
		{
			uint32 ea = REG_A[reg];
			return m68ki_read_16(ea);
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_16();
			return m68ki_read_16(ea);
		}
		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_16();
			return m68ki_read_16(ea);
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					return m68ki_read_16(ea);
				}
				case 4:		// #<data>
				{
					return OPER_I_16();
				}

				default:	fatalerror("MC68040: READ_EA_16: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: READ_EA_16: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
	}

	return 0;
}

static uint32 READ_EA_32(int ea)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	switch (mode)
	{
		case 0:		// Dn
		{
			return REG_D[reg];
		}
		case 2:		// (An)
		{
			uint32 ea = REG_A[reg];
			return m68ki_read_32(ea);
		}
		case 3:		// (An)+
		{
			uint32 ea = EA_AY_PI_32();
			return m68ki_read_32(ea);
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_32();
			return m68ki_read_32(ea);
		}
		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_32();
			return m68ki_read_32(ea);
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					return m68ki_read_32(ea);
				}
				case 2:		// (d16, PC)
				{
					uint32 ea = EA_PCDI_32();
					return m68ki_read_32(ea);
				}
				case 4:		// #<data>
				{
					return  OPER_I_32();
				}
				default:	fatalerror("MC68040: READ_EA_32: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: READ_EA_32: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
	}
	return 0;
}

static void WRITE_EA_32(int ea, uint32 data)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	switch (mode)
	{
		case 0:		// Dn
		{
			REG_D[reg] = data;
			break;
		}
		case 2:		// (An)
		{
			uint32 ea = REG_A[reg];
			m68ki_write_32(ea, data);
			break;
		}
		case 3:		// (An)+
		{
			uint32 ea = EA_AY_PI_32();
			m68ki_write_32(ea, data);
			break;
		}
		case 4:		// -(An)
		{
			uint32 ea = EA_AY_PD_32();
			m68ki_write_32(ea, data);
			break;
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_32();
			m68ki_write_32(ea, data);
			break;
		}
		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_32();
			m68ki_write_32(ea, data);
			break;
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					m68ki_write_32(ea, data);
					break;
				}
				case 2:		// (d16, PC)
				{
					uint32 ea = EA_PCDI_32();
					m68ki_write_32(ea, data);
					break;
				}
				default:	fatalerror("MC68040: WRITE_EA_32: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: WRITE_EA_32: unhandled mode %d, reg %d, data %08X at %08X\n", mode, reg, data, REG_PC);
	}
}

static uint64 READ_EA_64(int ea)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);
	uint32 h1, h2;

	switch (mode)
	{
		case 2:		// (An)
		{
			uint32 ea = REG_A[reg];
			h1 = m68ki_read_32(ea+0);
			h2 = m68ki_read_32(ea+4);
			return  (uint64)(h1) << 32 | (uint64)(h2);
		}
		case 3:		// (An)+
		{
			uint32 ea = REG_A[reg];
			REG_A[reg] += 8;
			h1 = m68ki_read_32(ea+0);
			h2 = m68ki_read_32(ea+4);
			return  (uint64)(h1) << 32 | (uint64)(h2);
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_32();
			h1 = m68ki_read_32(ea+0);
			h2 = m68ki_read_32(ea+4);
			return  (uint64)(h1) << 32 | (uint64)(h2);
		}
		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_16();
			h1 = m68ki_read_32(ea+0);
			h2 = m68ki_read_32(ea+4);
			return  (uint64)(h1) << 32 | (uint64)(h2);
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					h1 = m68ki_read_32(ea+0);
					h2 = m68ki_read_32(ea+4);
					return  (uint64)(h1) << 32 | (uint64)(h2);
				}
				case 4:		// #<data>
				{
					h1 = OPER_I_32();
					h2 = OPER_I_32();
					return  (uint64)(h1) << 32 | (uint64)(h2);
				}
				case 2:		// (d16, PC)
				{
					uint32 ea = EA_PCDI_32();
					h1 = m68ki_read_32(ea+0);
					h2 = m68ki_read_32(ea+4);
					return  (uint64)(h1) << 32 | (uint64)(h2);
				}
				default:	fatalerror("MC68040: READ_EA_64: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: READ_EA_64: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
	}

	return 0;
}

static void WRITE_EA_64(int ea, uint64 data)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	switch (mode)
	{
		case 2:		// (An)
		{
			uint32 ea = REG_A[reg];
			m68ki_write_32(ea+0, (uint32)(data >> 32));
			m68ki_write_32(ea+4, (uint32)(data));
			break;
		}
		case 4:		// -(An)
		{
			uint32 ea;
			REG_A[reg] -= 8;
			ea = REG_A[reg];
			m68ki_write_32(ea+0, (uint32)(data >> 32));
			m68ki_write_32(ea+4, (uint32)(data));
			break;
		}
		case 5:		// (d16, An)
		{
			uint32 ea = EA_AY_DI_32();
			m68ki_write_32(ea+0, (uint32)(data >> 32));
			m68ki_write_32(ea+4, (uint32)(data));
			break;
		}

		case 6:		// (An) + (Xn) + d8
		{
			uint32 ea = EA_AY_IX_16();
			m68ki_write_32(ea+0, (uint32)(data >> 32));
			m68ki_write_32(ea+4, (uint32)(data));
			break;
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					uint32 ea = (d1 << 16) | d2;
					m68ki_write_32(ea+0, (uint32)(data >> 32));
					m68ki_write_32(ea+4, (uint32)(data));
					break;
				}
				case 2:		// (d16, PC)
				{
					uint32 ea = EA_PCDI_32();
					m68ki_write_32(ea+0, (uint32)(data >> 32));
					m68ki_write_32(ea+4, (uint32)(data));
					break;
				}
				default:	fatalerror("MC68040: WRITE_EA_64: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: WRITE_EA_64: unhandled mode %d, reg %d, data %08X%08X at %08X\n", mode, reg, (uint32)(data >> 32), (uint32)(data), REG_PC);
	}
}

static void d_to_h3(double d, uint32 * h)
{
	uint64 n = *(uint64 *)&d;
	uint64 m = n & 0x000fffffffffffffLL;
	uint32 exp = ((n>>52)&0x7ff) - 1023;
	*(uint64 *)h = (m << 11) | 0x8000000000000000L;
	h[2] = ((n>>32)&0x80000000) | ((exp+16383LL)<<16);
}

static double h3_to_d(uint32 * h)
{
	uint64 m = *(uint64 *)h;
	uint32 exp = ((h[2]>>16)&0x7fff) - 16383;
	uint64 n = ((h[2]&0x80000000LL)<<32) | ((exp + 1023LL)<<52) | ((m<<1)>>12);
	double d = *(double *)&n;
/*
	fprintf(stderr, "read xdouble %e %16Lx - %08x %08x %08x %d %16Lx\n", d, n, h[2], h[1], h[0], exp, m);
	uint32 x[3] = {0, 0, 0};
	d_to_h3(d, x);
	fprintf(stderr, "-> %08x %08x %08x\n", x[2], x[1], x[0]);
*/
	return d;
}

static double READ_EA_96(int ea)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);
	uint32 h[3];
	uint32 addr;

	switch (mode)
	{
		case 2:		// (An)
		{
			addr = REG_A[reg];
			break;
		}
		case 3:		// (An)+
		{
			addr = REG_A[reg];
			REG_A[reg] += 12;
			break;
		}
		case 5:		// (d16, An)
		{
			addr = EA_AY_DI_32();
			break;
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					addr = (d1 << 16) | d2;
					break;
				}
				case 2:		// (d16, PC)
				{
					addr = EA_PCDI_32();
					break;
				}
				case 4:		// #<data>
				{
					h[2] = OPER_I_32();
					h[1] = OPER_I_32();
					h[0] = OPER_I_32();
					return  *(long double *)h;
				}
				default:	fatalerror("MC68040: READ_EA_96: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: READ_EA_96: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
	}

	h[2] = m68ki_read_32(addr+0);
	h[1] = m68ki_read_32(addr+4);
	h[0] = m68ki_read_32(addr+8);

	return h3_to_d(h);
}

static void WRITE_EA_96(int ea, double d)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	uint32 h[3] = {0, 0, 0};
	uint32 addr;

	switch (mode)
	{
		case 2:		// (An)
		{
			addr = REG_A[reg];
			break;
		}
		case 4:		// -(An)
		{
			REG_A[reg] -= 12;
			addr = REG_A[reg];
			break;
		}
		case 5:		// (d16, An)
		{
			addr = EA_AY_DI_32();
			break;
		}
		case 7:
		{
			switch (reg)
			{
				case 1:		// (xxx).L
				{
					uint32 d1 = OPER_I_16();
					uint32 d2 = OPER_I_16();
					addr = (d1 << 16) | d2;
					break;
				}
				case 2:		// (d16, PC)
				{
					addr = EA_PCDI_32();
					break;
				}
				default:	fatalerror("MC68040: WRITE_EA_64: unhandled mode %d, reg %d at %08X\n", mode, reg, REG_PC);
			}
			break;
		}
		default:	fatalerror("MC68040: WRITE_EA_96: unhandled mode %d, reg %d, data %08X%08X%08X at %08X\n", mode, reg, h[0], h[1], h[2], REG_PC);
	}
	d_to_h3(d, h);
	m68ki_write_32(addr+0, h[2]);
	m68ki_write_32(addr+4, h[1]);
	m68ki_write_32(addr+8, h[0]);
}


static fp_reg READ_EA_FPE(int ea, uint32 addr)
{
	fp_reg r;
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	uint32 h[3];

	switch (mode)
	{
		case 3:		// (An)+
		{
			addr = REG_A[reg];
			REG_A[reg] += 12;
			break;
		}
		case 5:		// (d16, An)
		{
			// addr as parameter
			break;
		}
		default:	fatalerror("MC68040: READ_EA_FPE: unhandled mode %d, reg %d, at %08X\n", mode, reg, REG_PC);
	}

	h[2] = m68ki_read_32(addr+0);
	h[1] = m68ki_read_32(addr+4);
	h[0] = m68ki_read_32(addr+8);

	r.f = h3_to_d(h);

//	fprintf(stderr, "set fp to %f at addr %08x\n", r.f, addr);
	return r;
}

static void WRITE_EA_FPE(int ea, fp_reg fpr)
{
	int mode = (ea >> 3) & 0x7;
	int reg = (ea & 0x7);

	uint32 addr;

	switch (mode)
	{
		case 4:		// -(An)
		{
			REG_A[reg] -= 12;
			addr = REG_A[reg];
			break;
		}
		default:	fatalerror("MC68040: WRITE_EA_FPE: unhandled mode %d, reg %d, data %f at %08X\n", mode, reg, fpr.f, REG_PC);
	}
	uint32 h[3] = {0, 0, 0};
	d_to_h3(fpr.f, h);
	m68ki_write_32(addr+0, h[2]);
	m68ki_write_32(addr+4, h[1]);
	m68ki_write_32(addr+8, h[0]);
}


static void fpgen_rm_reg(uint16 w2)
{
	int ea = REG_IR & 0x3f;
	int rm = (w2 >> 14) & 0x1;
	int src = (w2 >> 10) & 0x7;
	int dst = (w2 >>  7) & 0x7;
	int opmode = w2 & 0x7f;
	double source;

	if (rm)
	{
		switch (src)
		{
			case 0:		// Long-Word Integer
			{
				sint32 d = READ_EA_32(ea);
				source = (double)(d);
				break;
			}
			case 1:		// Single-precision Real
			{
				uint32 d = READ_EA_32(ea);
				source = (double)(*(float*)&d);
				break;
			}
			case 2:		// Extended-precision Real
			{
				source = (double)READ_EA_96(ea);
				break;
			}
			case 3:		// Packed-decimal Real
			{
				fatalerror("fpgen_rm_reg: packed-decimal real load unimplemented at %08X\n", REG_PC-4);
				break;
			}
			case 4:		// Word Integer
			{
				sint16 d = READ_EA_16(ea);
				source = (double)(d);
				break;
			}
			case 5:		// Double-precision Real
			{
				uint64 d = READ_EA_64(ea);
				source = *(double*)&d;
				break;
			}
			case 6:		// Byte Integer
			{
				sint8 d = READ_EA_8(ea);
				source = (double)(d);
				break;
			}
			case 7:
			{
				if (!rm)
					fatalerror("fpgen_rm_reg: fmovecr expects rm=1\n");

				switch (opmode)
				{
					case 0x00: source = M_PI; break;
					case 0x0b: source = 0.301029995663981195214; break;
					case 0x0c: source = M_E; break;
					case 0x0d: source = M_LOG2E; break;
					case 0x0e: source = M_LOG10E; break;
					case 0x0f: source = 0.0; break;
					case 0x30: source = M_LN2; break;
					case 0x31: source = M_LN10; break;
					case 0x32: source = 1.; break;
					case 0x33: source = 1e1; break;
					case 0x34: source = 1e2; break;
					case 0x35: source = 1e4; break;
					case 0x36: source = 1e8; break;
					case 0x37: source = 1e16; break;
					case 0x38: source = 1e32; break;
					case 0x39: source = 1e64; break;
					case 0x3a: source = 1e128; break;
					case 0x3b: source = 1e256; break;
					case 0x3c: source = 1e512; break;
					case 0x3d: source = 1e1024; break;
					case 0x3e: source = 1e2048; break;
					case 0x3f: source = 1e4096; break;

					default:
						fatalerror("fpgen_rm_reg: fmovecr unknown offset %d\n", opmode);
				}

				opmode = 0; // it's a move
				break;
			}
		}
	}
	else
	{
		source = REG_FP[src].f;
	}

	switch (opmode)
	{
		case 0x00:		// FMOVE
		{
			REG_FP[dst].f = source;
			USE_CYCLES(4);
			break;
		}
		case 0x03:		// FINTRZ
		{
			REG_FP[dst].f = (int)source;
			USE_CYCLES(4);
			break;
		}
		case 0x04:		// FSQRT
		{
			REG_FP[dst].f = sqrt(source);
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(109);
			break;
		}
		case 0x18:		// FABS
		{
			REG_FP[dst].f = fabs(source);
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(3);
			break;
		}
		case 0x1a:		// FNEG
		{
			REG_FP[dst].f = -source;
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(3);
			break;
		}

		case 0x20:		// FDIV
		{
			REG_FP[dst].f /= source;
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(43);
			break;
		}
		case 0x24:		// FSGLDIV
		{
			REG_FP[dst].f = (float)(REG_FP[dst].f / source);
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(43);
			break;
		}
		case 0x22:		// FADD
		{
			REG_FP[dst].f += source;
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(9);
			break;
		}
		case 0x23:		// FMUL
		{
			REG_FP[dst].f *= source;
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(11);
			break;
		}
		case 0x27:		// FSGLMUL
		{
			REG_FP[dst].f = (float)(REG_FP[dst].f * source);
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(11);
			break;
		}
		case 0x28:		// FSUB
		{
			REG_FP[dst].f -= source;
			SET_CONDITION_CODES(REG_FP[dst]);
			USE_CYCLES(9);
			break;
		}
		case 0x38:		// FCMP
		{
			fp_reg res;
			res.f = REG_FP[dst].f - source;
			SET_CONDITION_CODES(res);
			USE_CYCLES(7);
			break;
		}
		case 0x3a:		// FTST
		{
			fp_reg res;
			res.f = source;
			SET_CONDITION_CODES(res);
			USE_CYCLES(7);
			break;
		}


		// FSGLMUL

		default:	fatalerror("fpgen_rm_reg: unimplemented opmode %02X at %08X\n", opmode, REG_PC-4);
	}
}

static void fscc_mem(void)
{
	int ea = REG_IR & 0x3f;
	int w2 = OPER_I_16();
	int flag = TEST_CONDITION(w2 & 0x3f) ? 0xff : 0;

	WRITE_EA_32(ea, flag);
	USE_CYCLES(12);
}

static void fmove_reg_mem(uint16 w2)
{
	int ea = REG_IR & 0x3f;
	int src = (w2 >>  7) & 0x7;
	int dst = (w2 >> 10) & 0x7;
	//int kfactor = w2 & 0x7f;

	switch (dst)
	{
		case 0:		// Long-Word Integer
		{
			sint32 d = (sint32)(REG_FP[src].f);
			WRITE_EA_32(ea, d);
			break;
		}
		case 1:		// Single-precision Real
		{
			float f = (float)(REG_FP[src].f);
			uint32 d = *(uint32 *)&f;
			WRITE_EA_32(ea, d);
			break;
		}
		case 2:		// Extended-precision Real
		{
			WRITE_EA_96(ea, REG_FP[src].f);
			break;
		}
		case 3:		// Packed-decimal Real with Static K-factor
		{
			fatalerror("fmove_reg_mem: packed-decimal real store unimplemented at %08X\n", REG_PC-4);
			break;
		}
		case 4:		// Word Integer
		{
			fatalerror("fmove_reg_mem: word integer store unimplemented at %08X\n", REG_PC-4);
			break;
		}
		case 5:		// Double-precision Real
		{
			uint64 d = REG_FP[src].i;
			WRITE_EA_64(ea, d);
			break;
		}
		case 6:		// Byte Integer
		{
			fatalerror("fmove_reg_mem: byte integer store unimplemented at %08X\n", REG_PC-4);
			break;
		}
		case 7:		// Packed-decimal Real with Dynamic K-factor
		{
			fatalerror("fmove_reg_mem: packed-decimal real store unimplemented at %08X\n", REG_PC-4);
			break;
		}
	}

	USE_CYCLES(12);
}

static void fmove_fpcr(uint16 w2)
{
	int ea = REG_IR & 0x3f;
	int dir = (w2 >> 13) & 0x1;
	int reg = (w2 >> 10) & 0x7;

	if (dir)	// From system control reg to <ea>
	{
		switch (reg)
		{
			case 1:		WRITE_EA_32(ea, REG_FPIAR); break;
			case 2:		WRITE_EA_32(ea, REG_FPSR); break;
			case 4:		WRITE_EA_32(ea, REG_FPCR); break;
			default:	fatalerror("fmove_fpcr: unknown reg %d, dir %d\n", reg, dir);
		}
	}
	else		// From <ea> to system control reg
	{
		switch (reg)
		{
			case 1:		REG_FPIAR = READ_EA_32(ea); break;
			case 2:		REG_FPSR = READ_EA_32(ea); break;
			case 4:		REG_FPCR = READ_EA_32(ea); break;
			default:	fatalerror("fmove_fpcr: unknown reg %d, dir %d\n", reg, dir);
		}
	}

	USE_CYCLES(10);
}

static void fmovem(uint16 w2)
{
	int i, j;
	int ea = REG_IR & 0x3f;
	int dir = (w2 >> 13) & 0x1;
	int mode = (w2 >> 11) & 0x3;
	int reglist = w2 & 0xff;

	if (dir)	// From FP regs to mem
	{
		switch (mode)
		{
			case 0:		// Static register list, predecrement addressing mode
			{
				for (i=0; i < 8; i++)
				{
					if (reglist & (1 << i))
					{
						WRITE_EA_FPE(ea, REG_FP[i]);
						USE_CYCLES(2);
					}
				}
				break;
			}

			default:	fatalerror("040fpu0: FMOVEM: mode %d unimplemented at %08X\n", mode, REG_PC-4);
		}
	}
	else		// From mem to FP regs
	{
		switch (mode)
		{
			case 2:		// Static register list, postincrement addressing mode
			{
				if (((ea >> 3) & 0x7) == 5)
					j = EA_AY_DI_32();
				else
					j = 0;

				for (i=0; i < 8; i++)
				{
					if (reglist & (1 << i))
					{
						REG_FP[7-i] = READ_EA_FPE(ea, j);
						USE_CYCLES(2);
						j += 12;
					}
				}
				break;
			}

			default:	fatalerror("040fpu0: FMOVEM: mode %d unimplemented at %08X\n", mode, REG_PC-4);
		}
	}
}

static void fbcc16(void)
{
	sint32 offset;
	int condition = REG_IR & 0x3f;

	offset = (sint16)(OPER_I_16());

	// TODO: condition and jump!!!
	if (TEST_CONDITION(condition))
	{
		m68ki_trace_t0();			   /* auto-disable (see m68kcpu.h) */
		m68ki_branch_16(offset-2);
	}

	USE_CYCLES(7);
	}

static void fbcc32(void)
{
	sint32 offset;
	int condition = REG_IR & 0x3f;

	offset = OPER_I_32();

	// TODO: condition and jump!!!
	if (TEST_CONDITION(condition))
	{
		m68ki_trace_t0();			   /* auto-disable (see m68kcpu.h) */
		m68ki_branch_32(offset-4);
	}

	USE_CYCLES(7);
}


void m68040_fpu_op0(void)
{
	switch ((REG_IR >> 6) & 0x3)
	{
		case 0:
		{
			uint16 w2 = OPER_I_16();
			switch ((w2 >> 13) & 0x7)
			{
				case 0x0:	// FPU ALU FP, FP
				case 0x2:	// FPU ALU ea, FP
				{
					fpgen_rm_reg(w2);
					break;
				}

				case 0x3:	// FMOVE FP, ea
				{
					fmove_reg_mem(w2);
					break;
				}

				case 0x4:	// FMOVE ea, FPCR
				case 0x5:	// FMOVE FPCR, ea
				{
					fmove_fpcr(w2);
					break;
				}

				case 0x6:	// FMOVEM ea, list
				case 0x7:	// FMOVEM list, ea
				{
					fmovem(w2);
					break;
				}

				default:	fatalerror("m68040_fpu_op0: unimplemented subop %d at %08X\n", (w2 >> 13) & 0x7, REG_PC-4);
			}
			break;
		}

		case 1:	// FScc
		{
			fscc_mem();
			break;
		}

		case 2:		// FBcc disp16
		{
			fbcc16();
			break;
		}
		case 3:		// FBcc disp32
		{
			fbcc32();
			break;
		}

		default:	fatalerror("m68040_fpu_op0: unimplemented main op %d\n", (REG_IR >> 6)	& 0x3);
	}
}

void m68040_fpu_op1(void)
{
	int ea = REG_IR & 0x3f;
	switch ((REG_IR >> 6) & 0x3)
	{
		case 0:		// FSAVE <ea>
		{
			WRITE_EA_32(ea, 0x00000000);
			// TODO: correct state frame
			break;
		}

		case 1:		// FRESTORE <ea>
		{
			READ_EA_32(ea);
			// TODO: correct state frame
			break;
		}

		default:	fatalerror("m68040_fpu_op1: unimplemented op %d at %08X\n", (REG_IR >> 6) & 0x3, REG_PC-2);
	}
}



