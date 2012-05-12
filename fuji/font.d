module fuji.font;

public import fuji.fuji;
import fuji.matrix;

/**
* @struct MFFont
* Represents a Fuji Font.
*/
struct MFFont;

/**
* Font Justification.
* These are the available text justifications.
*/
enum MFFontJustify
{
	Top_Left,			/**< Justify top left. */
	Top_Center,			/**< Justify top center. */
	Top_Right,			/**< Justify top right. */
	Top_Full,			/**< Justify top full. */

	Center_Left,		/**< Justify center left. */
	Center,				/**< Justify center. */
	Center_Right,		/**< Justify center right. */
	Center_Full,		/**< Justify center full. */

	Bottom_Left,		/**< Justify bottom left. */
	Bottom_Center,		/**< Justify bottom center. */
	Bottom_Right,		/**< Justify bottom right. */
	Bottom_Full			/**< Justify bottom full. */
}

// member functions

/**
* Create a font.
* Creates a font from the filesystem.
* @param pFilename Filename of the font to load.
* @return Pointer to an MFFont structure representing the newly created font.
* @see MFFont_Destroy()
*/
extern (C) MFFont* function(const char *pFilename) MFFont_Create;

/**
* Destroy a font.
* Destroys a font from the filesystem.
* @param pFont Pointer to a font to destroy.
* @return None.
* @see MFFont_Create()
*/
extern (C) void function(MFFont *pFont) MFFont_Destroy;

/**
* Get the height of a font.
* Gets the native height of a font.
* @param pFont Pointer to a font.
* @return The native height (in texels) of the specified font.
* @see MFFont_Create()
*/
extern (C) float function(MFFont *pFont) MFFont_GetFontHeight;

/**
* Get the width of a character.
* Gets the native width of a character in a font.
* @param pFont Pointer to a font.
* @param character Character to get the width for.
* @return The native width (in texels) of the specified character.
* @see MFFont_Create()
*/
extern (C) float function(MFFont *pFont, int character) MFFont_GetCharacterWidth;

/**
* Get the character offset into a string.
* Gets the offset of the specified character from the string's starting position.
* @param pFont Pointer to a font.
* @param pText Text containing the target character.
* @param charIndex Index of the character in the string to find the position of.
* @param height Height of the text.
* @return The physical offset of the specified character in the string from the string starting position.
* @see MFFont_GetStringWidth()
*/
extern (C) MFVector function(MFFont *pFont, const char *pText, int charIndex, float height) MFFont_GetCharPos;

/**
* Get the physical width of a string.
* Gets the physical width of a string.
* @param pFont Pointer to a font.
* @param pText Text to get the width for.
* @param height Height of the text (width is relative to the height).
* @param lineWidth The maximum line width before the string is wrapped onto a new line.
* @param maxLen Maximum number of characters to consider from the source string.
* @param pTotalHeight Optional pointer to a float that receives the total height of the specified string.
* @return The physical width of the specified string rendered by the specified font.
* @see MFFont_Create()
*/
extern (C) float function(MFFont *pFont, const char *pText, float height, float lineWidth = 0.0f, int maxLen = -1, float *pTotalHeight = null) MFFont_GetStringWidth;

/**
* Blit a string to the screen.
* Renders text to the screen (perfect texel to pixel mapping, no scaling).
* @param pFont Pointer to a font.
* @param x x coordinate in screen space.
* @param y y coordinate in screen space.
* @param colour Colour of the text.
* @param pText Pointer to a string containing the text to render.
* @param maxChars Maximum number of chars to render from the source string.
* @return Returns 0 if there were no errors.
*/
extern (C) int function(MFFont *pFont, int x, int y, const ref MFVector colour, const char *pText, int maxChars = -1) MFFont_BlitText;

/**
* Blit a formatted string to the screen.
* Blits formatted text to the screen (perfect texel to pixel mapping, no scaling).
* @param pFont Pointer to a font.
* @param x x coordinate in screen space.
* @param y y coordinate in screen space.
* @param colour Colour of the text.
* @param pFormat Pointer to the format string. This complies with all the regular printf format standards.
* @param ... Additional parameters used according to the format specifier.
* @return Returns 0 if there were no errors.
* @remarks The MFFont_BlitTextf format string conforms with all the standard printf format standards.
*/
extern (C) int function(MFFont *pFont, int x, int y, const ref MFVector colour, const char *pFormat, ...) MFFont_BlitTextf;

