module fuji.fuji;

public import fuji.types;
public import fuji.dbg;

import std.c.windows.windows;

template MFDEGREES(a) { enum MFDEGREES = cast(typeof(a))(0.017453292519943295769236907684886 * a); }
template MFRADIANS(a) { enum MFRADIANS = cast(typeof(a))(57.295779513082320876798154814105 * a); }
template MFALIGN(x, bytes) { enum MFALIGN = (x + (bytes-1)) & ~(bytes-1); }
template MFALIGN16(x) { enum MFALIGN16 = MFALIGN!(x, 16); }
template MFUNFLAG(x, y) { enum MFUNFLAG = x & ~y; }
template MFFLAG(x, y) { enum MFFLAG = x | y; }
template MFBIT(alias x) { enum MFBIT = 1 << x; }

/**
* Defines a Fuji platform at runtime.
* These are generally used to communicate current or target platform at runtime.
*/
enum MFPlatform
{
	Unknown = -1,	/**< Unknown platform */

	PC = 0,			/**< PC */
	XBox,			/**< XBox */
	Linux,			/**< Linux */
	PSP,			/**< Playstation Portable */
	PS2,			/**< Playstation 2 */
	DC,				/**< Dreamcast */
	GC,				/**< Gamecube */
	OSX,			/**< MacOSX */
	Amiga,			/**< Amiga */
	XBox360,		/**< XBox360 */
	PS3,			/**< Playstation 3 */
	Wii,			/**< Nintendo Wii */
	Symbian,		/**< Symbian OS */
	IPhone,			/**< IPhone OS */
	Android,		/**< Android */
	WindowsMobile,	/**< Windows Mobile */
	NativeClient	/**< Native Client (NaCL) */
}

/**
* Defines a platform endian.
* Generally used to communicate current or target platform endian at runtime.
*/
enum MFEndian
{
	Unknown = -1,		/**< Unknown endian */

	LittleEndian = 0,	/**< Little Endian */
	BigEndian			/**< Big Endian */
}

package void FindFujiFunction(alias F)()
{
	F = cast(typeof(F))GetProcAddress(fujiDll, F.stringof.ptr);
	assert(F != null, "Unresolved external: " ~ F.stringof);
}

private:

HINSTANCE fujiDll;

static this()
{
	fujiDll = LoadLibraryA("Fuji_Debug.dll".ptr);
	assert(fujiDll != null, "Failed to load the Fuji_Debug.dll");

	// since we public import dbg, we need to sequence this one manually
	HookupDebug();
}
