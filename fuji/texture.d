module fuji.texture;

public import fuji.fuji;
import fuji.vector;

/**
* @struct MFTexture
* Represents a Fuji Texture.
*/
struct MFTexture;

/**
* Texture format.
* Describes a texture format.
*/
enum MFTextureFormat
{
	Unknown = -1, /**< Unknown texture format */

	A8R8G8B8,	/**< 32bit BGRA format */
	A8B8G8R8,	/**< 32bit RGBA format */
	B8G8R8A8,	/**< 32bit ARGB format */
	R8G8B8A8,	/**< 32bit ABGR format */

	R8G8B8,	/**< 24bit BGR format */
	B8G8R8,	/**< 24bit RGB format */

	A2R10G10B10,	/**< 32bit BGRA format with 10 bits per colour channel */
	A2B10G10R10,	/**< 32bit RGBA format with 10 bits per colour channel */

	A16B16G16R16, /**< 64bit RGBA format with 16 bits per colour channel */

	R5G6B5,		/**< 16bit BGR format with no alpha */
	R6G5B5,		/**< 16bit BGR format with no alpha and 6 bits for red */
	B5G6R5,		/**< 16bit RGB format with no alpha */

	A1R5G5B5,	/**< 16bit BGRA format with 1 bit alpha */
	R5G5B5A1,	/**< 16bit ABGR format with 1 bit alpha */
	A1B5G5R5,	/**< 16bit RGBA format with 1 bit alpha */

	A4R4G4B4,	/**< 16bit BGRA format with 4 bits per colour channel */
	A4B4G4R4,	/**< 16bit RGBA format with 4 bits per colour channel */
	R4G4B4A4,	/**< 16bit ABGR format with 4 bits per colour channel */

	ABGR_F16,	/**< 64bit RGBA floating point format - 16bit floats are described as follows, sign1-exp5-mantissa10 - seeeeemmmmmmmmmm */
	ABGR_F32,	/**< 128bit RGBA floating point format */

	I8,			/**< 8bit paletted format */
	I4,			/**< 4bit paletted format */

	DXT1,		/**< Compressed DXT1 texture */
	DXT2,		/**< Compressed DXT2 texture */
	DXT3,		/**< Compressed DXT3 texture */
	DXT4,		/**< Compressed DXT4 texture */
	DXT5,		/**< Compressed DXT5 texture */

	PSP_DXT1,	/**< Special DXT1 for PSP */
	PSP_DXT3,	/**< Special DXT3 for PSP */
	PSP_DXT5,	/**< Special DXT5 for PSP */

	// platform specific swizzled formats
	XB_A8R8G8B8s,	/**< 32bit BGRA format, swizzled for XBox */
	XB_A8B8G8R8s,	/**< 32bit RGBA format, swizzled for XBox */
	XB_B8G8R8A8s,	/**< 32bit ARGB format, swizzled for XBox */
	XB_R8G8B8A8s,	/**< 32bit ABGR format, swizzled for XBox */

	XB_R5G6B5s,		/**< 16bit BGR format, swizzled for XBox */
	XB_R6G5B5s,		/**< 16bit BGR format, swizzled for XBox */

	XB_A1R5G5B5s,	/**< 16bit BGRA format, swizzled for XBox */
	XB_R5G5B5A1s,	/**< 16bit ABGR format, swizzled for XBox */

	XB_A4R4G4B4s,	/**< 16bit BGRA format, swizzled for XBox */
	XB_R4G4B4A4s,	/**< 16bit ABGR format, swizzled for XBox */

	PSP_A8B8G8R8s,	/**< 32bit RGBA format, swizzled for PSP */
	PSP_B5G6R5s,		/**< 16bit RGB format, swizzled for PSP */
	PSP_A1B5G5R5s,	/**< 16bit RGBA format, swizzled for PSP */
	PSP_A4B4G4R4s,	/**< 16bit RGBA format, swizzled for PSP */

