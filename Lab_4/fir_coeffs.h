/*
 * Discrete-Time FIR Filter (real)
 * -------------------------------
 * Filter Structure  : Direct-Form FIR
 * Filter Length     : 16
 * Stable            : Yes
 * Linear Phase      : Yes (Type 2)
 * Arithmetic        : fixed
 * Numerator         : s16,15 -> [-1 1)
 * Input             : s16,15 -> [-1 1)
 * Filter Internals  : Full Precision
 *   Output          : s32,30 -> [-2 2)  (auto determined)
 *   Product         : s29,30 -> [-2.500000e-01 2.500000e-01)  (auto determined)
 *   Accumulator     : s32,30 -> [-2 2)  (auto determined)
 *   Round Mode      : No rounding
 *   Overflow Mode   : No overflow
 */

/* General type conversion for MATLAB generated C-code  */
#include "tmwtypes.h"


const int BL = 16;
const real64_T NUM[16] = {
  -0.001312255859375, -0.00543212890625, -0.01242065429688, -0.01077270507813,
    0.02047729492188,    0.090576171875,   0.1788330078125,   0.2411804199219,
     0.2411804199219,   0.1788330078125,    0.090576171875,  0.02047729492188,
   -0.01077270507813, -0.01242065429688, -0.00543212890625,-0.001312255859375
};
