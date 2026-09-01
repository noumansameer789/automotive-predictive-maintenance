function features = feature_pipeline(signals, fs)
%FEATURE_PIPELINE Extract robust time- and frequency-domain features.
% Rows are recordings; columns are time samples.
    if fs <= 0
        error('Sample rate must be positive');
    end
    [b, a] = butter(4, 100/(fs/2), 'high');
    n = size(signals, 1);
    features = zeros(n, 6);
    for i = 1:n
        x = filtfilt(b, a, double(signals(i, :)));
        x = (x - mean(x)) / max(std(x), eps);
        spectrum = abs(fft(x));
        spectrum = spectrum(1:floor(end/2));
        frequencies = (0:numel(spectrum)-1) * fs / numel(x);
        weights = spectrum / max(sum(spectrum), eps);
        centroid = sum(frequencies .* weights);
        bandwidth = sqrt(sum(((frequencies-centroid).^2) .* weights));
        cumulative = cumsum(weights);
        rolloffIndex = find(cumulative >= 0.85, 1, 'first');
        features(i, :) = [rms(x), var(x), mean(abs(diff(x > 0))), ...
                          centroid, bandwidth, frequencies(rolloffIndex)];
    end
end