	PSP_I8s,		/**< 8bit paletted format, swizzled for PSP */
	PSP_I4s,		/**< 4bit paletted format, swizzled for PSP */

	PSP_DXT1s,		/**< DXT1, swizzled for PSP */
	PSP_DXT3s,		/**< DXT3, swizzled for PSP */
	PSP_DXT5s,		/**< DXT5, swizzled for PSP */

	Max,			/**< Max texture format */

	SelectNicest = 0x1000,			/**< Select the nicest format. */
	SelectNicest_NoAlpha = 0x1001,	/**< Select the nicest format with no alpha channel. */
	SelectFastest = 0x1002,			/**< Select the fastest format. */
	SelectFastest_Masked = 0x1003,	/**< Select the fastest format requiring only a single bit of alpha. */
	SelectFastest_NoAlpha = 0x1004	/**< Select the fastest format with no alpha channel. */
}

/**
* Texture flags.
* Flags to control the way textures are created.
*/
enum TextureFlags
{
	// Internal Flags
	AlphaMask = 0x3,				/**< Alpha mask. 0 = Opaque, 1 = Full Alpha, 3 = 1bit Alpha */
	PreMultipliedAlpha = MFBIT!2,	/**< Pre-multiplied alpha */
	Swizzled = MFBIT!3,				/**< Texture data is swizzled for the platform */
	RenderTarget = MFBIT!4,			/**< Texture is a render target */

	// User Flags
	CopyMemory = MFBIT!8			/**< Takes a copy of the image buffer when calling MFTexture_CreateFromRawData() */
}

/**
* Scaling algorithm.
* Supported scaling algorithms.
*/
enum MFScalingAlgorithm
{
	Unknown = -1,
	None = 0,	// no scaling
	Nearest,	// nearest filtering: any size
	Bilinear,	// bilinear filtering: any size
	Box,		// box filtering: 1/2x (common for mip generation)
	HQX,		// 'High Quality nX' algorithm: 2x, 3x, 4x
	AdvMAME,	// 'Advance MAME' algorithm: 2x, 3x, 4x
	Eagle,		// 'Eagle' algorithm: 2x
	SuperEagle,	// 'Super Eagle' algorithm: 2x
	_2xSaI,		// '2x Scale and Interpolate' algorithm: 2x
	Super2xSaI	// 'Super 2x Scale and Interpolate' algorithm: 2x
}

/**
* Image scaling data.
* Image scaling data.
*/
struct MFScaleImage
{
	void *pSourceImage;
	int sourceWidth;
	int sourceHeight;
	int sourceStride;

	void *pTargetBuffer;
	int targetWidth;
	int targetHeight;
	int targetStride;

	MFTextureFormat sourceFormat = MFTextureFormat.Unknown;
	MFScalingAlgorithm algorithm = MFScalingAlgorithm.Unknown;
}

// interface functions

/**
* Create a texture.
* Creates a texture from the filesystem.
* @param pName Name of texture to read from the filesystem.
* @param generateMipChain If true, a mip-chain will be generated for the texture.
* @return Pointer to an MFTexture structure representing the newly created texture.
* @remarks If the specified texture has already been created, MFTexture_Create will return a new reference to the already created texture.
* @see MFTexture_CreateDynamic(), MFTexture_CreateFromRawData(), MFTexture_CreateRenderTarget(), MFTexture_Destroy()
*/
extern (C) MFTexture* function(const char *pName, bool generateMipChain = true) MFTexture_Create;

/**
* Create a dynamic texture.
* Creates a dynamic texture.
* @param pName Name of the texture being created.
* @param width Image width.
* @param height Image height.
* @param format Format of the image data. Only formats supported by the platform and TexFmt_A8R8G8B8 can be used.
* @param flags Texture creation flags.
* @return Pointer to an MFTexture structure representing the newly created texture.
* @remarks If the specified texture has already been created, MFTexture_CreateDynamic will fail.
* @see MFTexture_Create(), MFTexture_CreateFromRawData(), MFTexture_CreateRenderTarget(), MFTexture_Destroy()
*/
extern (C) MFTexture* function(const char *pName, int width, int height, MFTextureFormat format, uint flags = 0) MFTexture_CreateDynamic;

