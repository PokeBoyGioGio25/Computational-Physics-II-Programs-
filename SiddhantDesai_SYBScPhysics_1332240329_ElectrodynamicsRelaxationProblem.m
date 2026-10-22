clc;
clear all;
close all;

% Grid Parameters
N = 200;
t = 8;

% Uploading the image and creating a mask of the letter.
imagefile = 'Sphoyo.png';
img = imread(imagefile);

if ndims(img) == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
end

info = imfinfo(imagefile);
hasAlpha = isfield(info, 'ColorType') && strcmpi(info.ColorType, 'truecoloralpha') ...
           || (ndims(img) == 3 && size(img,3) == 4);

if hasAlpha
    [~,~,alpha] = imread(imagefile);
    if ~isempty(alpha)
        img_mask = alpha > 0;
    else
        img_mask = img_gray < 128;
    end
else
    thresh = graythresh(img_gray);
    img_mask = imbinarize(img_gray, thresh);
    if nnz(img_mask) > numel(img_mask)/2
        img_mask = ~img_mask;
    end
end

mask_bb = bwboundaries(img_mask, 8, 'noholes'); %#ok<NASGU>
mask_resized = imresize(double(img_mask), [N N], 'bilinear');
mask = mask_resized > 0.5;

% Potential and Relaxation
V = zeros(N);
V(mask) = 100;

V([1 end], :) = 0;
V(:, [1 end]) = 0;

boundary = false(N);
boundary([1 end], :) = true;
boundary(:, [1 end]) = true;

max_iter = 100;
tol = 1e-5;

for iter = 1:max_iter
    V_old = V;
    interior = ~mask & ~boundary;
    
    V_shift_up    = V_old([2:end end], :);
    V_shift_down  = V_old([1 1:end-1], :);
    V_shift_right = V_old(:, [2:end end]);
    V_shift_left  = V_old(:, [1 1:end-1]);
    
    V_new = 0.25 * (V_shift_up + V_shift_down + V_shift_right + V_shift_left);
    V(interior) = V_new(interior);
    
    if max(abs(V(:) - V_old(:))) < tol
        break;
    end
end

fprintf('Converged in %d iterations\n', iter);

% Plotting
figure;
imagesc(mask);
colormap(gray);
axis equal tight off;
title('Letter S');

figure;
contourf(V, 40, 'LineColor', 'none');
colorbar;
axis equal tight;
title('2D Potential Distribution');

figure;
surf(V, 'EdgeColor', 'none');
shading interp;
colorbar;
view(45, 30);
title('3D Potential Plot');