`timescale 1ns/1ns

import MathLib_pkg::*;
typedef int int_darr_1d_t [];
typedef int int_darr_2d_t [] [];
typedef real real_darr_1d_t [];
typedef real real_darr_2d_t [] [];

module top;
  int_darr_1d_t  ida_1d, res_ida_1d;
  int_darr_1d_t  rem_1d;
  ml_vec_t rda_1d;
  ml_vec_t rem_rda_1d;
  ml_vec_t res_rda_1d;

  initial begin
    `ml_display ("Start")

    `ml_printf (("abs (5) : ", abs(5)))
    `ml_printf (("abs (-5) : ", abs(-5)))


    rda_1d = '{1.3, -3.56, 8.23, -5, -0.01};

    res_rda_1d = MathLibVec #(.INP_T(ml_vec_t))::abs
        (rda_1d);

    `ml_printf (("rda_1d: \n%p \nres: \n%p",
      rda_1d, res_rda_1d))

    ida_1d = '{1, -3, 8, -5, 0};
    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t))::abs(ida_1d);

    `ml_printf (("ida_1d: \n%p \nres: \n%p",
      ida_1d, res_ida_1d))
    `ml_display ("End")

    $finish(2);

  end
endmodule : top


