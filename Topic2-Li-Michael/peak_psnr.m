function ratio = peak_psnr(noisy_im, restored_im)

% Given a noisy image and a restoration of it, calculates and returns
% the peak signal to noise ratio

denominator = sum((restored_im - noisy_im).^2, 'all');
dims = size(noisy_im);
numerator = 255^2 * dims(1) * dims(2); % 255^2 * M * N
ratio = 10 * log10(numerator / denominator);