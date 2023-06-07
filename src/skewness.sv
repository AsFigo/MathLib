module SkewnessExample;

  // Function to calculate the skewness
  function real calculateSkewness(input real data[$]);
    real mean, variance, skewness;
    int i;
    
    // Calculate the mean
    mean = 0;
    foreach (data[i]) begin
      mean += data[i];
    end
    mean /= data.size();
    
    // Calculate the variance
    variance = 0;
    foreach (data[i]) begin
      variance += (data[i] - mean) ** 2;
    end
    variance /= data.size();
    
    // Calculate the skewness
    skewness = 0;
    foreach (data[i]) begin
      skewness += ((data[i] - mean) ** 3) / (data.size() * variance ** (3/2));
    end
    
    return skewness;
  endfunction
  
  // Testbench
  initial begin
    real data[] = '{1, 2, 3, 4, 5, 6, 7, 8, 9};
    real skewness;
    
    // Calculate the skewness
    skewness = calculateSkewness(data);
    
    // Display the result
    $display("Skewness: %f", skewness);
  end
  
endmodule

