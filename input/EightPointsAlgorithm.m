function [F] = EightPointsAlgorithm(P1,P2)
    
n = size(P1,1);

A = zeros(n, 9);
for i = 1:n
    x1 = P1(i, 1); y1 = P1(i, 2);
    x2 = P2(i, 1); y2 = P2(i, 2);
    A(i, :) = [x2 * x1, x2 * y1, x2, y2 * x1, y2 * y1, y2, x1, y1, 1];
end

[~, ~, V] = svd(A);

f = V(:,end);

F = reshape(f,3,3);

%impose rank 2 of final matrix F

[U, D, V] = svd(F);
D(3,3) = 0; 
F = U*D*V';

end

