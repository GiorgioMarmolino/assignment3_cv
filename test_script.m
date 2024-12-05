% M = findMatches(img_1, img_2, 'SIFT', 0.5);
% show_matches(img_1, img_2, M, 0, 10);
% 
% %inverto perche sift/surf le da invertite
% P1 = M(:,[2 1]);
% P2 = M(:,[4 3]);

P1 = movingPoints1;
P2 = fixedPoints1;


P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];

[bestF, consensus, outliers] = ransacF(P1_norm', P2_norm', 0.0001);

P1_cons = consensus(1:3,:);
P2_cons = consensus(4:6,:);

check_F(P1_norm', P2_norm', bestF);

%P1 = P1_cons([1 2],:)';
%P2 = P2_cons([1 2],:)';

visualizeEpipolarLines(img_1, img_2, bestF,P1,P2);

[U, D, V] = svd(bestF);
e_left = U(:, end); % epipole left
e_right = V(:, end); % epipole right

e_left = e_left / e_left(end);
e_right = e_right / e_right(end);