clc; clear all; close all;

addpath("Mire\Mire\")
addpath("input\")

%% Part_1

P1 = load("Mire\Mire\Mire1.points");
P2 = load("Mire\Mire\Mire2.points");

P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];


F_v1 = EightPointsAlgorithm(P1_norm,P2_norm);
F_v2 = EightPointsAlgorithmN(P1_norm,P2_norm);

check_F(P1_norm', P2_norm', F_v1);
check_F(P1_norm', P2_norm', F_v2);

%% Part_2

 % img_1 = imread('Rubik\Rubik\Rubik1.pgm');
 % img_2 = imread('Rubik\Rubik\Rubik2.pgm');
 mire_1 = imread('Mire\Mire\Mire1.pgm');
 mire_2 = imread('Mire\Mire\Mire2.pgm');
  img_1_1 = imread('photo\4.jpg');
  img_2_1 = imread('photo\2.jpg');

  img_1=im2gray(img_1_1);
  img_2=im2gray(img_2_1);

M = findMatches(img_1, img_2, 'SIFT', 0.7);
show_matches(img_1, img_2, M, 0, 10);

%inverto perche sift/surf le da invertite
P1 = M(:,[2 1]);
P2 = M(:,[4 3]);


P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];

[bestF, consensus, outliers] = ransacF(P1_norm', P2_norm', 0.00001);

P1_cons = consensus(1:3,:);
P2_cons = consensus(4:6,:);

check_F(P1_cons, P2_cons, bestF);

%% Evaluation 

%epipolar
P1_1 = load("Mire\Mire\Mire1.points");
P2_1 = load("Mire\Mire\Mire2.points");

visualizeEpipolarLines(mire_1, mire_2, F_v1, P1_1, P2_1);
visualizeEpipolarLines(mire_1, mire_2, F_v2, P1_1, P2_1);

P1 = P1_cons([1 2],:)';
P2 = P2_cons([1 2],:)';
visualizeEpipolarLines(img_1, img_2, bestF,P1,P2);

[U, D, V] = svd(bestF);
e_left = U(:, end); % epipole left
e_right = V(:, end); % epipole right

e_left = e_left / e_left(end);
e_right = e_right / e_right(end);