/**
* Create a texture from raw data.
* Creates a texture from a raw data buffer.
* @param pName Name of the texture being created.
* @param pData Pointer to a buffer containing the image data
* @param width Image width.
* @param height Image height.
* @param format Format of the image data being read. Only formats supported by the platform and TexFmt_A8R8G8B8 can be used.
* @param flags Texture creation flags.
* @param generateMipChain If true, a mip-chain will be generated for the texture.
* @param pPalette Pointer to palette data. Use NULL for non-paletted image formats.
* @return Pointer to an MFTexture structure representing the newly created texture.
* @remarks If TexFmt_A8R8G8B8 is used, and it is not supported by the platform natively, a copy of the image is taken and the data is swizzled to the best available 32bit format on the target platform. Use MFTexture_GetPlatformAvailability() or MFTexture_IsAvailableOnPlatform() to determine what formats are supported on a particular platform.
* @see MFTexture_Create(), MFTexture_Destroy(), MFTexture_GetPlatformAvailability(), MFTexture_IsAvailableOnPlatform()
*/
extern (C) MFTexture* function(const char *pName, void *pData, int width, int height, MFTextureFormat format, uint flags = 0, bool generateMipChain = true, uint *pPalette = null) MFTexture_CreateFromRawData;

extern (C) void function(MFScaleImage *pScaleData) MFTexture_ScaleImage;

/**
* Create a scaled texture from raw data.
* Creates a texture from a raw data buffer that us scaled using a given algorithm.
* @param pName Name of the texture being created.
* @param pData Pointer to a buffer containing the image data
* @param sourceWidth Source image width.
* @param sourceHeight Source image height.
* @param texWidth Texture width.
* @param texHeight Texture height.
* @param format Format of the image data being read. Only formats supported by the platform and TexFmt_A8R8G8B8 can be used.
* @param algorithm Scaling algorithm to be used.
* @param flags Texture creation flags.
* @param pPalette Pointer to palette data. Use NULL for non-paletted image formats.
* @return Pointer to an MFTexture structure representing the newly created texture.
* @remarks If TexFmt_A8R8G8B8 is used, and it is not supported by the platform natively, a copy of the image is taken and the data is swizzled to the best available 32bit format on the target platform. Use MFTexture_GetPlatformAvailability() or MFTexture_IsAvailableOnPlatform() to determine what formats are supported on a particular platform.
* @see MFTexture_CreateFromRawData(), MFTexture_Create(), MFTexture_Destroy(), MFTexture_GetPlatformAvailability(), MFTexture_IsAvailableOnPlatform()
*/
extern (C) MFTexture* function(const char *pName, void *pData, int sourceWidth, int sourceHeight, int texWidth, int texHeight, MFTextureFormat format, MFScalingAlgorithm algorithm, uint flags = 0, uint *pPalette = null) MFTexture_ScaleFromRawData;

/**
* Creates a render target texture.
* Creates a render target texture.
* @param pName Name of the texture being created.
* @param width Width of render target.
* @param height Height of render target.
* @return Pointer to an MFTexture structure representing the newly created render target texture.
* @see MFTexture_Create(), MFTexture_Destroy()
*/
extern (C) MFTexture* function(const char *pName, int width, int height, MFTextureFormat targetFormat = MFTextureFormat.SelectNicest) MFTexture_CreateRenderTarget;

/**
* Destroys a Texture.
* Release a reference to an MFTexture and destroy when the reference reaches 0.
* @param pTexture Texture instance to be destroyed.
* @return Returns the new reference count of the texture. If the returned reference count is 0, the texture is destroyed.
* @see MFTexture_Create()
*/
extern (C) int function(MFTexture *pTexture) MFTexture_Destroy;

