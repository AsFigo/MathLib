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
  ml_complex_t res_sqrt;
  ml_complex_vec_t res_sqrt_vec;

  initial begin
    `ml_display ("Start")


    res_sqrt = sqrt (3);
    `ml_printf (("sqrt (3): %p ", res_sqrt))

    res_sqrt = sqrt (1.3);
    `ml_printf (("sqrt (1.3): %p ", res_sqrt))

    res_sqrt = sqrt (-1.3);
    `ml_printf (("sqrt (-1.3): %p ", res_sqrt))

    rda_1d = '{1.3, -3.56, 8.23, -5, -0.01};

    res_sqrt_vec = MathLibVec #(.INP_T(ml_vec_t))::sqrt
        (rda_1d);
    `ml_printf (("rda_1d: \n%p \nres: \n%p",
      rda_1d, res_sqrt_vec))

    rda_1d = '{-2.0, -1.0, 0, 1.0, 2.0};
    res_sqrt_vec = MathLibVec #(.INP_T(ml_vec_t))::sqrt
        (rda_1d);
    `ml_printf (("rda_1d: \n%p \nres: \n%p",
      rda_1d, res_sqrt_vec))


    `ml_display ("End")

    $finish(2);

  end
endmodule : top


