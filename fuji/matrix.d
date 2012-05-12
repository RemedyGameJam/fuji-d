module fuji.matrix;

public import fuji.vector;

struct MFMatrix
{
	float[16] m = [ 1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1 ];

	static immutable MFMatrix identity = MFMatrix.init;
}
