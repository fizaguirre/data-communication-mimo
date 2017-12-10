function [ x ] = zero_forcing( H, y )
    x = slice(pinv(H)*y);
end

