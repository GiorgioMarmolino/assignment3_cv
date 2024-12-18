clc; clear all; close all;

addpath("Mire\Mire\")
addpath("input\")

%% Part_1

% P1 = load("Mire\Mire\Mire1.points");
% P2 = load("Mire\Mire\Mire2.points");
P1 =  load('Rubik\Rubik\Rubik1.points');
P2 = load('Rubik\Rubik\Rubik2.points');

P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];


F_v1 = EightPointsAlgorithm(P1_norm,P2_norm);
F_v2 = EightPointsAlgorithmN(P1_norm,P2_norm);

check_F(P1_norm', P2_norm', F_v1);
check_F(P1_norm', P2_norm', F_v2);

%% Part_2

 rubik_1 = imread('Rubik\Rubik\Rubik1.pgm');
 rubik_2 = imread('Rubik\Rubik\Rubik2.pgm');
 % mire_1 = imread('Mire\Mire\Mire1.pgm');
 % mire_2 = imread('Mire\Mire\Mire2.pgm');
  img_1_1 = imread('photo\2.jpg');
  img_2_1 = imread('photo\4.jpg');

  img_1=im2gray(img_1_1);
  img_2=im2gray(img_2_1);

M = findMatches(img_1, img_2, 'SIFT', 0.5);
show_matches(img_1, img_2, M, 0, 10);

%inverto perche sift/surf le da invertite
P1 = M(:,[2 1]);
P2 = M(:,[4 3]);


P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];

[bestF, consensus, outliers] = ransacF(P1_norm', P2_norm', 0.0001);

P1_cons = consensus(1:3,:);
P2_cons = consensus(4:6,:);

check_F(P1_cons, P2_cons, bestF);

%% Evaluation 

%epipolar
% P1_1 = load("Mire\Mire\Mire1.points");
% P2_1 = load("Mire\Mire\Mire2.points");

P1_1 =  load('Rubik\Rubik\Rubik1.points');
P2_1 = load('Rubik\Rubik\Rubik2.points');

visualizeEpipolarLines(rubik_1, rubik_2, F_v1, P1_1, P2_1);
visualizeEpipolarLines(rubik_1, rubik_2, F_v2, P1_1, P2_1);

visualizeEpipolarLines(img_1, img_2, bestF,P1,P2);


%case with chosen points
load('input\matched_points_better.mat')

P1_m = movingPoints1;
P2_m = fixedPoints1;

P1_norm_m = [P1_m, ones(size(P1_m,1),1)];
P2_norm_m = [P2_m, ones(size(P2_m,1),1)];

[bestF_m, consensus_m, outliers_m] = ransacF(P1_norm_m', P2_norm_m', 0.0001);

P1_cons = consensus(1:3,:);
P2_cons = consensus(4:6,:);

check_F(P1_norm_m', P2_norm_m', bestF_m);

visualizeEpipolarLines(img_1, img_2, bestF_m,P1_m,P2_m);

%--------------------------------------

% Epipole Computation for All Fundamental Matrices

F_matrices = {F_v1, F_v2, bestF, bestF_m};
names = {'F_v1', 'Normalized F_v2', 'RANSAC F', 'Manual F'};

computeEpipoles(F_matrices, names);