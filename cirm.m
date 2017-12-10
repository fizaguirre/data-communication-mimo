%%
% Cria uma matrix função de transferência do canal.
%
function [ H ] = cirm( N, M )
    
    seed = randi(10);
    H = seed*randn(N, M) + seed*1i*randn(N, M);
    
    %%
    % COMENTE O CÓDIGO ACIMA (e descomente a linha abaixo :) para testar a
    % simulação sobre um canal AWGN "perfeito".
    %
    % (O canal não é perfeito, há um pequêno ruído para fazer com que as
    % colunas tenham uma norma diferente entre si. Com isso, a função
    % sort_m() funciona de forma esperada para ordenar as colunas dessa
    % matriz H)
%     H = eye(N,M) + rand(N,M)/50;

end

