clc; clear all; close all;

addpath("Mire\Mire\")
addpath("input\")

P1 = load("Mire\Mire\Mire1.points");
P2 = load("Mire\Mire\Mire2.points");

P1_norm = [P1, ones(size(P1,1),1)];
P2_norm = [P2, ones(size(P2,1),1)];


F_v1 = EightPointsAlgorithm(P1_norm,P2_norm);
F_v2 = EightPointsAlgorithm_v2(P1_norm,P2_norm);

check_F(P1_norm', P2_norm', F_v1);
check_F(P1_norm', P2_norm', F_v2)



