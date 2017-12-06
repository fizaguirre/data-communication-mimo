function [ x ] = zero_forcing( H, y )
    x = pinv(H)*y;
end

