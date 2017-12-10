function [ x_ ] = nulling_and_canceling( H, y, Nr, Nt )
    
    HH = complex(eye(max(Nr,Nt),max(Nr,Nt)));
    HH(1:Nr,1:Nt) = H;
    yy = zeros(max(Nr,Nt),1);
    yy(1:Nr) = y;

    [Q, R] = qr(HH);
    z = Q' * yy;
    
    x_ = zeros(length(yy), 1);
    
    for i = length(yy):-1:1
        x_(i) = slice(z(i) / R(i,i));
        z = z - x_(i) * R(:,i);
    end
    
    x_ = x_(1:Nt);
end