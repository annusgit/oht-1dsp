

% throughout this exercise, we shall assume that 
% w ==> small omega (discrete frequency)
% W ==> capital omega (Analog frequency)

% ============================== question #1 ==============================
% we are given the following signal
% x(t) = { +0.5, 0.0 <= t <= 0.5
%        { -0.5, 0.5 <  t <= 1.0
% let's define and plot it

Fs = 50; rows = 2; cols = 2;
t = linspace(0,1,Fs);
x = [];
x(0<=t & t<=0.5) = 0.5;
x(0.5<t & t<=1) = -0.5; figure; subplot(rows,cols,1);
plot(t,x); title('Original Signal'); 
xlabel('t (seconds)'); ylabel('x(t)'); hold on;
[W, f] = plot_spectrum(x, Fs); subplot(rows,cols,2); hold on;
plot(W, real(f)); title('Magnitude Spectrum of original signal'); 
xlabel('Frequency (Hz)'); ylabel('magnitude of X(F)'); grid on;
% disp(length(t));


% ============================== question #2 ==============================
% design an analog 3rd order low pass filter before continuous to 
% discrete domain conversion. Use a butterworth filter for doing so...
cut_off_freq = 20; % this is in Hz, so it's analog!

% design a 3rd order butterworth filter with cutoff at cut_off_freq
% now fs is 1000, so fs/2 = 500 and we want to cut at 20 which should be
% 20/500
[b, a] = butter(3, cut_off_freq/(Fs/2)); % the second arg=1 corresponds to fs/2
% apply the butterworth filter
x_filtered = filter(b, a, x);
% plot to see if it worked 
subplot(rows,cols,3); plot(t,x_filtered); 
title('Filtered Signal'); 
xlabel('t (seconds)'); ylabel('x(t) filtered'); hold on;
[W_x, f] = plot_spectrum(x_filtered, Fs); subplot(rows,cols,4); hold on;
plot(W_x, real(f)); title('Magnitude Spectrum of filtered signal'); 
xlabel('Frequency (Hz)'); ylabel('magnitude of X(F) filtered'); grid on;
% disp(length(t));

% also get the frequency response of the filter
% figure;
% this will return a discrete domain frequency vector 'w' so we convert it
[h, w] = freqz(b, a, 500); % we will plot it at 500 points 
figure; % subplot(rows, cols, 5);
% because we know that 2*pi*f/Fs = w ==> f = Fs*w/(2*pi)
plot(w*Fs/(2*pi), abs(h)); grid on; 
title('frequency response of butterworth filter'); 
xlabel('Frequency (Hz)'); ylabel('H(F) of the filter')

% ============================== question #3 ==============================
% Now we will do continuous to discrete domain conversion
% using a zero-order hold filter followed by quantization

% apply a zero order hold filter
zero_order_held = filter(W_x, 1, x_filtered);
figure;
plot(t, zero_order_held); title('zero order hold'); 
xlabel('t (seconds)'); ylabel('x(t) zero order held');










