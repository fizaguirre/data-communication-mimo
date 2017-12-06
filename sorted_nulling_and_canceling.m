function [ x_ ] = sorted_nulling_and_canceling( H, y )
    %ordena a matrix H em modulo
    [cv, Hs] = sort_m(H);
    [Q, R] = qr(Hs);
    z = Q' * y;
    
    x_ = zeros(length(y), 1);
    
    for i = length(y):-1:1
        x_(i) = slice(z(i) / R(i,i));
        z = z - x_(i) * R(:,i);
    end
    
    % restaura a ordem original das antenas
    xt = x_;
    for i = 1:length(cv)
        x_(i,:) = xt(cv(i),:);
    end
end

