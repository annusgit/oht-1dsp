% we shall use this function for obtaining our spectrums to plot
function [f, x_axis] = plot_spectrum(x, Fs)
% x is your input signal  Fs is sampling frequence
% [x,Fs] = audioread('sample.wav');
L=length(x);
NFFT = 2^nextpow2(L);% Next power of 2 from length of x
Y = fft(x,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
x_axis = 2*abs(Y(1:NFFT/2+1));

end