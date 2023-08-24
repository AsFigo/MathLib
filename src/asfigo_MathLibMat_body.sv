    function MathLibMat::OUT_T MathLibMat::mean(INP_T in_val, 
      ml_mean_dim_t dim = ML_MEAN_COL);

      OUT_T mean_ret_val;
      int  lv_sum;
      int  lv_num_vals;
      int  num_rows;
      int  num_cols;
      int num_upk_dim;
      int s;

      num_upk_dim = $unpacked_dimensions (in_val);
      a_mat_chk : assert (num_upk_dim == 2) else
        begin
          $fatal (2, "Wrong usage - MathLibMat used with non matrix input");
        end;


      if (num_upk_dim == 2) begin : ml_matrix
        num_rows = in_val.size();
        num_cols = in_val[0].size();
        /*
        `ml_printf (("dim: %s num_rows: %0d num_cols: %0d", 
          dim.name(), num_rows, num_cols))
        */

        case (dim)
          ML_MEAN_COL : begin : mean_of_cols 
            mean_ret_val = new [num_cols];
            foreach (mean_ret_val[col_i]) begin
              mean_ret_val [col_i] = 0.0;
              lv_sum = 0.0;
              foreach (in_val[row_i]) begin
                lv_sum += in_val[row_i][col_i];
              end
              mean_ret_val[col_i] = lv_sum / num_rows;
            end
          end : mean_of_cols

          ML_MEAN_ROW : begin : mean_of_rows 
            mean_ret_val = new [num_rows];
            foreach (mean_ret_val[row_i]) begin
              mean_ret_val [row_i] = 0.0;
              lv_sum = 0.0;
              for (int lv_col_i=0; lv_col_i < num_cols; lv_col_i++) begin
                lv_sum += in_val[row_i][lv_col_i];
              end
              mean_ret_val[row_i] = lv_sum / num_cols;
            end
          end : mean_of_rows
          ML_MEAN_ALL : begin 
            mean_ret_val = new [1];
            lv_sum = 0.0;
            foreach (in_val[lv_row_i, lv_col_i]) begin
              lv_sum += in_val[lv_row_i][lv_col_i];
            end
            mean_ret_val[0] = lv_sum / (num_rows * num_cols);
          end
        endcase
      end : ml_matrix

	s = mean_ret_val.size();
      for (int i=0; i < s; i++) begin
        mean_ret_val[i] = MathLib_pkg::round(mean_ret_val[i],4);
      end

      return mean_ret_val;

    endfunction : mean
