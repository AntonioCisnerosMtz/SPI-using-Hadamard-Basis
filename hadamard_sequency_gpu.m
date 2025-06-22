function rHd = hadamard_sequency_gpu(N)
    
    HD = sylvester_hadamard_gpu(N);  
    

    num_changes = sum(abs(diff(HD, 1, 2)), 2) / 2;
    
  
    [~, idx] = sort(num_changes);
    rHd = HD(idx, :);  
end