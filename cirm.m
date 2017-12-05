function [ H ] = cirm( N, M )
    % Tenta emular um canal, precisa de melhor embasamento.
    seed = randi(10);
    
    H = sqrt(seed)*randn(N, M) + 1i*sqrt(seed)*randn(N, M);

end

