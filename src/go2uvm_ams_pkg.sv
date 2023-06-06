`ifndef GO2UVM_AMS_PKG
`define GO2UVM_AMS_PKG

`define g2u_display(MSG) \
  $display ("%0t %s", $time, MSG);

`define g2u_printf(FORMATTED_MSG) \
  $display FORMATTED_MSG;

package go2uvm_ams_pkg;
  timeunit 1ns; timeprecision 1ns;

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

  // Verilog's mod % operator 
  // is TRUNCATED vs MATLAB is FLOORED
  // https://en.wikipedia.org/wiki/Modulo#In_programming_languages
  function real mod (input real x, y);
    real ret_val;
    //  x-floor(x/y)*y
    ret_val = x - ( $floor (real'(x)/y) * y);
    return ret_val;
  endfunction : mod 

  // Reminder

  function real rem(input real dividend, input real divisor);
    real f_val;
    real reminder;
    f_val = ((dividend / divisor) < 0.0) ? 
      $ceil(dividend / divisor) : 
      $floor(dividend / divisor);

    reminder = dividend - (divisor * f_val);
    return reminder;
  endfunction : rem

  /* AMS - rounding function
    Case positive:
      if fraction >= 0.5 ---> round return the "integer part" + 1 (for example 4.5 --->5)
      if fraction < 0.5 ---> round return the "integer part" (for example 4.2 --->4)

    Case negative:
      if fraction >= 0.5 ---> round return the "integer part" -1 (for example -4.5 --->-5)
      if fraction < 0.5 ---> round return the "integer part" (for example -4.2 ---> -4)
  */

  // Round 

  // MATLAB option "significant" NYI
  //
  function real round(input real inp_val, input int N=0, 
    input ml_round_tie_t tie = ML_TIE_NONE);
    real ret_val;
    real tie_val;
    real lv_tmp_val;
    real lv_tmp_val_int;

    if (N == 0) begin
      tie_val = int'(inp_val);
    end else begin
      if (N < 0) begin
        lv_tmp_val = real'(inp_val) / real'(10**(-N));
      end else begin
        lv_tmp_val = real'(inp_val) * real'(10**N);
      end
      /*
      $display ("inp_val: %f lv_tmp_val: %f N: %0d 10**N: %f", 
        inp_val, lv_tmp_val, N, real'(10**N));*/
      lv_tmp_val_int = int'(lv_tmp_val);

      if (N < 0) begin
        tie_val = real'( lv_tmp_val_int * (10**(-N)) );
      end else begin
        tie_val = real'( lv_tmp_val_int/ (10**N) );
      end
    end

    if (tie == ML_TIE_NONE) begin
      ret_val = tie_val;
    end else begin
      if (is_it_a_tie (inp_val)) begin
        ret_val = do_tie (inp_val, tie);
      end
      else begin
        ret_val = tie_val;
      end
    end
    return ret_val;
  endfunction : round

  function bit is_it_a_tie (input real inp_val);
    bit ret_val;
    int lv_tie_tmp_int;
    real lv_tie_fraction;

    lv_tie_tmp_int = int'(inp_val);
    lv_tie_fraction = abs(real '(inp_val) - real'(lv_tie_tmp_int));
    ret_val = (lv_tie_fraction == 0.5);
    // $display ("in: %f TIE: %b", inp_val, ret_val);
    return ret_val;
  endfunction : is_it_a_tie 

  function int do_tie (input real inp_to_be_tied, 
     input ml_round_tie_t tie = ML_TIE_NONE);

   int ret_val;
   int inp_int_trunc;
   real inp_plus_tie_val;
   real inp_minus_tie_val;
   int tie_res_even;
   int tie_res_odd;
   real tie_res_plusinf;
   real tie_res_minusinf;
   real tie_res_fromzero;
   real tie_res_tozero;

    ret_val = inp_to_be_tied;
    inp_int_trunc = truncate (inp_to_be_tied);
    tie_res_plusinf = real'(inp_to_be_tied) + 0.5;
    tie_res_minusinf = real'(inp_to_be_tied) - 0.5;

    tie_res_fromzero = (inp_to_be_tied > 0) ? 
      real'(inp_to_be_tied) + 0.5 :
      real'(inp_to_be_tied) - 0.5;

    tie_res_tozero = (inp_to_be_tied > 0) ? 
      real'(inp_to_be_tied) - 0.5 :
      real'(inp_to_be_tied) + 0.5;

    if (inp_to_be_tied > 0) begin : handle_pos

      inp_plus_tie_val = real'(inp_to_be_tied) + 0.5;

      if ( (int'(inp_plus_tie_val) % 2) == 0) begin
        tie_res_even = inp_plus_tie_val;
        tie_res_odd = inp_plus_tie_val - 1;
      end else begin
        tie_res_even = inp_plus_tie_val - 1;
        tie_res_odd = inp_plus_tie_val;
      end
    end : handle_pos
    else begin : handle_neg
      inp_minus_tie_val = real'(inp_to_be_tied) - 0.5;

      if ( (int'(inp_minus_tie_val) % 2) == 0) begin
        tie_res_even = inp_minus_tie_val;
        tie_res_odd = inp_minus_tie_val + 1;
      end else begin
        tie_res_even = inp_minus_tie_val + 1;
        tie_res_odd = inp_minus_tie_val;
      end
     end : handle_neg

    `ifdef DBG
    $display ("TIE: in: %f inp_int_trunc: %0d", 
      inp_to_be_tied, inp_int_trunc);
    `endif // DBG
    case (tie)
      ML_TIE_NONE     : ret_val = inp_to_be_tied;
      ML_TIE_EVEN     : ret_val = tie_res_even;
      ML_TIE_ODD      : ret_val = tie_res_odd;
      ML_TIE_PLUSINF  : ret_val = tie_res_plusinf;
      ML_TIE_MINUSINF : ret_val = tie_res_minusinf;
      ML_TIE_FROMZERO : ret_val = tie_res_fromzero;
      ML_TIE_TOZERO   : ret_val = tie_res_tozero;
    endcase

    return ret_val;
  endfunction : do_tie 

  function int truncate(input real inp_val);
    int ret_val;
    ret_val = $rtoi(inp_val);
    return ret_val;
  endfunction : truncate

  // ceil 

  function int ceil(input real x);
    int result;
    result = $ceil(x);
    return result;
  endfunction : ceil

  // fix 

  function int fix(input real x);
    int ret_val;
    if (x > 0) begin
      ret_val = $floor(x);
    end else begin
      ret_val = $ceil(x);
    end
    return ret_val;
  endfunction : fix

  function real floor (input real x);
    real ret_val;
    ret_val = $floor (real'(x));
    return ret_val;
  endfunction : floor 


  // sum for array of integers

  function real sum(input int array[]);
    int i;
    static real result = 0;
    for (i = 0; i < array.size(); i = i + 1) result = result + array[i];
    return result;
  endfunction : sum



  //exponential

  function real exp(input real nu);
    real result;
    result = M_E ** nu;
    return result;
  endfunction : exp


  // sqrt

  function real sqrt(real num);
    real ret_val;
    ret_val = $sqrt(num);
    return ret_val;
  endfunction : sqrt


  /* MATLAB equivalent sign function
   Y = sign(x) returns
   1 if x is greater than 0.
   0 if x is  == 0
    -1 if x < 0
     */


  function int sign(input real in_val);
    int ret_val;
    ret_val = (in_val > 0.0) ? 1 : (in_val == 0.0) ? 0 : -1;

    return ret_val;

  endfunction : sign

  function real abs(input real in_val);
    real ret_val;
    ret_val = (in_val < 0.0) ? -in_val : in_val;
    return ret_val;
  endfunction : abs





  class MathLibVec #(
      type INP_T = ml_vec_t,
      type OUT_T = ml_vec_t,
      type MOD_T = ml_vec_t
  );

    static function OUT_T mean(INP_T in_val, 
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

    static function OUT_T mod(INP_T in_vec, MOD_T mod_vec);
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

    static function OUT_T rem(INP_T in_vec, MOD_T rem_vec);
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


    static function OUT_T abs (INP_T in_vec);
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


    static function OUT_T ceil (INP_T in_vec);
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


    static function OUT_T fix (INP_T in_vec);
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
        ret_val[lv_i] = go2uvm_ams_pkg::fix(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : fix

    static function OUT_T floor (INP_T in_vec);
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
        ret_val[lv_i] = go2uvm_ams_pkg::floor(in_vec[lv_i]);
      end
      return ret_val;
    endfunction : floor

  endclass : MathLibVec

  class MathLibMat #(
      type INP_T = ml_matrix_t,
      type OUT_T = ml_vec_t
  );


    static function OUT_T mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

      OUT_T ret_val;
      int  lv_sum;
      int  lv_num_vals;
      int  num_rows;
      int  num_cols;
      int num_upk_dim;

      num_upk_dim = $unpacked_dimensions (in_val);
      a_mat_chk : assert (num_upk_dim == 2) else
        begin
          $fatal (2, "Wrong usage - MathLibMat used with non matrix input");
        end;


      if (num_upk_dim == 2) begin : ml_matrix
        num_rows = in_val.size();
        num_cols = in_val[0].size();
        /*
        `g2u_printf (("dim: %s num_rows: %0d num_cols: %0d", 
          dim.name(), num_rows, num_cols))
        */

        case (dim)
          ML_MEAN_COL : begin : mean_of_cols 
            ret_val = new [num_cols];
            foreach (ret_val[col_i]) begin
              ret_val [col_i] = 0.0;
              lv_sum = 0.0;
              foreach (in_val[row_i]) begin
                lv_sum += in_val[row_i][col_i];
              end
              ret_val[col_i] = lv_sum / num_rows;
            end
          end : mean_of_cols

          ML_MEAN_ROW : begin : mean_of_rows 
            ret_val = new [num_rows];
            foreach (ret_val[row_i]) begin
              ret_val [row_i] = 0.0;
              lv_sum = 0.0;
              for (int lv_col_i=0; lv_col_i < num_cols; lv_col_i++) begin
                lv_sum += in_val[row_i][lv_col_i];
              end
              ret_val[row_i] = lv_sum / num_cols;
            end
          end : mean_of_rows
          ML_MEAN_ALL : begin 
            ret_val = new [1];
            lv_sum = 0.0;
            foreach (in_val[lv_row_i, lv_col_i]) begin
              lv_sum += in_val[lv_row_i][lv_col_i];
            end
            ret_val[0] = lv_sum / (num_rows * num_cols);
          end
        endcase


      end : ml_matrix

      return ret_val;

    endfunction : mean

  endclass : MathLibMat

endpackage : go2uvm_ams_pkg

`endif  // GO2UVM_AMS_PKG

