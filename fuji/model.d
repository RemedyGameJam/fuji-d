module fuji.model;

public import fuji.matrix;
public import fuji.fuji;

/**
* @struct MFModel
* Represents a Fuji model.
*/
struct MFModel;
struct MFMeshChunk;
struct MFAnimation;
struct MFBoundingVolume;

/**
* Creates a model from the filesystem.
* Creates a model from the filesystem.
* @param pFilename Filename of model to load.
* @return Returns a new instance of the specified model.
* @see MFModel_Destroy(), MFModel_Draw()
*/
extern (C) MFModel* function(const(char*) pFilename) MFModel_Create;

/**
* Creates a model from the filesystem.
* Creates a model from the filesystem.
* @param pFilename Filename of model to load.
* @param pAnimationFilename Filename of an animation to load and bind to the model instance.
* @return Returns a new instance of the specified model with animation already loaded and bound.
* @see MFModel_Create(), MFModel_BindAnimation()
*/
extern (C) MFModel* function(const(char*) pFilename, const(char*) pAnimationFilename) MFModel_CreateWithAnimation;

/**
* Dstroy a model.
* Destroys a model instance.
* @param pModel Model instance to be destroyed.
* @return Returns the new reference count of the model. If the returned reference count is 0, the model is destroyed.
* @see MFModel_Create(), MFModel_Draw()
*/
extern (C) int function(MFModel* pModel) MFModel_Destroy;

/**
* Draw a model.
* Renders a model using the current scene configuration.
* @param pModel Model instance to render.
* @return None.
* @see MFModel_Create()
*/
extern (C) void function(MFModel* pModel) MFModel_Draw;

/**
* Set the model world matrix.
* Sets the models local to world matrix.
* @param pModel Model instance.
* @param worldMatrix World matrix to assign to the model.
* @return None.
* @see MFModel_Draw()
*/
extern (C) void function(MFModel* pModel, ref const(MFMatrix) worldMatrix) MFModel_SetWorldMatrix;

/**
* Set the model colour.
* Sets the models colour.
* @param pModel Model instance.
* @param colour Colour to assign to the model instance.
* @return None.
* @see MFModel_Create()
*/
extern (C) void function(MFModel* pModel, ref const(MFVector) colour) MFModel_SetColour;

/**
* Get a models name.
* Gets the name of a model.
* @param pModel Model instance.
* @return The models name.
* @see MFModel_Create()
*/
extern (C) const(char*) function(MFModel* pModel) MFModel_GetName;

/**
* Get the number of subobjects.
* Get the number of subobjects in a model.
* @param pModel Model instance.
* @return The number of subobjects in \a pModel.
* @see MFModel_Create()
*/
extern (C) int function(MFModel* pModel) MFModel_GetNumSubObjects;

/**
* Get the index of a named subobject.
* Gets the index of a named subobject.
* @param pModel Model instance.
* @param pSubobjectName Name of a subobject.
* @return The index of the named subobject. If the subobject doesn't exist, -1 is returned.
* @see MFModel_GetSubObjectName()
*/
extern (C) int function(MFModel* pModel, const char* pSubobjectName) MFModel_GetSubObjectIndex;

/**
* Get the name of a specified subobject.
* Get the name of a specified subobject.
* @param pModel Model instance.
* @param index Subobject index.
* @return The subobjects name.
* @see MFModel_GetNumSubObjects()
*/
extern (C) const (char*) function(MFModel* pModel, int index) MFModel_GetSubObjectName;

/**
* Enabe or disable a subobject.
* Enabe or disable the specified subobject.
* @param pModel Model instance.
* @param index Subobject index.
* @param enable Bool to enable or disable the subobject.
* @return None.
* @see MFModel_GetNumSubObjects(), MFModel_IsSubobjectEnabed()
*/
extern (C) void function(MFModel* pModel, int index, bool enable) MFModel_EnableSubobject;

/**
* Find if a subobject is enabled.
* Finds if a specified subobject is enabled or disabled.
* @param pModel Model instance.
* @param index Subobject index.
* @return Returns true if the subobject is enabled.
* @see MFModel_GetNumSubObjects(), MFModel_EnableSubobject()
*/
extern (C) bool function(MFModel* pModel, int index) MFModel_IsSubobjectEnabed;

/**
* Get the models bounding volume.
* Gets the models bounding volume.
* @param pModel Model instance.
* @return Pointer to the models bounding volume.
*/
extern (C) MFBoundingVolume* function(MFModel* pModel) MFModel_GetBoundingVolume;

