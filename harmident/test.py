#!/usr/bin/env python

import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

import scipy.io.wavfile as wav

fs, sig = wav.read("/tmp/wywh.wav")
print("Fs: " + str(fs))
print(sig.shape)
#left_channel = sig[:,0]
#right_channel = sig[:,1]


f, t, Sxx = signal.spectrogram(sig,fs)
#Sxx = np.multiply(10,np.log10(np.add(1,np.absolute(Sxx))))

fil_p = signal.medfilt(Sxx, kernel_size=[21, 1])
fil_h = signal.medfilt(Sxx, kernel_size=[1,41])

print("fil shapes: ")
print(Sxx.shape)
print(fil_p.shape)
print(fil_h.shape)
lp = np.zeros(fil_p.shape)
lh = lp
for i in range(Sxx.shape[0]):
    for j in range(Sxx.shape[1]):
        lp[i][j] = np.max(fil_p[i][j] - fil_h[i][j],0)
        lh[i][j] = np.max(fil_h[i][j] - fil_p[i][j],0)
print(lp.shape)
print(lh.shape)

harm = np.zeros(Sxx.shape)
perc = np.zeros(Sxx.shape)
for i in range(Sxx.shape[0]):
    for j in range(Sxx.shape[1]):
        if(lp[i][j] > lh[i][j]):
            perc[i][j] = Sxx[i][j]
        else:
            harm[i][j] = Sxx[i][j]

harm = np.multiply(10,np.log10(np.add(1,np.absolute(harm))))
perc = np.multiply(10,np.log10(np.add(1,np.absolute(perc))))


plt.pcolormesh(t,f, harm)
plt.ylabel('Frequency [Hz]')
plt.ylabel('Time [sec]')
plt.show()

plt.pcolormesh(t,f, perc)
plt.ylabel('Frequency [Hz]')
plt.ylabel('Time [sec]')
plt.show()


