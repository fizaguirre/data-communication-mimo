%%
% Ordena em ordem crescente a matriz 'in_matrix' pela norma de suas colunas.
%
% O vetor 'change_vec' armazena uma representação da ordem original da
% matriz para posterior volta à ordem original.
%
% OBS.: esse código não funciona nos casos em que as colunas têm a mesma
% magnitude (norma). Esse é um caso excepcional que foi decidido não ser
% tratado, pois matriz 'in_matrix' usada aqui muito raramente terá duas
% colunas de mesma magnitude (vide comentário da função cirm())
%
function [ change_vec, out_matrix ] = sort_m( in_matrix )
    [N, M] = size(in_matrix);
    abs_v = zeros(1,M);
    
    for j = 1:M
        abs_v(j) = norm(in_matrix(:,j));
    end
    
    ordered_vec = sort(abs_v);
    out_matrix  = zeros(N, M);
    change_vec  = uint8(zeros(1, M));
    
    for i = 1:M
        for j = 1:M
            if norm(in_matrix(:,j)) == ordered_vec(i)
                change_vec(j) = i;
                out_matrix(:,i) = in_matrix(:,j);
            end
        end
    end
    
end
