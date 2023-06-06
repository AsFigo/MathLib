`ifndef __AF_MATHLIB_PKG__
`define __AF_MATHLIB_PKG__

`define ml_display(MSG) \
  $display ("%0t %s", $time, MSG);

`define ml_printf(FORMATTED_MSG) \
  $display FORMATTED_MSG;

package MathLib_pkg;
  timeunit 1ns; timeprecision 1ns;

  `include "asfigo_MathLib_types.sv"
  `include "asfigo_MathLib_functions.sv"
  `include "asfigo_MathLibVec_proto.sv"
  `include "asfigo_MathLibVec_body.sv"
  `include "asfigo_MathLibMat_proto.sv"
  `include "asfigo_MathLibMat_body.sv"

endpackage : MathLib_pkg

`endif // __AF_MATHLIB_PKG__

