%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAB EXPERIMENT 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('providedCode');

N = 1024;
H = 512;
w = win('sin', N);
lh_sec = 0.2;
lp_Hz = 500;

for file = {'Stepdad', 'Applause', 'DrumSolo'}
    disp(strcat('Data/', file, '.wav'));
    [x, fs] = audioread(strcat('Data/', file{1}, '.wav'));
    [x_h,x_p] = HPSS(x,N,H,w,fs,lh_sec,lp_Hz);
    audiowrite(strcat(file{1}, 'p.wav'), x_p, fs);
    audiowrite(strcat(file{1}, 'h.wav'), x_h, fs);
end

