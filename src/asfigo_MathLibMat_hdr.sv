  class MathLibMat #(
      type INP_T = ml_matrix_t,
      type OUT_T = ml_vec_t
  );

    extern static function OUT_T mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

  endclass : MathLibMat

