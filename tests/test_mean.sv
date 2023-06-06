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
  int_darr_1d_t  ida_1d;
  int_darr_2d_t  ida_2d;
  real_darr_1d_t  m_res_mean_of_2d, rda_1d, m_rda_1d;
  real_darr_2d_t  rda_2d, m_rda_2d;


  initial begin
    `ml_display ("Start")
    A_bus = $random();
    float_a = 2.2;
    ida_1d = new [4];
    foreach (ida_1d[id_x]) begin
      ida_1d[id_x] = $urandom();
    end
    ida_1d = '{1,-2.1,3,4.2};
    rda_1d = '{1,-2.1,3,4.2};

    m_rda_1d = MathLibVec #(int_darr_1d_t)::mean(ida_1d);
    `ml_printf (("ida_1d: \n%p \nmean: \n%p",
      ida_1d, m_rda_1d))
    m_rda_1d = MathLibVec #(real_darr_1d_t)::mean(rda_1d);
    `ml_printf (("REAL: \n%p \nmean: \n%p",
      rda_1d, m_rda_1d))

    ida_2d = new [4]; // [3];
    foreach (ida_2d[ii]) begin
      ida_2d[ii]= new [3];
    end
    ida_2d = '{'{1,1,1}, '{2,2,2}, '{3,3,3}, '{4,4,4}};
    // 0 1 1; 2 3 2; 1 3 2; 4 2 2]
    ida_2d = '{'{0,1,1}, '{2,3,2}, '{1,3,2}, '{4,2,2}};
    m_res_mean_of_2d = MathLibMat #(int_darr_2d_t)::mean(ida_2d);
    `ml_printf (("MAT COL Mean: \n%p \nmean: \n%p",
      ida_2d, m_res_mean_of_2d))
    ida_2d = '{'{0,1,1}, '{2,3,2}, '{3,0,1}, '{1,2,3}};
    // 0 1 1; 2 3 2; 3 0 1; 1 2 3
    m_res_mean_of_2d = MathLibMat #(int_darr_2d_t)::mean(ida_2d, ML_MEAN_ROW);
    `ml_printf (("MAT ROW Mean: \n%p \nmean: \n%p",
      ida_2d, m_res_mean_of_2d))
    m_res_mean_of_2d = MathLibMat #(int_darr_2d_t)::mean(ida_2d, ML_MEAN_ALL);
    `ml_printf (("MAT ALL Mean: \n%p \nmean: \n%p",
      ida_2d, m_res_mean_of_2d))

    `ml_display ("End")
    $finish(2);

  end
endmodule : top


