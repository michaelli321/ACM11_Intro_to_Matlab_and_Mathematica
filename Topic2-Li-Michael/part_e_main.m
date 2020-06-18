% Performs the median filter using 2 different boundary methods with 
% different levels of noise

ws = [3, 5, 7];
ps = [.2, .4, .6];
noisy_ims = load('noisy_ims.mat');
noisy_ims = noisy_ims.noisy_ims;
dims = size(noisy_ims);

% First Implementation - Zero Padding
% The first non-trivial way I thought of was to pad the matrix with 
% an offset of 0s. This way when we grab our windows at the boundary, at
% least we will not go out of bounds.

% loop over each noisy image that we loaded in
for i = 1:dims(3)
    figure
    sgtitle(['Zero Pad Median Filter for p=', num2str(ps(i))])
    noisy_im = noisy_ims(:, :, i);
    
    % apply the filter with different ws and show it
    for j = 1:length(ws)
        subplot(length(ws), 1, j)
        restored_im = medianfilter_padzeros(noisy_im, ws(j));
        imshow(restored_im)
        title_str = ['Restored Image for w= ', num2str(ws(j)), ...
            ', PSNR= ', num2str(peak_psnr(noisy_im, restored_im))];
        title(title_str)
    end
end

% Second Implementation - Replicating Edges Padding
% While zero padding allows us to run our filter on the boundaries, it 
% does not allow us to really draw extra information and adds some more
% noise in a sense. We generally get a black border cause there are many
% more zeros. Another implementation that I thought of was to replicate 
% the edge elements of the matrix offset many times. This way we are 
% re-using existing information

% loop over each noisy image that we loaded in
for i = 1:dims(3)
    figure
    sgtitle(['Replicate Edges Pad Median Filter for p=', num2str(ps(i))])
    noisy_im = noisy_ims(:, :, i);
    
    % apply the filter with different ws and show it
    for j = 1:length(ws)
        subplot(length(ws), 1, j)
        restored_im = medianfilter_padreplicas(noisy_im, ws(j));
        imshow(restored_im)
        title_str = ['Restored Image for w= ', num2str(ws(j)), ...
            ', PSNR= ', num2str(peak_psnr(noisy_im, restored_im))];
        title(title_str)
    end
end
