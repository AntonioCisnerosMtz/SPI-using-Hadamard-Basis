% function rHd = hadamard_sequency(N)
% % creates a Hadamard matrix ordered in a gray code permutation format
% % N is a number in power of 2^N
% % (r)2018, Roger Chiu, University of Guadalajara-CuLagos
% %% National Biophotonic Network, University of Guadalajara-INAOE
% % 2018/09/25
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % example usage
% % rHd = hadamard2graycode(4)
% % result  rHd =  
% %     1     1     1     1
% %     1     1    -1    -1
% %     1    -1    -1     1
% %     1    -1     1    -1
% 
% 
% HD = hadamard(N); %creates a Hadamard matrix
% rHd = zeros(N);
% for i = 1:N
%     p = 0; %permutation factor
%     p = sum(abs(diff(HD(:,i)')))/2;
%     rHd(:,p+1) =HD(:,i)';
% end
% end



function rHd = hadamard_sequency(N)
    HD = hadamard(N);
    % Calcular el número de cambios de signo por fila (vectorizado)
    num_changes = sum(abs(diff(HD, 1, 2)), 2) / 2;
    % Ordenar filas por secuencia ascendente
    [~, idx] = sort(num_changes);
    rHd = HD(idx, :);
end