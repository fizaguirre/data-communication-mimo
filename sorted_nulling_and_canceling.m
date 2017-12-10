function [ x_ ] = sorted_nulling_and_canceling( H, y, Nr, Nt )

    RR = complex(eye(max(Nr,Nt),max(Nr,Nt)));
    
    yy = zeros(max(Nr,Nt),1);
    yy(1:Nr) = y;

    %ordena a matrix H em modulo
    [cv, Hs] = sort_m(H);
    [Q, R] = qr(Hs);
    RR(1:Nr,1:Nt) = R;
    z = Q' * y;
    
    x_ = zeros(length(yy), 1);
    
    for i = length(yy):-1:1
        x_(i) = slice(z(i) / RR(i,i));
        z = z - x_(i) * RR(:,i);
    end
    
    x_ = x_(1:Nt);
    
    % restaura a ordem original das antenas
    xt = x_;
    for i = 1:length(cv)
        x_(i,:) = xt(cv(i),:);
    end
end

