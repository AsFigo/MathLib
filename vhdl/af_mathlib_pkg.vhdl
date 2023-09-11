-- --------------------------------------------------------------------
--
-- Copyright © 2023 by AsFigo Technologies, UK
-- All rights reserved.
--
--   Title     :  MathLib VHDL implementation
--             :
--   Library   :  This package shall be compiled into a library
--             :  symbolically named work.
--             :
--   Developers:  Srinivasan Venkataramanan, AsFigo
--             :
--   Purpose   :  This package defines a set of mathematical functions
--             :  These functions are intended to be compatible with MATLAB
--             :
-- --------------------------------------------------------------------
-- $Revision: #0.1 $
-- $Date: 2023-Aug-23 $
-- --------------------------------------------------------------------

library ieee;
use ieee.math_real.all;

package MathLib_pkg is

  function ROUND (X : in REAL; N : integer ) return REAL;
  function ceil (X : in REAL) return integer;
  function SIGN (in_val : in REAL) return integer;
  function abs_1 (in_val : in REAL) return real;


end package MathLib_pkg;
-- --------------------------------------------------------------------
-- $Revision: #0.1 $
-- $Date: 2023-Aug-23 $
-- --------------------------------------------------------------------
library ieee;
use ieee.math_real.all;

package body MathLib_pkg is

    function ROUND (X : in REAL; N : in integer ) return REAL is
        -- Description:
        --   ROUND function with number of digits as extra argument

      variable lv_tmp_val : real;
      variable lv_tmp_val_int : real;
      variable tie_val : real;

    begin
           if  N = 0 then
             lv_tmp_val := X;
           elsif  N < 0  then
             lv_tmp_val := X / real(10**(-N));
           else
             lv_tmp_val := X * real(10**(N));
           end if;

           lv_tmp_val_int := round(lv_tmp_val);


           if  N < 0  then
             tie_val := (lv_tmp_val_int * real(10**(-N)));
           else
             tie_val := lv_tmp_val_int / real(10**(N));
           end if;

      report "round lv_tmp_val: " & real'image(lv_tmp_val) &
        " lv_tmp_val_int: " & real'image(lv_tmp_val_int) &
        " tie_val: " & real'image(tie_val);


           return (tie_val);

    end function ROUND;

 function sign(in_val : in real) return integer is
    variable ret_val : integer;
  begin
    if in_val > 0.0 then
        ret_val := 1;
    elsif in_val = 0.0 then
        ret_val := 0;
    else
        ret_val := -1;
    end if;

    return ret_val;
 end function sign;

  function ceil(X : in REAL) return integer is
    variable result : integer;
    begin
     result := ceil(X);
   return result;
  end function ceil;

  function abs_1(in_val: in REAL) return real is
    variable ret_val : real;
     begin
      if in_val < 0.0 then
        ret_val := -in_val;
     else
        ret_val := in_val;
    end if;
    return ret_val;
  end function abs_1;

end package body MathLib_pkg;
