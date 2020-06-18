function restored_im = medianfilter(noisy_im, wsize)

% Given a noisy image and a window size, returns the restored image using
% standard median filtering assuming there is no noise on the 
% boundaries of the image

dims = size(noisy_im);
offset = floor(wsize/2);
restored_im = noisy_im;

% assuming no noise, we start our centers where we know we will have 
% at least offset number of elements adjacent
for i = 1+offset : dims(1)-offset
    for j = 1+offset : dims(2)-offset
        
        % find median of window and replace center with that value
        window = noisy_im((i-offset : i+offset), (j-offset : j+offset));
        med = median(window, 'all');
        restored_im(i, j) = med;
    end
end
