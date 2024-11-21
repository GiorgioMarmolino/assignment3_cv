clc; clear all; close all;

addpath ("Mire\Mire\")

P1 = load("Mire\Mire\Mire1.points");
P2 = load("Mire\Mire\Mire2.points");

P1 = [P1, ones(size(P1, 1), 1)];
P2 = [P2, ones(size(P2, 1), 1)];




