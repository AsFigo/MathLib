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

    `ml_printf (("log (5) : ", log(5)))
    `ml_printf (("log (-5) : ", log(-5)))
    `ml_printf (("log (10.1) : ", log(10.1)))
    `ml_printf (("log (-10.1) : ", log(-10.1)))


    `ml_display ("End")

    $finish(2);

  end
endmodule : top


