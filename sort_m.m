function [  change_vec, out_vec ] = sort_m( in_vec )
    s = size(in_vec);
    abs_v = zeros(1,s(2));
    change_vec = uint8(zeros(1, s(2)));
    
    for i = 1:s(2)
        abs_v(i) = norm(in_vec(:,i));
    end
    
    ordered_vec = sort(abs_v);
    
    for i = 1:s(2)
        for j = 1:s(2)
            if norm(in_vec(:,j)) == ordered_vec(i)
                change_vec(j) = i;
                out_vec(:,i) = in_vec(:,j);
            end
        end
    end
    
end

