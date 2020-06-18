function restored_im = adaptmedian(noisy_im, w_max)

% Given a noisy image and a maximum window size, returns the 
% restored image using adaptive median filtering assuming there
% is no noise on the boundaries of the image

dims = size(noisy_im);
max_offset = floor(w_max/2);
restored_im = noisy_im;

% assuming no noise, we start our centers where we know we will have 
% at least maximum offset number of elements adjacent
for i = 1+max_offset : dims(1)-max_offset
    for j = 1+max_offset : dims(2)-max_offset
        w = 3;
        
        % keep increasing window size until we're at the maximum
        while w <= w_max
            offset = floor(w/2);
            
            % find the window and its max, min, med vals
            window = noisy_im((i-offset : i+offset), ...
                (j-offset : j+offset));
            s_max = max(window(:));
            s_min = min(window(:));
            s_mid = median(window, 'all');
            
            % step 3 in our algorithm
            if s_min < s_mid && s_mid < s_max
                
                % step 5 in our algorithm
                if s_min < noisy_im(i, j) && noisy_im(i, j) < s_max
                    break
                else
                    restored_im(i, j) = s_mid;
                    break
                end
            else
                w = w + 2;
                
                % step 4 in our algorithm
                if w > w_max
                    restored_im(i, j) = s_mid;
                end
            end
        end    
    end
end

