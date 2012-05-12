module fuji.dbg;

import fuji.fuji;


extern (C) void function(const(char)* pReason, const(char)* pMessage, const(char)* pFile = __FILE__.ptr, int line = __LINE__) MFDebug_DebugAssert;

void MFDebug_Assert(in char[] reason, in char[] message, string file = __FILE__, int line = __LINE__)
{
	MFDebug_DebugAssert(reason.ptr, message.ptr, file.ptr, line);
}

/**
* Logs a message to the debug output.
* Writes a message to the debug output.
* @param pMessage Message to be written to the debug output.
* @return None.
*/
extern (C) void function(const(char)* pMessage) MFDebug_Message;

/**
* Notifies the user of a critical error.
* Notifies the user of a critical error and logs it to the debugger.
* @param pErrorMessage Error message.
* @return None.
*/
extern (C) void function(const(char)* pErrorMessage) MFDebug_Error;

/**
* Notifies the user of a runtime warning.
* Notifies the user of a runtime warning. The warning level can be controlled at runtime to restrict unwanted warnings.
* @param level Warning level.
* @param pWarningMessage Message to log to the debugger.
* @return None.
* @remarks The warning level output can be controlled at runtime.
*
* Valid Warning levels:
* - 0 - Warning will be always be displayed. For critical warnings.
* - 1 - Critical Warning. Application will probably not run correctly.
* - 2 - Non-Critical Warning. Application will run, but may perform incorrectly.
* - 3 - General Warning. For general information feedback.
* - 4 - Low Warning. For small generally unimportant details.
*/
extern (C) void function(int level, const(char)* pWarningMessage) MFDebug_Warn;

/**
* Log a message to the debug output.
* Logs a message to the debug output. The log level can be controlled at runtime to restrict unwanted log messages.
* @param level Log level.
* @param pMessage Message to log to the debugger.
* @return None.
* @remarks The log level output can be controlled at runtime.
*
* Valid Log levels:
* - 0 - Messages will be always be displayed.
* - 1 - Important message.
* - 2 - Not so important message.
* - 3 - Typically unwanted message.
* - 4 - Very trivial and probably frequent spammy message.
*/
extern (C) void function(int level, const(char)* pMessage) MFDebug_Log;

/**
* Sets the maximum warning level.
* Sets the maximum warning level to be written to the debug output.
* @param maxLevel Maximum warning level (0-4).
* @return None.
*/
extern (C) void function(int maxLevel) MFDebug_SetMaximumWarningLevel;

/**
* Sets the maximum log level.
* Sets the maximum log level to be written to the debug output.
* @param maxLevel Maximum log level (0-4).
* @return None.
*/
extern (C) void function(int maxLevel) MFDebug_SetMaximumLogLevel;


package void HookupDebug()
{
	FindFujiFunction!MFDebug_DebugAssert;
	FindFujiFunction!MFDebug_Message;
	FindFujiFunction!MFDebug_Error;
	FindFujiFunction!MFDebug_Warn;
	FindFujiFunction!MFDebug_Log;
	FindFujiFunction!MFDebug_SetMaximumWarningLevel;
	FindFujiFunction!MFDebug_SetMaximumLogLevel;
}
