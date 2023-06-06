`timescale 1ns/1ns

import MathLib_pkg::*;
typedef int int_darr_1d_t [];
typedef int int_darr_2d_t [] [];
typedef real real_darr_1d_t [];
typedef real real_darr_2d_t [] [];

module top;
  bit [12:0] A_bus, B_bus;
  real float_a;
  parameter type T=int;
  int_darr_1d_t  ida_1d, res_ida_1d;
  int_darr_1d_t  mod_1d;
  ml_vec_t rda_1d;
  ml_vec_t mod_rda_1d;
  ml_vec_t res_rda_1d;

  initial begin
    `ml_display ("Start")

    ida_1d = '{1,2, 3, 4, 5, 6, 7, 8, 9};

    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t), .MOD_T(int))::mod(ida_1d, 3);

    `ml_printf (("ida_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      ida_1d, 3, res_ida_1d))

    mod_1d = '{1,2, 3, 4, 5, 6, 7, 8, 9};
    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t), .MOD_T(int_darr_1d_t))::mod(ida_1d, mod_1d);

    `ml_printf (("ida_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      ida_1d, mod_1d, res_ida_1d))

    mod_1d = '{2, 3, 4, 5, 6, 7, 8, 9, 10};
    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t), .MOD_T(int_darr_1d_t))::mod(ida_1d, mod_1d);

    `ml_printf (("ida_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      ida_1d, mod_1d, res_ida_1d))

    // Remainder After Division for Positive and Negative Values
    ida_1d = '{-4, -1, 7, 9};
    mod_1d = '{3, 3, 3, 3};

    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t), .MOD_T(int_darr_1d_t))::mod(ida_1d, mod_1d);

    `ml_printf (("ida_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      ida_1d, mod_1d, res_ida_1d))

    ida_1d = '{-4, -1, 7, 9};
    mod_1d = '{-3, -3, -3, -3};

    res_ida_1d = MathLibVec #(.INP_T(int_darr_1d_t),
      .OUT_T(int_darr_1d_t), .MOD_T(int_darr_1d_t))::mod(ida_1d, mod_1d);

    `ml_printf (("ida_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      ida_1d, mod_1d, res_ida_1d))

    // Remainder After Division for Floating-Point Values
    //
    rda_1d = '{0.0, 3.5, 5.9, 6.2, 9.0, 4*M_PI};
    mod_rda_1d = '{6{2*M_PI}};
    res_rda_1d = MathLibVec#()::mod(rda_1d, mod_rda_1d);

    `ml_printf (("rda_1d: \n%p \nmod_vec: \n%p\nres: \n%p",
      rda_1d, mod_rda_1d, res_rda_1d))
    `ml_display ("End")

    $finish(2);

  end
endmodule : top


