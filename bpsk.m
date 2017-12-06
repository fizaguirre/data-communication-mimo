function [ data_out ] = bpsk( nb )
    % Modula em BPSK sem protadora uma portadora
    data_out = complex(2*randi([0 1], nb, 1)-1);
end

