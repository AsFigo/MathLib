
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ALL;
use work.MathLib_pkg.ALL;

entity test is
end entity test;

architecture behavior of test is


begin
    process
      variable tmp_r : real;
    begin
      tmp_r := 1.2;

      report "tmp_r: " & real'image(tmp_r);
      report "tmp_r + 0.5: " & real'image(tmp_r + 0.5);
      report "floor: tmp_r + 0.5: " & real'image(floor(tmp_r + 0.5));

      report "round 1.2: " & real'image(ROUND(1.2));
      report "round 1.6: " & real'image(ROUND(1.6));
      report "round 1.6128: " & real'image(ROUND(1.6128));
      report "round 1.6128, 2: " & real'image(ROUND(1.6128, 2));
      report "round 1.6128, 3: " & real'image(ROUND(1.6128, 3));
      report "round 1.6128, 4: " & real'image(ROUND(1.6128, 4));
      report "round 1612.8, -2: " & real'image(ROUND(1612.8, -2));
      report "round 1612.8, -3: " & real'image(ROUND(1612.8, -3));
      report "round 1612.8, -4: " & real'image(ROUND(1612.8, -4));
      wait;
    end process;
end architecture behavior;
