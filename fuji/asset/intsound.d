module fuji.asset.intsound;

import fuji.fuji;

struct MFIntSound
{
	MFSoundTemplate soundTemplate;
	void* pSampleBuffer;
	void* pInternal;
}

extern (C) MFIntSound *MFIntSound_CreateFromFile(const(char*) pFilename);
extern (C) MFIntSound *MFIntSound_CreateFromFileInMemory(const(void*) pMemory, size_t size, const(char*) pFormatExtension);

extern (C) void MFIntSound_Destroy(MFIntSound* pSound);

extern (C) void MFIntSound_CreateRuntimeData(MFIntSound* pSound, void** ppOutput, size_t* pSize, MFPlatform platform);

