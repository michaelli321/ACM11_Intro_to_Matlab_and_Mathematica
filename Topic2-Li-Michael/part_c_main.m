% Performs the median filter with different values of w and different 
% levels of noise

ws = [3, 5, 7];
ps = [.2, .4, .6];
noisy_ims = load('noisy_ims.mat');
noisy_ims = noisy_ims.noisy_ims;
dims = size(noisy_ims);

% loop over each noisy image that we loaded in
for i = 1:dims(3)
    figure
    sgtitle(['Standard Median Filter for p=', num2str(ps(i))])
    noisy_im = noisy_ims(:, :, i);
    
    % apply the filter with different ws and show it
    for j = 1:length(ws)
        subplot(length(ws), 1, j)
        restored_im = medianfilter(noisy_im, ws(j));
        imshow(restored_im)
        title_str = ['Restored Image for w=', num2str(ws(j)), ...
            ' PSNR= ', num2str(peak_psnr(noisy_im, restored_im))];
        title(title_str)
    end
end