/**
* Get an MFModel mesh chunk.
* Gets a pointer to the specified MFModel mesh chunk.
* @param pModel Model instance.
* @param subobjectIndex Subobject index.
* @param meshChunkIndex Mesh chunk index.
* @return Pointer to the specified mesh chunk.
*/
extern (C) MFMeshChunk* function(MFModel* pModel, int subobjectIndex, int meshChunkIndex) MFModel_GetMeshChunk;

/**
* Get a pointer to an MFAnimation associated with the model.
* Gets a pointer to an MFAnimation associated with the model.
* @param pModel Model instance.
* @return Pointer to the MFAnimation associated with this model. If no animation is loaded, MFModel_GetAnimation returns NULL.
*/
extern (C) MFAnimation* function(MFModel* pModel) MFModel_GetAnimation;

/**
* Get the number of bones in the model.
* Gets the number of bones in the model.
* @param pModel Model instance.
* @return The number of bones in the model.
*/
extern (C) int function(MFModel* pModel) MFModel_GetNumBones;

/**
* Get the name of a bone.
* Gets the name of the specified bone.
* @param pModel Model instance.
* @param boneIndex Target bone index.
* @return The name of the specified bone.
*/
extern (C) const(char*) function(MFModel* pModel, int boneIndex) MFModel_GetBoneName;

/**
* Get a bones origin matrix.
* Gets the specified bones origin or 'bind' matrix.
* @param pModel Model instance.
* @param boneIndex Target bone index.
* @return The bones origin matrix.
*/
extern (C) const(MFMatrix*) function(MFModel* pModel, int boneIndex) MFModel_GetBoneOrigin;

/**
* Get the index of a bone by name.
* Gets the index of a bone by name.
* @param pModel Model instance.
* @param pName The target bones name.
* @return The index of the named bone, or -1 if the bone does not exist.
*/
extern (C) int function(MFModel* pModel, const(char*) pName) MFModel_GetBoneIndex;

/**
* Get the number of tags in the model.
* Gets the number of tags in the model.
* @param pModel Model instance.
* @return The number of tags in the model.
*/
extern (C) int function(MFModel* pModel) MFModel_GetNumTags;

/**
* Get the name of a tag.
* Gets the name of the specified tag.
* @param pModel Model instance.
* @param tagIndex Target tag index.
* @return The name of the specified tag.
*/
extern (C) const(char*) function(MFModel* pModel, int tagIndex) MFModel_GetTagName;

/**
* Get a tag matrix.
* Gets the specified tag matrix.
* @param pModel Model instance.
* @param tagIndex Target tag index.
* @return The tag matrix in the models local space.
*/
extern (C) const(MFMatrix*) function(MFModel* pModel, int tagIndex) MFModel_GetTagMatrix;

/**
* Get the index of a tag by name.
* Gets the index of a tag by name.
* @param pModel Model instance.
* @param pName The target tags name.
* @return The index of the named tag, or -1 if the tag does not exist.
*/
extern (C) int function(MFModel* pModel, const(char*) pName) MFModel_GetTagIndex;


private:

static this()
{
	FindFujiFunction!MFModel_Create;
	FindFujiFunction!MFModel_CreateWithAnimation;
	FindFujiFunction!MFModel_Destroy;
	FindFujiFunction!MFModel_Draw;
	FindFujiFunction!MFModel_SetWorldMatrix;
	FindFujiFunction!MFModel_SetColour;
	FindFujiFunction!MFModel_GetName;
	FindFujiFunction!MFModel_GetNumSubObjects;
	FindFujiFunction!MFModel_GetSubObjectIndex;
	FindFujiFunction!MFModel_GetSubObjectName;
	FindFujiFunction!MFModel_EnableSubobject;
	FindFujiFunction!MFModel_IsSubobjectEnabed;
	FindFujiFunction!MFModel_GetBoundingVolume;
	FindFujiFunction!MFModel_GetMeshChunk;
	FindFujiFunction!MFModel_GetAnimation;
	FindFujiFunction!MFModel_GetNumBones;
	FindFujiFunction!MFModel_GetBoneName;
	FindFujiFunction!MFModel_GetBoneOrigin;
	FindFujiFunction!MFModel_GetBoneIndex;
	FindFujiFunction!MFModel_GetNumTags;
	FindFujiFunction!MFModel_GetTagName;
	FindFujiFunction!MFModel_GetTagMatrix;
	FindFujiFunction!MFModel_GetTagIndex;
}
