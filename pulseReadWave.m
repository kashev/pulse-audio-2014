% Audio Comp
% Brady Rocks
% brady & kashev

% pulseReadWave.m
% Given a .WAV file name, 'Arduinoifies' the data by downsampling it and
% putting it the range of 0-255, then writes this data out to a .CSV file
% that can be copied into an Arduino sketch.

function [] = pulseReadWave(filename)
    [indata, ~] = audioread(strcat('wav\',filename));
    
    outdata = pulseArduinoify(indata);
    
    % figure; plot(outdata); title('Scaled Signal');
    
    [~, name, ~] = fileparts(filename);
    
    csvwrite(strcat('csv\', name, '.csv'), outdata.');    
end

function [outdata] = pulseArduinoify(indata)
    % target_f = 8000, Fs = 44100
    % (44100 * 80) / 441)
    upfact = 80;
    dnfact = 441;
    
    % convert stereo to mono with averaging
    mono = (indata(:,1)+indata(:,2))/2;

    % figure; subplot(3, 1, 1); plot(mono); title('Mono Signal');
    
    % upsample and downsample in 1 step - 44.1kHz -> 8kHz
    ff_in = resample(mono, upfact, dnfact);

    % subplot(3, 1, 2); plot(ff_in); title('Downsampled Signal');

    % rescale samples to 0 to 255
    % V_new = ((V_old - min_old) * (Range_new)) / (Range_old)
    max_old = max(ff_in);
    min_old = min(ff_in);

    scaled = (((ff_in - min_old) .* 255) / (max_old - min_old));
    
    outdata = round(scaled);

    % subplot(3, 1, 3); plot(outdata); title('Scaled Signal');
end
