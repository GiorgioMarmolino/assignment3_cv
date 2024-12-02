function check_F(P1,P2,F)

    if size(P1,2) ~= size(P2,2)
        error('P1 and P2 have different number of coloumns (points collected)');
    end

    for ii=1:size(P1,2)
        check_val = P2(:,ii)'*F*P1(:,ii);
        fprintf('Check della coppia di punti %d è %.4f\n', ii, check_val);
    end
end

