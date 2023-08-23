  // Verilog's mod % operator 
  // is TRUNCATED vs MATLAB is FLOORED
  // https://en.wikipedia.org/wiki/Modulo#In_programming_languages
  function real mod (input real x, y);
    real ret_val;
    //  x-floor(x/y)*y
    ret_val = x - ( $floor (real'(x)/y) * y);
    return ret_val;
  endfunction : mod 

  // Reminder

  function real rem(input real dividend, input real divisor);
    real f_val;
    real reminder;
    f_val = ((dividend / divisor) < 0.0) ? 
      $ceil(dividend / divisor) : 
      $floor(dividend / divisor);

    reminder = dividend - (divisor * f_val);
    return reminder;
  endfunction : rem

  function real abs(input real in_val);
    real ret_val;
    ret_val = (in_val < 0.0) ? -in_val : in_val;
    return ret_val;
  endfunction : abs



  // ceil 

  function int ceil(input real x);
    int result;
    result = $ceil(x);
    return result;
  endfunction : ceil

  // fix 

  function int fix(input real x);
    int ret_val;
    if (x > 0) begin
      ret_val = $floor(x);
    end else begin
      ret_val = $ceil(x);
    end
    return ret_val;
  endfunction : fix

  function real floor (input real x);
    real ret_val;
    ret_val = $floor (real'(x));
    return ret_val;
  endfunction : floor 


  function ml_complex_t sqrt(real in_val);
    ml_complex_t ret_val;
    if (in_val >= 0.0) begin
      ret_val.r = $sqrt(in_val);
      ret_val.i = 0;
    end else begin
      ret_val.r = 0;
      ret_val.i = $sqrt( (-1.0 * in_val));
    end
    return ret_val;
  endfunction : sqrt


  /* MATLAB equivalent sign function
   Y = sign(x) returns
   1 if x is greater than 0.
   0 if x is  == 0
    -1 if x < 0
     */


  function int sign(input real in_val);
    int ret_val;
    ret_val = (in_val > 0.0) ? 1 : (in_val == 0.0) ? 0 : -1;

    return ret_val;

  endfunction : sign

  //exponential

  function real exp(input real nu);
    real result;
    real tmp_res;
    tmp_res = M_E ** nu;
    // Matlab has default rounding to 4 places after decimal
    // TBD - add support for "long"
    result = round (tmp_res, 4);
    return result;
  endfunction : exp



  // log - log 10

  function real log(input real in_val);
    real ret_val;
    ret_val = (in_val < 0.0) ? 0 : $log10 (in_val);
    return ret_val;
  endfunction : log


  /* AMS - rounding function
    Case positive:
      if fraction >= 0.5 ---> round return the "integer part" + 1 (for example 4.5 --->5)
      if fraction < 0.5 ---> round return the "integer part" (for example 4.2 --->4)

    Case negative:
      if fraction >= 0.5 ---> round return the "integer part" -1 (for example -4.5 --->-5)
      if fraction < 0.5 ---> round return the "integer part" (for example -4.2 ---> -4)
  */

  // Round 

  // MATLAB option "significant" NYI
  //
  function real round(input real inp_val, input int N=0, 
    input ml_round_tie_t tie = ML_TIE_NONE);
    real ret_val;
    real tie_val;
    real lv_tmp_val;
    real lv_tmp_val_int;

    if (N == 0) begin
      tie_val = int'(inp_val);
    end else begin
      if (N < 0) begin
        lv_tmp_val = real'(inp_val) / real'(10**(-N));
      end else begin
        lv_tmp_val = real'(inp_val) * real'(10**N);
      end
      /*
      $display ("inp_val: %f lv_tmp_val: %f N: %0d 10**N: %f", 
        inp_val, lv_tmp_val, N, real'(10**N));*/
      lv_tmp_val_int = int'(lv_tmp_val);

      if (N < 0) begin
        tie_val = real'( lv_tmp_val_int * (10**(-N)) );
      end else begin
        tie_val = real'( lv_tmp_val_int/ (10**N) );
      end
    end

    if (tie == ML_TIE_NONE) begin
      ret_val = tie_val;
    end else begin
      if (is_it_a_tie (inp_val)) begin
        ret_val = do_tie (inp_val, tie);
      end
      else begin
        ret_val = tie_val;
      end
    end
    return ret_val;
  endfunction : round

  function bit is_it_a_tie (input real inp_val);
    bit ret_val;
    int lv_tie_tmp_int;
    real lv_tie_fraction;

    lv_tie_tmp_int = int'(inp_val);
    lv_tie_fraction = abs(real '(inp_val) - real'(lv_tie_tmp_int));
    ret_val = (lv_tie_fraction == 0.5);
    // $display ("in: %f TIE: %b", inp_val, ret_val);
    return ret_val;
  endfunction : is_it_a_tie 

  function int do_tie (input real inp_to_be_tied, 
     input ml_round_tie_t tie = ML_TIE_NONE);

   int ret_val;
   int inp_int_trunc;
   real inp_plus_tie_val;
   real inp_minus_tie_val;
   int tie_res_even;
   int tie_res_odd;
   real tie_res_plusinf;
   real tie_res_minusinf;
   real tie_res_fromzero;
   real tie_res_tozero;

    ret_val = inp_to_be_tied;
    inp_int_trunc = truncate (inp_to_be_tied);
    tie_res_plusinf = real'(inp_to_be_tied) + 0.5;
    tie_res_minusinf = real'(inp_to_be_tied) - 0.5;

    tie_res_fromzero = (inp_to_be_tied > 0) ? 
      real'(inp_to_be_tied) + 0.5 :
      real'(inp_to_be_tied) - 0.5;

    tie_res_tozero = (inp_to_be_tied > 0) ? 
      real'(inp_to_be_tied) - 0.5 :
      real'(inp_to_be_tied) + 0.5;

    if (inp_to_be_tied > 0) begin : handle_pos

      inp_plus_tie_val = real'(inp_to_be_tied) + 0.5;

      if ( (int'(inp_plus_tie_val) % 2) == 0) begin
        tie_res_even = inp_plus_tie_val;
        tie_res_odd = inp_plus_tie_val - 1;
      end else begin
        tie_res_even = inp_plus_tie_val - 1;
        tie_res_odd = inp_plus_tie_val;
      end
    end : handle_pos
    else begin : handle_neg
      inp_minus_tie_val = real'(inp_to_be_tied) - 0.5;

      if ( (int'(inp_minus_tie_val) % 2) == 0) begin
        tie_res_even = inp_minus_tie_val;
        tie_res_odd = inp_minus_tie_val + 1;
      end else begin
        tie_res_even = inp_minus_tie_val + 1;
        tie_res_odd = inp_minus_tie_val;
      end
     end : handle_neg

    `ifdef DBG
    $display ("TIE: in: %f inp_int_trunc: %0d", 
      inp_to_be_tied, inp_int_trunc);
    `endif // DBG
    case (tie)
      ML_TIE_NONE     : ret_val = inp_to_be_tied;
      ML_TIE_EVEN     : ret_val = tie_res_even;
      ML_TIE_ODD      : ret_val = tie_res_odd;
      ML_TIE_PLUSINF  : ret_val = tie_res_plusinf;
      ML_TIE_MINUSINF : ret_val = tie_res_minusinf;
      ML_TIE_FROMZERO : ret_val = tie_res_fromzero;
      ML_TIE_TOZERO   : ret_val = tie_res_tozero;
    endcase

    return ret_val;
  endfunction : do_tie 

  // No truncate in Matalb??
  function int truncate(input real inp_val);
    int ret_val;
    ret_val = $rtoi(inp_val);
    return ret_val;
  endfunction : truncate

  // sum for array of integers

  function real sum(input int array[]);
    int i;
    static real result = 0;
    for (i = 0; i < array.size(); i = i + 1) result = result + array[i];
    return result;
  endfunction : sum

