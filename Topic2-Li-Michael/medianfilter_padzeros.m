function restored_im = medianfilter_padzeros(noisy_im, wsize)

% Given a noisy image and a window size, returns the restored image using
% standard median filtering. At boundaries, the matrix is padded with 
% zeros as needed

dims = size(noisy_im);
offset = floor(wsize/2);
restored_im = noisy_im;

% pad the matrix
noisy_im = padarray(noisy_im, offset, 0);
side_pad = zeros(dims(1)+(2*offset), offset);
noisy_im = [side_pad noisy_im side_pad];

% since we padded the matrix, all of our original elements are located
% at a +offset (i,j) -> (i+offset, j+offset)
for i = 1+offset : dims(1)+offset
    for j = 1+offset : dims(2)+offset
        
        % find median of window and replace center with that value
        window = noisy_im((i-offset : i+offset), (j-offset : j+offset));
        med = median(window, 'all');
        
         % we did not pad the restored image so need to take out the offset
        restored_im(i-offset, j-offset) = med;
    end
end
