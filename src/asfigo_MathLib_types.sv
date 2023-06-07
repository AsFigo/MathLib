  // From math.h
  parameter real M_E = 2.7182818284590452354;  /* e */
  parameter real M_LOG2E = 1.4426950408889634074;  /* log_2 e */
  parameter real M_LOG10E = 0.43429448190325182765;  /* log_10 e */
  parameter real M_LN2 = 0.69314718055994530942;  /* log_e 2 */
  parameter real M_LN10 = 2.30258509299404568402;  /* log_e 10 */
  parameter real M_PI = 3.14159265358979323846;  /* pi */
  parameter real M_PI_2 = 1.57079632679489661923;  /* pi/2 */
  parameter real M_PI_4 = 0.78539816339744830962;  /* pi/4 */
  parameter real M_1_PI = 0.31830988618379067154;  /* 1/pi */
  parameter real M_2_PI = 0.63661977236758134308;  /* 2/pi */
  parameter real M_2_SQRTPI = 1.12837916709551257390;  /* 2/sqrt(pi) */
  parameter real M_SQRT2 = 1.41421356237309504880;  /* sqrt(2) */
  parameter real M_SQRT1_2 = 0.70710678118654752440;  /* 1/sqrt(2) */

  typedef real ml_vec_t[];
  typedef real ml_matrix_t[][];
  typedef real ml_mda_t[][][];
  typedef enum bit [1:0] {
    ML_MEAN_ROW, ML_MEAN_COL, ML_MEAN_ALL} ml_mean_dim_t;

  typedef enum bit [3:0] {
    ML_TIE_NONE, ML_TIE_EVEN, ML_TIE_ODD, ML_TIE_PLUSINF,
    ML_TIE_MINUSINF, ML_TIE_FROMZERO, ML_TIE_TOZERO 
  } ml_round_tie_t;

  typedef struct {
    real r;
    real i;
  } ml_complex_t;

  typedef ml_complex_t ml_complex_vec_t [];
  typedef ml_complex_t ml_complex_mat_t [][];
