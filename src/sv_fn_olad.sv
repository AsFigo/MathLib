package p;
  timeunit 1ns; timeprecision 1ns;

  typedef real ml_vec_t[];
  typedef real ml_matrix_t[][];
  typedef real ml_mda_t[][][];
  typedef enum bit [1:0] {
    ML_MEAN_ROW, ML_MEAN_COL, ML_MEAN_ALL} ml_mean_dim_t;


  class MathLibVec #(
      type INP_T = ml_vec_t,
      type OUT_T = ml_vec_t,
      type MOD_T = ml_vec_t
  );

    static function OUT_T mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

      OUT_T rval;
      int num_upk_dim;
      int num_rows;
      int num_cols;

      num_upk_dim = $unpacked_dimensions (in_val);

      if (num_upk_dim == 2) begin : ml_matrix
        num_rows = in_val.size();
        num_cols = in_val[0].size();
        rval = new [num_cols];
      end : ml_matrix


      return rval;
    endfunction : mean
  endclass

endpackage : p

module m;
  import p::*;

  typedef int int_darr_1d_t [];
  typedef int int_darr_2d_t [] [];
  int_darr_1d_t  ida_1d;
  int_darr_2d_t  ida_2d;
  ml_vec_t m_rda_1d;

  initial begin
    ida_1d = '{1,-2.1,3,4.2};
    m_rda_1d = MathLibVec #(int_darr_1d_t)::mean(ida_1d);
    #10 $finish (2);
  end
endmodule : m
