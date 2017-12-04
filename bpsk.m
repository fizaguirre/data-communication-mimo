function [ data_out ] = bpsk( operation,  input_data )
    % Modula em BPSK sem protadora uma portadora

    bToPh = containers.Map({0, 1},  [0, pi]);
    phTob = containers.Map({0, pi},  [0, 1]);
    
    data_out = 0 * input_data;
    
    if strcmp(operation, 'encode')
        for i = 1:length(input_data)
            data_out(i) = bToPh(input_data(i, 1));
        end
    end
    
    if strcmp(operation, 'decode')
        for i = 1:length(input_data)
            data_out(i) = phTob(input_data(i, 1));
        end
    end
end

