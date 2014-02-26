% Audio Comp
% Brady Rocks
% brady & kashev

% pulseReadWaveFiles.m
% Reads all the .WAV files in wav/, then writes 'Arduinoified' samples
% to .CSV files in csv/

clear all; close all;
fnames = dir('wav/*.wav');

for i = 1:length(fnames)
    pulseReadWave(fnames(i).name);
end;