/**
* Find an existing texture.
* Finds an existing instance of the specified texture and returns a pointer. If the texture is not found, NULL is returned.
* Note: The reference count is NOT incremented by MFTexture_FindTexture().
* @param pName Name of texture to find.
* @return Returns a pointer to the texture if it is found, otherwise NULL is returned.
* @remarks MFTexture_Create does NOT increase the reference count of the texture so it is not required to destroy any texture returned by MFTexture_FindTexture().
* @see MFTexture_Create()
*/
extern (C) MFTexture* function(const char *pName) MFTexture_FindTexture;

/**
* Create a blank plain coloured texture.
* Create a new texture that is a solid colour.
* @param pName Name for the texture being created.
* @param colour Colour to fill the texture when it is created.
* @return Returns a pointer to a newly created blank texture.
* @see MFTexture_Create()
*/
extern (C) MFTexture* function(const char *pName, const ref MFVector colour) MFTexture_CreateBlank;

/**
* Get a string representing the texture format.
* Gets a human readable string representing the texture format.
* @param format Texture format to get the name of.
* @return Pointer to a string representing the texture format.
* @see MFTexture_GetPlatformAvailability(), MFTexture_GetBitsPerPixel()
*/
extern (C) const(char)* function(int format) MFTexture_GetFormatString;

/**
* Gets all platforms that support the specified texture format in hardware.
* Gets a variable representing which platforms support the specified texture format in hardware.
* @param format Format to test for hardware support.
* @return Result is a bitfield where each bit represents hardware support for a specific platform. Platform support can be tested, for example, using: ( result & MFBIT(FP_PC) ) != 0.
* @see MFTexture_GetFormatString(), MFTexture_GetBitsPerPixel()
*/
extern (C) uint function(int format) MFTexture_GetPlatformAvailability;

/**
* Tests to see if a texture format is available on the current platform.
* Tests if a texture format is supported in hardware on the current platform.
* @param format Texture format to be tested.
* @return Returns true if specified format is supported in hardware.
* @see MFTexture_GetPlatformAvailability()
*/
extern (C) bool function(int format) MFTexture_IsAvailable;

/**
* Tests to see if a texture format is available on a specified platform.
* Tests if a texture format is supported in hardware on a specified platform.
* @param format Texture format to be tested.
* @param platform Platform to test for hardware support.
* @return Returns true if specified format is supported in hardware.
* @see MFTexture_GetPlatformAvailability()
*/
extern (C) bool function(int format, int platform) MFTexture_IsAvailableOnPlatform;

/**
* Get the average number of bits per pixel for a specified format.
* Get the average number of bits per pixel for the specified format.
* @param format Name for the texture being created.
* @return Returns the number of bits per pixel for the specified format. If a compressed format is specified, the average number of bits per pixel is returned.
* @see MFTexture_GetPlatformAvailability(), MFTexture_GetFormatString()
*/
extern (C) int function(int format) MFTexture_GetBitsPerPixel;

extern (C) void function(MFTexture *pTexture, int *pWidth, int *pHeight) MFTexture_GetTextureDimensions;


private:

static this()
{
	FindFujiFunction!MFTexture_Create;
	FindFujiFunction!MFTexture_CreateDynamic;
	FindFujiFunction!MFTexture_CreateFromRawData;
	FindFujiFunction!MFTexture_ScaleImage;
	FindFujiFunction!MFTexture_ScaleFromRawData;
	FindFujiFunction!MFTexture_CreateRenderTarget;
	FindFujiFunction!MFTexture_Destroy;
	FindFujiFunction!MFTexture_FindTexture;
	FindFujiFunction!MFTexture_CreateBlank;
	FindFujiFunction!MFTexture_GetFormatString;
	FindFujiFunction!MFTexture_GetPlatformAvailability;
	FindFujiFunction!MFTexture_IsAvailable;
	FindFujiFunction!MFTexture_IsAvailableOnPlatform;
	FindFujiFunction!MFTexture_GetBitsPerPixel;
	FindFujiFunction!MFTexture_GetTextureDimensions;
}
