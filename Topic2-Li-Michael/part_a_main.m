% Generates noisy images of coco.tif using Salt & Pepper noise model

% read in the image and convert to grayscale
coco_pic = imread('coco.tif');
coco_pic = coco_pic(:, :, 1:3);
coco_pic = rgb2gray(coco_pic);

ps = [.2, .4 .6];
noisy_ims = []; % keeps track of each noisy image

figure
sgtitle('Salt & Pepper Noisy Images')
for i = 1:length(ps)
    subplot(1, length(ps), i)
    
    % add noise to our image and add it to our figure
    noisy_im = imnoise(coco_pic, 'salt & pepper', ps(i));
    imshow(noisy_im)
    title(['Noisy Image for p=', num2str(ps(i))])
    
    % add noisy image to matrix of noisy images
    noisy_ims = cat(3, noisy_ims, noisy_im);
end

% save the noisy images for use later
save('noisy_ims.mat', 'noisy_ims')
