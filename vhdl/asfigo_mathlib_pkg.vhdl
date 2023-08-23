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
  -- Purpose:
  --         Rounds X to the nearest integer value (as real). If X is
  --         halfway between two integers, rounding is away from 0.0
  -- Special values:
  --         ROUND(0.0) = 0.0
  -- Domain:
  --         X in REAL
  -- Error conditions:
  --         None
  -- Range:
  --         ROUND(X) is mathematically unbounded
  -- Notes:
  --         a) Implementations have to support at least the domain
  --                ABS(X) < REAL(INTEGER'HIGH)

  -- function EXP (X : in REAL) return REAL;
  -- Purpose:
  --         Returns e**X; where e = MATH_E
  -- Special values:
  --         EXP(0.0) = 1.0
  --         EXP(1.0) = MATH_E
  --         EXP(-1.0) = MATH_1_OVER_E
  --         EXP(X) = 0.0 for X <= -LOG(REAL'HIGH)
  -- Domain:
  --         X in REAL such that EXP(X) <= REAL'HIGH
  -- Error conditions:
  --         Error if X > LOG(REAL'HIGH)
  -- Range:
  --         EXP(X) >= 0.0
  -- Notes:
  --         a) The usable domain of EXP is approximately given by:
  --                X <= LOG(REAL'HIGH)

end package MathLib_pkg;

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

    -- function EXP  (X : in REAL ) return REAL is
        -- Description:
        --        See function declaration in IEEE Std 1076.2-1996
        -- Notes:
        --        a) This function computes the exponential using the following
        --           series:
        --                exp(x) = 1 + x + x**2/2! + x**3/3! + ... ; |x| < 1.0
        --           and reduces argument X to take advantage of exp(x+y) =
        --           exp(x)*exp(y)
        --
        --        b) This implementation limits X to be less than LOG(REAL'HIGH)
        --           to avoid overflow.  Returns REAL'HIGH when X reaches that
        --           limit
        --
--        constant EPS : REAL := BASE_EPS*BASE_EPS*BASE_EPS;-- Precision criteria
--
--            variable RECIPROCAL: BOOLEAN := X < 0.0;-- Check sign of argument
--            variable XLOCAL : REAL := ABS(X);       -- Use positive value
--            variable OLDVAL: REAL ;
--            variable COUNT: INTEGER ;
--            variable NEWVAL: REAL ;
--            variable LAST_TERM: REAL ;
--        variable FACTOR : REAL := 1.0;
--
--     begin
--            -- Compute value for special cases
--        if X = 0.0 then
--                return 1.0;
--        end if;
--
--        if  XLOCAL = 1.0  then
--                if RECIPROCAL then
--                        return MATH_1_OVER_E;
--                else
--                        return MATH_E;
--                end if;
--        end if;
--
--        if  XLOCAL = 2.0  then
--                if RECIPROCAL then
--                        return 1.0/MATH_E_P2;
--                else
--                        return MATH_E_P2;
--                end if;
--        end if;
--
--        if  XLOCAL = 10.0  then
--                if RECIPROCAL then
--                        return 1.0/MATH_E_P10;
--                else
--                        return MATH_E_P10;
--                end if;
--        end if;
--
--        if XLOCAL > LOG(REAL'HIGH) then
--                if RECIPROCAL then
--                        return 0.0;
--                else
--                        assert FALSE
--                                report "X > LOG(REAL'HIGH) in EXP(X)"
--                                severity NOTE;
--                        return REAL'HIGH;
--                end if;
--        end if;
--
--        -- Reduce argument to ABS(X) < 1.0
--        while XLOCAL > 10.0 loop
--                XLOCAL := XLOCAL - 10.0;
--                FACTOR := FACTOR*MATH_E_P10;
--        end loop;
--
--        while XLOCAL > 1.0 loop
--                XLOCAL := XLOCAL - 1.0;
--                FACTOR := FACTOR*MATH_E;
--        end loop;
--
--        -- Compute value for case 0 < XLOCAL < 1
--        OLDVAL := 1.0;
--        LAST_TERM := XLOCAL;
--        NEWVAL:= OLDVAL + LAST_TERM;
--        COUNT := 2;
--
--        -- Check for relative and absolute errors and max count
--        while ( ( (ABS((NEWVAL - OLDVAL)/NEWVAL) > EPS) OR
--                  (ABS(NEWVAL - OLDVAL) > EPS) ) AND
--                  (COUNT < MAX_COUNT ) ) loop
--                OLDVAL := NEWVAL;
--                LAST_TERM := LAST_TERM*(XLOCAL / (REAL(COUNT)));
--                NEWVAL := OLDVAL + LAST_TERM;
--                COUNT := COUNT + 1;
--        end loop;
--
--        -- Compute final value using exp(x+y) = exp(x)*exp(y)
--        NEWVAL := NEWVAL*FACTOR;
--
--        if RECIPROCAL then
--                NEWVAL := 1.0/NEWVAL;
--        end if;
--
--        return NEWVAL;
--     end function EXP;

end package body MathLib_pkg;

