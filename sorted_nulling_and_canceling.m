function [ x_ ] = sorted_nulling_and_canceling( H, y )
    [cv, Hs] = sort_m(H);
    [Q, R] = qr(Hs);
    z = Q' * y;
    
    x_ = zeros(length(y), 1);
    
    for i = length(y):-1:1
        x_(i) = slice(z(i) / R(i,i));
        z = z - x_(i) * R(:,i);
    end
end

