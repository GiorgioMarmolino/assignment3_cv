img_1_1 = imread('2.jpg');
img_2_1 = imread('4.jpg');

img_1=im2gray(img_1_1);
img_2=im2gray(img_2_1);

cpselect(img_1, img_2);
