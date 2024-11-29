clc; clear all; close all;

addpath("Mire\Mire\")
addpath("input\")

%% Part_1

% P1 = load("Rubik\Rubik\Rubik1.points");
% P2 = load("Rubik\Rubik\Rubik2.points");
P1 = load("Mire\Mire\Mire1.points");
P2 = load("Mire\Mire\Mire2.points");

P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];

F_v1 = EightPointsAlgorithm(P1_norm, P2_norm);
F_v2 = EightPointsAlgorithmN(P1_norm, P2_norm);

check_F(P1_norm', P2_norm', F_v1);
check_F(P1_norm', P2_norm', F_v2);

%% Part_2: SURF

% img_1 = imread('Rubik\Rubik\Rubik1.pgm');
% img_2 = imread('Rubik\Rubik\Rubik2.pgm');
 % img_1 = imread('Mire\Mire\Mire1.pgm');
 % img_2 = imread('Mire\Mire\Mire2.pgm');

%  img_1_1 = imread('photo\Immagine WhatsApp 2024-11-28 ore 17.08.07_53d22afb.jpg');
%  img_2_1 = imread('photo\Immagine WhatsApp 2024-11-28 ore 17.08.07_2832cd80.jpg');
% img_1=im2gray(img_1_1);
% img_2=im2gray(img_2_1);

%  img_1=resize(img_1,[576 720]);
%  img_2=resize(img_2,[576 720]);

points1 = detectFASTFeatures(img_1);
points2 = detectFASTFeatures(img_2);

% [features1, valid_points1] = extractFeatures(img_1, points1.Location, Method="SURF");
% [features2, valid_points2] = extractFeatures(img_2, points2.Location, Method="SURF");

d1_all = extractFeatures(img_1, points1.Location, Method="SURF");
d2_all = extractFeatures(img_2, points2.Location, Method="SURF");



indexPairs = matchFeatures(features1, features2, MatchThreshold=50, MaxRatio=0.8);

matchedPoints1 = valid_points1(indexPairs(:, 1)).Location;
matchedPoints2 = valid_points2(indexPairs(:, 2)).Location;
 
M = [matchedPoints1,matchedPoints2];

% figure;
% showMatchedFeatures(img_1, img_2, matchedPoints1, matchedPoints2, 'montage');

%
%per la surf con istogram:
%HI(H1,H2)=(sum(min(h1(i)*h2(i))/(sum(max(h1(i)*h2(i)));
%
%
%
% visualize matrix with imagesc()
show_matches(img_1, img_2, M, 1 , 10);

P1 = matchedPoints1;
P2 = matchedPoints2;

P1_norm = [P1, ones(size(P1,1),1)]';
P2_norm = [P2, ones(size(P2,1),1)]';

[bestF, consensus, outliers] = ransac_code(P1_norm, P2_norm, 0.001);

P1_cons = consensus(1:3, :);
P2_cons = consensus(4:6, :);

check_F(P2_cons, P1_cons, bestF);

%% Evaluation: 
 P1_1 = load("Mire\Mire\Mire1.points");
 P2_1 = load("Mire\Mire\Mire2.points");

visualizeEpipolarLines(img_1, img_2, F_v1, P1_1, P2_1);
visualizeEpipolarLines(img_1, img_2, F_v2, P1_1, P2_1);



visualizeEpipolarLines(img_1, img_2, bestF, matchedPoints1, matchedPoints2);

[U, D, V] = svd(F_v1);
e_left = U(:, end);   % Left epipole
e_right = V(:, end);  % Right epipole

e_left = e_left / e_left(end);
e_right = e_right / e_right(end);

disp("Left epipole (e'): ");
disp(e_left);

disp("Right epipole (e): ");
disp(e_right);
