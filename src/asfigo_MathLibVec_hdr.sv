  class MathLibVec #(
      type INP_T = ml_vec_t,
      type OUT_T = ml_vec_t,
      type MOD_T = ml_vec_t
  );

  // Verilog's mod % operator 
  // is TRUNCATED vs MATLAB is FLOORED
  // https://en.wikipedia.org/wiki/Modulo#In_programming_languages
    extern static function OUT_T mod(INP_T in_vec, MOD_T mod_vec);
    extern static function OUT_T rem(INP_T in_vec, MOD_T rem_vec);
    extern static function OUT_T abs (INP_T in_vec);
    extern static function OUT_T ceil (INP_T in_vec);
    extern static function OUT_T fix (INP_T in_vec);
    extern static function OUT_T floor (INP_T in_vec);
    extern static function ml_complex_vec_t sqrt (INP_T in_vec);
    extern static function OUT_T sign (INP_T in_vec);
    extern static function OUT_T exp (INP_T in_vec);
    extern static function OUT_T log (INP_T in_vec);

    extern static function OUT_T round (INP_T in_vec, 
      input int N=0, 
      input ml_round_tie_t tie = ML_TIE_NONE);
    extern static function OUT_T mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

  endclass : MathLibVec

