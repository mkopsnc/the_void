#include "mex.h"
#include "constants.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
   plhs[0] = mxCreateDoubleScalar(constants :: empty_int);
   
}