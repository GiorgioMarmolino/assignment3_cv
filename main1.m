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
check_F(P1_norm', P2_norm', F_v2)

%% Part_2

img_1 = imread('Mire\Mire\Mire1.pgm');
img_2 = imread('Mire\Mire\Mire2.pgm');

M = findMatches(img_1, img_2, 'SIFT', 0.8);
show_matches(img_1, img_2, M, 0, 10);

P1 = M(:,1:2);
P2 = M(:,3:4);

P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];

P1_norm = P1_norm';
P2_norm = P2_norm';

[bestF, consensus, outliers] = ransac_code(P1_norm, P2_norm, 0.1);

P1_cons = consensus(1:3,:);
P2_cons = consensus(4:6,:);

check_F(P2_cons, P1_cons, bestF);


