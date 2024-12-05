function check_F(P1,P2,F)
    format long;
    if size(P1,2) ~= size(P2,2)
        error('P1 and P2 have different number of coloumns (points collected)');
    end

    for ii=1:size(P1,2)
        check_val = P2(:,ii)'*F*P1(:,ii);
        fprintf('Couple of points n. %d, check gives us %f\n', ii, check_val);
    end
end

