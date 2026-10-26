function features = feature_pipeline(signals, fs)
%FEATURE_PIPELINE Illustrative high-pass vibration/acoustic feature extractor.
% Rows are recordings. Columns: filtered RMS, variance, zero-crossing rate,
% magnitude-weighted centroid (Hz), bandwidth (Hz), 85% roll-off (Hz).
% Requires Signal Processing Toolbox. This is not a trained classifier.
    validateattributes(fs, {'numeric'}, {'real','finite','scalar','>',200});
    validateattributes(signals, {'numeric'}, {'real','finite','2d','nonempty'});
    [b, a] = butter(4, 100/(fs/2), 'high');
    minSamples = 3 * (max(length(a), length(b)) - 1);
    if size(signals, 2) <= minSamples
        error('feature_pipeline:ShortSignal', 'Too few samples for filtfilt padding');
    end
    features = zeros(size(signals, 1), 6);
    for i = 1:size(signals, 1)
        x = filtfilt(b, a, double(signals(i, :)));
        % Preserve amplitude information for RMS and variance.
        spectrum = abs(fft(x));
        spectrum = spectrum(1:floor(numel(x)/2)+1);
        frequencies = (0:numel(spectrum)-1) * fs / numel(x);
        mass = sum(spectrum);
        centroid = 0; bandwidth = 0; rolloff = 0;
        if mass > 0
            weights = spectrum / mass;
            centroid = sum(frequencies .* weights);
            bandwidth = sqrt(sum(((frequencies-centroid).^2) .* weights));
            rolloffIndex = find(cumsum(weights) >= 0.85, 1, 'first');
            if isempty(rolloffIndex), rolloffIndex = numel(frequencies); end
            rolloff = frequencies(rolloffIndex);
        end
        features(i, :) = [sqrt(mean(x.^2)), var(x), ...
            mean(abs(diff(x > 0))), centroid, bandwidth, rolloff];
    end
end