/**
* Render a string.
* Renders text to the screen.
* @param pFont Pointer to a font.
* @param pos Position in world space to render the string.
* @param height Height of the text.
* @param colour Colour of the text.
* @param pText Pointer to a string containing the text to render.
* @param maxChars Maximum number of chars to render from the source string.
* @param ltw Local to world matrix used to render the string.
* @return Returns the height of the text rendered.
*/
extern (C) float function(MFFont *pFont, const ref MFVector pos, float height, const ref MFVector colour, const char *pText, int maxChars = -1, const ref MFMatrix ltw = MFMatrix.identity) MFFont_DrawText;

/**
* Render a string.
* Renders text to the screen.
* @param pFont Pointer to a font.
* @param x X coordinate in world space to render the string.
* @param y Y coordinate in world space to render the string.
* @param height Height of the text.
* @param colour Colour of the text.
* @param pText Pointer to a string containing the text to render.
* @param maxChars Maximum number of chars to render from the source string.
* @param ltw Local to world matrix used to render the string.
* @return Returns the height of the text rendered.
*/
extern (C) float function(MFFont *pFont, float x, float y, float height, const ref MFVector colour, const char *pText, int maxChars = -1, const ref MFMatrix ltw = MFMatrix.identity) MFFont_DrawText2;

/**
* Render a formatted string.
* Renders formatted text to the screen.
* @param pFont Pointer to a font.
* @param pos Position in world space to render the string.
* @param height Height of the text.
* @param colour Colour of the text.
* @param pFormat Pointer to the format string. This complies with all the regular printf format standards.
* @param ... Additional parameters used according to the format specifier.
* @return Returns the height of the text rendered.
* @remarks The MFFont_DrawTextf format string conforms with all the standard printf format standards.
*/
extern (C) float function(MFFont *pFont, const ref MFVector pos, float height, const ref MFVector colour, const char *pFormat, ...) MFFont_DrawTextf;

/**
* Render a formatted string.
* Renders formatted text to the screen.
* @param pFont Pointer to a font.
* @param x X coordinate in world space to render the string.
* @param y Y coordinate in world space to render the string.
* @param height Height of the text.
* @param colour Colour of the text.
* @param pFormat Pointer to the format string. This complies with all the regular printf format standards.
* @param ... Additional parameters used according to the format specifier.
* @return Returns the height of the text rendered.
* @remarks The MFFont_DrawTextf format string conforms with all the standard printf format standards.
*/
extern (C) float function(MFFont *pFont, float x, float y, float height, const ref MFVector colour, const char *pFormat, ...) MFFont_DrawText2f;

extern (C) float function(MFFont *pFont, const char *pText, const ref MFVector pos, float boxWidth, float boxHeight, MFFontJustify justification, float textHeight, const ref MFVector color, int numChars = -1, const ref MFMatrix ltw = MFMatrix.identity) MFFont_DrawTextJustified;

extern (C) float function(MFFont *pFont, const char *pText, const ref MFVector pos, MFFontJustify justification, float lineWidth, float textHeight, const ref MFVector color, int numChars = -1, const ref MFMatrix ltw = MFMatrix.identity) MFFont_DrawTextAnchored;


/**
* Get the debug font.
* Gets a pointer to the debug font.
* @return Returns a pointer to the debug font.
*/
extern (C) MFFont* function() MFFont_GetDebugFont;


private:

static this()
{
	FindFujiFunction!MFFont_Create;
	FindFujiFunction!MFFont_Destroy;
	FindFujiFunction!MFFont_GetFontHeight;
	FindFujiFunction!MFFont_GetCharacterWidth;
	FindFujiFunction!MFFont_GetCharPos;
	FindFujiFunction!MFFont_GetStringWidth;
	FindFujiFunction!MFFont_BlitText;
	FindFujiFunction!MFFont_BlitTextf;
	FindFujiFunction!MFFont_DrawText;
	FindFujiFunction!MFFont_DrawText2;
	FindFujiFunction!MFFont_DrawTextf;
	FindFujiFunction!MFFont_DrawText2f;
	FindFujiFunction!MFFont_DrawTextJustified;
	FindFujiFunction!MFFont_DrawTextAnchored;
	FindFujiFunction!MFFont_GetDebugFont;
}
