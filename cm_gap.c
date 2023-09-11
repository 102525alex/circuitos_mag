/*
 * cm_gap.c Single coil magnetic circuit with predominant air-gap  
 * Author: Alberto Sanchez
 * 27/01/2021
 *
 * ver 1.0
 *
 * Model Description in this version. 
 * Note: 
 *
 * States:  x = [Psi]
 * Inputs:  u = [v]
 * Outputs: y = [i Psi e]
 *
 * PAR = [wb r xl xm]
 *
 */

#define S_FUNCTION_NAME cm_gap

#include "simstruc.h"
#include <math.h>

#define XINIT   ssGetArg(S,0)
#define PAR	ssGetArg(S,1)

/*
 * mdlInitializeSizes - initialize the sizes array
 */
static void mdlInitializeSizes(SimStruct *S)
{
    ssSetNumContStates(S, 1);       /* number of continuous states           */
    ssSetNumDiscStates(S, 0);       /* number of discrete states             */
    ssSetNumInputs(S, 1);           /* number of inputs                      */
    ssSetNumOutputs(S, 3);          /* number of outputs                     */
    ssSetDirectFeedThrough(S, 1);   /* direct feedthrough flag               */
    ssSetNumSampleTimes(S, 1);      /* number of sample times                */
    ssSetNumSFcnParams(S, 2);       /* number of input arguments             */
    ssSetNumRWork(S, 0);            /* number of real work vector elements   */
    ssSetNumIWork(S, 0);            /* number of integer work vector elements*/
    ssSetNumPWork(S, 0);            /* number of pointer work vector elements*/
}

/*
 * mdlInitializeSampleTimes - initialize the sample times array
 */
static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetSampleTime(S, 0, CONTINUOUS_SAMPLE_TIME);
    ssSetOffsetTime(S, 0, 0.0);
}


/*
 * mdlInitializeConditions - initialize the states
 */
static void mdlInitializeConditions(double *x0, SimStruct *S)
{

   x0[0] = mxGetPr(XINIT)[0];
}

/*
 * mdlOutputs - compute the outputs
 */

static void mdlOutputs(double *y, double *x, double *u, SimStruct *S, int tid)
{
double wb,r,xl,xm;
double XM,psim,i;

wb = mxGetPr(PAR)[0];
r = mxGetPr(PAR)[1];
xl = mxGetPr(PAR)[2];
xm = mxGetPr(PAR)[3];

XM = xl*xm/(xl+xm);
psim = XM*x[0]/xl;

i = (x[0]-psim)/xl;
  
y[0] = i;
y[1] = psim;
y[2] = -u[0]+r*(x[0]-psim)/xl; //fem inducida
}

/*
 * mdlUpdate - perform action at major integration time step
 */

static void mdlUpdate(double *x, double *u, SimStruct *S, int tid)
{
}

/*
 * mdlDerivatives - compute the derivatives
 */
static void mdlDerivatives(double *dx, double *x, double *u, SimStruct *S, int tid)
{
double wb,r,xl,xm;
double XM, psim;

wb = mxGetPr(PAR)[0];
r = mxGetPr(PAR)[1];
xl = mxGetPr(PAR)[2];
xm = mxGetPr(PAR)[3];

XM = xl*xm/(xl+xm);
psim = XM*x[0]/xl;

dx[0] = wb*(u[0]-r*(x[0]-psim)/xl);
}


/*
 * mdlTerminate - called when the simulation is terminated.
 */
static void mdlTerminate(SimStruct *S)
{
}

#ifdef	MATLAB_MEX_FILE    /* Is this file being compiled as a MEX-file? */
#include "simulink.c"      /* MEX-file interface mechanism */
#else
#include "cg_sfun.h"       /* Code generation registration function */
#endif
