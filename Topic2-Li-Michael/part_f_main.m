% Generates noisy images of coco.tif using the Gaussian noise model and
% performs the median filter with zero padding on them

% read in the image and convert to grayscale
coco_pic = imread('coco.tif');
coco_pic = coco_pic(:, :, 1:3);
coco_pic = rgb2gray(coco_pic);

vs = [.1, .2 .3];
noisy_ims = []; % keeps track of each noisy image

figure
sgtitle('Gaussian Noisy Images')
for i = 1:length(vs)
    subplot(length(vs), 1, i)
    
    % add noise to our image and add it to our figure
    noisy_im = imnoise(coco_pic, 'gaussian', 0, vs(i));
    imshow(noisy_im)
    title(['Gaussian Noisy Image with v=', num2str(vs(i))])
    
    % add noisy image to matrix of noisy images
    noisy_ims = cat(3, noisy_ims, noisy_im);
end

ws = [3, 5, 7];
dims = size(noisy_ims);

% loop over each noisy image we created
for i = 1:dims(3)
    figure
    sgtitle(['Median Filter with Gaussian Noise for v=', num2str(vs(i))])
    noisy_im = noisy_ims(:, :, i);
    
    % apply the filter with different ws and show it
    for j = 1:length(ws)
        subplot(length(ws), 1, j)
        restored_im = medianfilter_padzeros(noisy_im, ws(j));
        imshow(restored_im)
        title_str = ['Restored Image for w=', num2str(ws(j)), ...
            ' PSNR= ', num2str(peak_psnr(noisy_im, restored_im))];
        title(title_str)
    end
end

% The noisy images are darker and much more pixelated/granular. They 
% look like when an old school tv is not receiving signal. After 
% running the median filter with padzeros on them, it looks like it
% works somewhat but definitely not as well as the salt & pepper noise. 
% While you can still make out the picture, it is much blurrier and as w 
% increases the picture is not nearly as sharp as the salt & pepper ones. 
% We also see the PSNRs are lower. This can probably be explained by the 
% fact that the gaussian noise adds noise to certain grayscale numbers
% at different rates so certain numbers will have much lower probability
% of being restored
