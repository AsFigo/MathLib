    function MathLibVec::OUT_T MathLibVec::mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

      OUT_T ret_val;
      int num_upk_dim;

      num_upk_dim = $unpacked_dimensions (in_val);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

        ret_val = new [1];
        ret_val[0] = 0.0;
        ret_val[0] = in_val.sum;
        ret_val[0] = in_val.sum() / in_val.size();

      return ret_val;
    endfunction : mean

  // Verilog's mod % operator 
  // is TRUNCATED vs MATLAB is FLOORED
  // https://en.wikipedia.org/wiki/Modulo#In_programming_languages

    function MathLibVec::OUT_T MathLibVec::mod(INP_T in_vec, MOD_T mod_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int num_upk_dim_mod;
      int lv_num_vals;
      real lv_mod;
      real lv_real_num;

      num_upk_dim = $unpacked_dimensions (in_vec);
      num_upk_dim_mod = $unpacked_dimensions (mod_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];
      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        if (num_upk_dim_mod == 0)
          lv_mod = mod_vec[0];
        else
          lv_mod = mod_vec[lv_i];

        //  x-floor(x/y)*y
        // ret_val[lv_i] = in_vec[lv_i] % lv_mod;
        ret_val[lv_i] = in_vec[lv_i] - 
          ($floor(real'(in_vec[lv_i]) / lv_mod) * lv_mod);
      end



      return ret_val;

    endfunction : mod

    function MathLibVec::OUT_T MathLibVec::rem(INP_T in_vec, MOD_T rem_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int num_upk_dim_rem;
      int lv_num_vals;
      real lv_rem;
      real lv_real_num;
      real fix_val;

      num_upk_dim = $unpacked_dimensions (in_vec);
      num_upk_dim_rem = $unpacked_dimensions (rem_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];
      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        if (num_upk_dim_rem == 0)
          lv_rem = rem_vec[0];
        else
          lv_rem = rem_vec[lv_i];

        //  x-fix(x/y)*y
        fix_val = ((real'(in_vec[lv_i]) / lv_rem) < 0.0) ? 
          $ceil(real'(in_vec[lv_i]) / lv_rem) : 
          $floor(real'(in_vec[lv_i]) / lv_rem);

        ret_val[lv_i] = in_vec[lv_i] - (lv_rem * fix_val);
      end

      return ret_val;

    endfunction : rem


    function MathLibVec::OUT_T MathLibVec::abs (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = (in_vec[lv_i] < 0.0) ? 
          -in_vec[lv_i] : in_vec[lv_i];
      end
      return ret_val;
    endfunction : abs


    function MathLibVec::OUT_T MathLibVec::ceil (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = $ceil(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : ceil


    function MathLibVec::OUT_T MathLibVec::fix (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::fix(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : fix

    function MathLibVec::OUT_T MathLibVec::floor (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::floor(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : floor

    function ml_complex_vec_t MathLibVec::sqrt (INP_T in_vec);
      ml_complex_vec_t ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::sqrt(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : sqrt

    function MathLibVec::OUT_T MathLibVec::sign (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::sign(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : sign

    function MathLibVec::OUT_T MathLibVec::exp (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::exp(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : exp

    function MathLibVec::OUT_T MathLibVec::log (INP_T in_vec);
      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::log(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : log

    function MathLibVec::OUT_T MathLibVec::round(INP_T in_vec, 
      input int N=0, 
      input ml_round_tie_t tie = ML_TIE_NONE);

      OUT_T ret_val;
      int num_upk_dim;
      int lv_num_vals;

      num_upk_dim = $unpacked_dimensions (in_vec);

      a_vec_chk : assert (num_upk_dim == 1) else
        begin
          $fatal (2, "Wrong usage - MathLibVec used with non vector input");
        end;

      lv_num_vals = in_vec.size();
      ret_val = new[lv_num_vals];

      for (int lv_i=0; lv_i < lv_num_vals; lv_i++) begin
        ret_val[lv_i] = MathLib_pkg::round(in_vec[lv_i], N, tie);
      end

      return ret_val;
    endfunction : round

