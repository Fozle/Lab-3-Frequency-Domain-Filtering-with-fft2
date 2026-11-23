# Lab 3 – Frequency-Domain Filtering with FFT2

## Objective

The objective of this experiment was to understand frequency-domain image filtering using the 2D Fast Fourier Transform (FFT). I investigated low-pass filtering, high-pass filtering and the relationship between spatial and frequency-domain filtering.

## 1. Magnitude Spectrum

I used fft2() to convert the grayscale image into the frequency domain. Then I used fftshift() to move the low-frequency components to the centre.

The log-magnitude spectrum helped me visualize the frequency distribution of the image.

## 2. Ideal and Gaussian Low-Pass Filters

I applied ideal and Gaussian low-pass filters.

The ideal low-pass filter removes frequencies above a fixed cutoff. It can produce ringing artifacts around sharp edges because of its hard cutoff.

The Gaussian low-pass filter produces smoother results because its frequency response changes gradually.

## 3. Gaussian High-Pass Filter

I created a Gaussian high-pass filter by subtracting the low-pass filter from one.

The high-pass filter preserved high-frequency information, such as edges and fine details, while reducing low-frequency information.

## 4. Spatial and Frequency-Domain Comparison

I compared Gaussian filtering in the spatial and frequency domains.

The maximum difference between the two results was approximately 5.5511e-16. This value is practically zero.

This confirms that both methods produced almost identical results.

## 5. Reflections

### 1. Why does ideal low-pass filtering cause ringing?

An ideal low-pass filter has a sharp frequency cutoff. This creates oscillations near sharp image edges, known as the Gibbs phenomenon.

### 2. What does fftshift do visually?

fftshift() moves the low-frequency components to the centre of the spectrum. This makes the frequency distribution easier to observe.

### 3. When is frequency-domain filtering computationally preferable?

Frequency-domain filtering can be more efficient for large filters and large images. FFT methods can reduce the computational cost compared with direct spatial convolution.

## Conclusion

This experiment helped me understand how images can be filtered in the frequency domain. I learned the differences between ideal and Gaussian filters and verified that spatial and frequency-domain Gaussian filtering can produce nearly identical results.

## AI Usage

**Tool used:** ChatGPT

**How I used it:** I used ChatGPT to understand FFT operations, frequency-domain filtering and MATLAB commands.

**What I verified or changed:** I ran the complete MATLAB script, checked all four figures and verified the spatial and frequency-domain filtering results using the maximum difference.
