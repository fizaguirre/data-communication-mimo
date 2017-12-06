function [ x_ ] = nulling_and_canceling( H, y )
    [Q, R] = qr(H);
    z = Q' * y;
    
    x_ = zeros(length(y), 1);
    
    for i = length(y):-1:1
        x_(i) = slice(z(i) / R(i,i));
        z = z - x_(i) * R(:,i);
    end
end