
library ieee;
use ieee.std_logic_1164.all;
 
entity e is
end entity e;
 
architecture rtl of e is
 
begin

  process is
  begin
    report "  9  mod   5  = " & integer'image(9 mod 5);
    report "  9  rem   5  = " & integer'image(9 rem 5);
    report "  9  mod (-5) = " & integer'image(9 mod (-5));
    report "  9  rem (-5) = " & integer'image(9 rem (-5));
    report "(-9) mod   5  = " & integer'image((-9) mod 5);
    report "(-9) rem   5  = " & integer'image((-9) rem 5);
    report "(-9) mod (-5) = " & integer'image((-9) mod (-5));
    report "(-9) rem (-5) = " & integer'image((-9) rem (-5));
    report "(-4) mod   3  = " & integer'image((-4) mod 3);
    wait;
  end process;

end architecture rtl;

