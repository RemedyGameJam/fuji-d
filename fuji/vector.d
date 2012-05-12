module fuji.vector;

struct MFVector
{
	float x = 0.0;
	float y = 0.0;
	float z = 0.0;
	float w = 0.0;

	static immutable MFVector zero = MFVector(0,0,0,0);
	static immutable MFVector one = MFVector(1,1,1,1);
	static immutable MFVector origin = MFVector(0,0,0,0);
	static immutable MFVector identity = MFVector(0,0,0,1);

	static immutable MFVector black = MFVector(0,0,0,1);
	static immutable MFVector white = MFVector(1,1,1,1);
	static immutable MFVector red = MFVector(1,0,0,1);
	static immutable MFVector green = MFVector(0,1,0,1);
	static immutable MFVector blue = MFVector(0,0,1,1);
}
