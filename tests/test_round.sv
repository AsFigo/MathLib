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

    `ml_printf (("2.11 3.5; -3.5 0.78abs (5) : ", abs(5)))
    `ml_printf (("round (2.11) : ", round(2.11)))
    `ml_printf (("round (3.5) : ", round(3.5)))
    `ml_printf (("round (-3.5) : ", round(-3.5)))
    `ml_printf (("round (0.78) : ", round(0.78)))
    `ml_printf (("round (pi,3) : ", round(M_PI,3)))
    `ml_printf (("round (863178137,-2) : ", round(863178137,-2)))
    `ml_printf (("round (1253,2) : ", round(1253,2)))

    // TIE tests
    `ml_printf (("round:TIE_EVEN (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_EVEN))))
    `ml_printf (("round:TIE_EVEN (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_EVEN))))
    `ml_printf (("round:TIE_EVEN (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_EVEN))))
    `ml_printf (("round:TIE_EVEN (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_EVEN))))
    `ml_printf (("round:TIE_EVEN (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_EVEN))))
    `ml_printf (("round:TIE_EVEN (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_EVEN))))

    `ml_printf (("round:TIE_ODD (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_ODD))))
    `ml_printf (("round:TIE_ODD (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_ODD))))
    `ml_printf (("round:TIE_ODD (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_ODD))))
    `ml_printf (("round:TIE_ODD (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_ODD))))
    `ml_printf (("round:TIE_ODD (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_ODD))))
    `ml_printf (("round:TIE_ODD (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_ODD))))


    `ml_printf (("round:TIE_PLUSINF (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_PLUSINF))))
    `ml_printf (("round:TIE_PLUSINF (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_PLUSINF))))
    `ml_printf (("round:TIE_PLUSINF (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_PLUSINF))))
    `ml_printf (("round:TIE_PLUSINF (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_PLUSINF))))
    `ml_printf (("round:TIE_PLUSINF (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_PLUSINF))))
    `ml_printf (("round:TIE_PLUSINF (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_PLUSINF))))


    `ml_printf (("round:TIE_MINUSINF (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_MINUSINF))))
    `ml_printf (("round:TIE_MINUSINF (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_MINUSINF))))
    `ml_printf (("round:TIE_MINUSINF (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_MINUSINF))))
    `ml_printf (("round:TIE_MINUSINF (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_MINUSINF))))
    `ml_printf (("round:TIE_MINUSINF (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_MINUSINF))))
    `ml_printf (("round:TIE_MINUSINF (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_MINUSINF))))


    `ml_printf (("round:TIE_FROMZERO (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_FROMZERO))))
    `ml_printf (("round:TIE_FROMZERO (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_FROMZERO))))
    `ml_printf (("round:TIE_FROMZERO (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_FROMZERO))))
    `ml_printf (("round:TIE_FROMZERO (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_FROMZERO))))
    `ml_printf (("round:TIE_FROMZERO (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_FROMZERO))))
    `ml_printf (("round:TIE_FROMZERO (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_FROMZERO))))


    `ml_printf (("round:TIE_TOZERO (-2.5) : ", round(.inp_val(-2.5), .tie(ML_TIE_TOZERO))))
    `ml_printf (("round:TIE_TOZERO (-1.5) : ", round(.inp_val(-1.5), .tie(ML_TIE_TOZERO))))
    `ml_printf (("round:TIE_TOZERO (-0.5) : ", round(.inp_val(-0.5), .tie(ML_TIE_TOZERO))))
    `ml_printf (("round:TIE_TOZERO (0.5) : ", round(.inp_val(0.5), .tie(ML_TIE_TOZERO))))
    `ml_printf (("round:TIE_TOZERO (1.5) : ", round(.inp_val(1.5), .tie(ML_TIE_TOZERO))))
    `ml_printf (("round:TIE_TOZERO (2.5) : ", round(.inp_val(2.5), .tie(ML_TIE_TOZERO))))

    /*
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
      */

    `ml_display ("End")

    $finish(2);

  end
endmodule : top


