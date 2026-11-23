
%% Lab 3: Frequency-Domain Filtering with fft2
% Course: Mathematical Algorithms (DSP) - Image Processing Labs

close all;
clear;
clc;

%% Load and prepare image

if exist('peppers.png','file')
    I0 = imread('peppers.png');
else
    I0 = repmat(imread('cameraman.tif'),1,1,3);
end

if size(I0,3) == 3
    I = im2double(rgb2gray(I0));
else
    I = im2double(I0);
end

[M,N] = size(I);

%% 1) Magnitude Spectrum (Log Scale)

F = fft2(I);
Fshift = fftshift(F);

S = log(1 + abs(Fshift));

figure(1);

subplot(1,2,1);
imshow(I,[]);
title('Original Image');

subplot(1,2,2);
imshow(S,[]);
title('Log-Magnitude Spectrum (Centered)');

%% 2) Ideal and Gaussian Low-Pass Filters

[u,v] = meshgrid( ...
    -floor(N/2):ceil(N/2)-1, ...
    -floor(M/2):ceil(M/2)-1);

D = sqrt(u.^2 + v.^2);

D0 = 40;

% Ideal circular low-pass filter
H_ideal_LP = double(D <= D0);

% Gaussian low-pass filter
sigma = 20;
H_gauss_LP = exp(-(D.^2)/(2*sigma^2));

%% 3) Apply Low-Pass Filters in Frequency Domain

G_ideal = ifft2(ifftshift(H_ideal_LP .* Fshift));
G_gauss = ifft2(ifftshift(H_gauss_LP .* Fshift));

figure(2);

montage({I,real(G_ideal),real(G_gauss)},'Size',[1 3]);

title('Original | Ideal Low-Pass | Gaussian Low-Pass');

%% 4) Gaussian High-Pass Filter

H_gauss_HP = 1 - H_gauss_LP;

G_hp = real(ifft2(ifftshift(H_gauss_HP .* Fshift)));

G_hp = mat2gray(G_hp);

figure(3);

montage({I,G_hp},'Size',[1 2]);

title('Original | Gaussian High-Pass Result');

%% 5) Compare Spatial and Frequency-Domain Gaussian LP

% Create a 7x7 Gaussian filter
g1d = fspecial('gaussian',[1 7],1.2);
h_spatial = g1d' * g1d;

% Apply spatial filtering with circular boundary
I_spatial_gauss = imfilter(I,h_spatial,'circular');

% Place the filter in an MxN array
h_padded = zeros(M,N);
h_padded(1:7,1:7) = h_spatial;

% Move the filter centre to the FFT origin
h_padded = circshift(h_padded,[-3 -3]);

% Calculate the frequency response
H_spatial = fft2(h_padded);

% Apply frequency-domain filtering
I_frequency_gauss = real(ifft2(F .* H_spatial));

figure(4);

montage({I_spatial_gauss,I_frequency_gauss},'Size',[1 2]);

title('Spatial Gaussian LP | Frequency-Domain Gaussian LP');

% Calculate comparison error
comparison_error = max(abs( ...
    I_spatial_gauss(:) - I_frequency_gauss(:)));

fprintf('\nSPATIAL AND FREQUENCY COMPARISON\n');
fprintf('Maximum difference: %.12g\n',comparison_error);

%% 6) Save All Figures

for k = 1:4
    figure(k);
    filename = sprintf('Lab03_figure_%02d.png',k);
    saveas(gcf,filename);
end

fprintf('\nAll four figures saved successfully.\n');
