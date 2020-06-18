% Performs the adaptive median filter with a max windows size of 9
% and different levels of noise

ps = [.2, .4, .6];
w_max = 9;
noisy_ims = load('noisy_ims.mat');
noisy_ims = noisy_ims.noisy_ims;
dims = size(noisy_ims);

figure
sgtitle(['Adaptive Median Filter for w_{max}=', num2str(w_max)])

% loop over each noisy image that we loaded in
for i = 1:dims(3)
    subplot(length(ps), 1, i)
    noisy_im = noisy_ims(:, :, i);
    
    % apply the filter and show it
    restored_im = adaptmedian(noisy_im, w_max);
    title_str = ['Restored Image for p=', ...
        num2str(ps(i)),', '...
        'PSNR= ', num2str(peak_psnr(noisy_im, restored_im))];
    imshow(restored_im)
    title(title_str)
end
