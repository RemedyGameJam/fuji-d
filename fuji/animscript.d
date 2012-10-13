module fuji.animscript;

public import fuji.fuji;
import fuji.matrix;
import fuji.model;

/**
* @struct MFAnimScript
* Represents a Fuji animation script.
*/
struct MFAnimScript;

/**
* Create an animscript from the filesystem.
* Creates an animscript from the filesystem.
* @param pFilename Filename of the animscript to load.
* @param pModel MFModel instance the animscript instance will refer to.
* @return Returns a new instance of the specified animscript.
* @see MFAnimScript_Destroy()
*/
extern (C) MFAnimScript* function(const(char*) pFilename, MFModel* pModel) MFAnimScript_Create;

/**
* Destroy an animscript.
* Destroys an animscript instance.
* @param pAnimScript Anim script instance to be destroyed.
* @return None.
* @see MFAnimScript_Create()
*/
extern (C) void function(MFAnimScript* pAnimScript) MFAnimScript_Destroy;

/**
* Get the number of animation sequences in the anim script.
* Gets the number of animation sequences in the anim script.
* @param pAnimScript Anim script instance.
* @return The number of sequences in the anim script.
* @see MFAnimScript_Create(), MFAnimScript_SetSequence()
*/
extern (C) int function(MFAnimScript* pAnimScript) MFAnimScript_GetNumSequences;

/**
* Play an animation sequence.
* Begin playback of an animation sequence.
* @param pAnimScript Anim script instance.
* @param sequence Sequence ID to begin playing.
* @param tweenTime The amout of time to tween into the new sequence.
* @return None.
* @see MFAnimScript_Create(), MFAnimScript_GetNumSequences(), MFAnimScript_FindSequence()
*/
extern (C) void function(MFAnimScript* pAnimScript, int sequence, float tweenTime = 0) MFAnimScript_PlaySequence;

/**
* Get the name of an animation sequence.
* Gets the name of the specified animation sequence.
* @param pAnimScript Anim script instance.
* @param sequence Sequence ID.
* @return The name of the specified.
* @see MFAnimScript_FindSequence()
*/
extern (C) const(char*) function(MFAnimScript* pAnimScript, int sequence) MFAnimScript_GetSequenceName;

/**
* Find an animation sequence.
* Find the ID of the named animation sequence.
* @param pAnimScript Anim script instance.
* @param pSequenceName Name of the sequence to find.
* @return The ID of the named sequence, or -1 of the sequence does not exist.
* @see MFAnimScript_GetSequenceName()
*/
extern (C) int function(MFAnimScript* pAnimScript, const(char*) pSequenceName) MFAnimScript_FindSequence;


private:

static this()
{
	FindFujiFunction!MFAnimScript_Create;
	FindFujiFunction!MFAnimScript_Destroy;
	FindFujiFunction!MFAnimScript_GetNumSequences;
	FindFujiFunction!MFAnimScript_PlaySequence;
	FindFujiFunction!MFAnimScript_GetSequenceName;
	FindFujiFunction!MFAnimScript_FindSequence;
}
