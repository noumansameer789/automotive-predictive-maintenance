% Run in MATLAB with Signal Processing Toolbox: test_feature_pipeline
fs = 1000; t = (0:999)/fs; x = sin(2*pi*180*t);
f = feature_pipeline([x; 2*x; zeros(size(x))], fs);
assert(all(isfinite(f), 'all'));
assert(abs(f(2,1)/f(1,1)-2) < 1e-8, 'RMS must retain amplitude');
assert(abs(f(2,2)/f(1,2)-4) < 1e-8, 'Variance must retain amplitude');
assert(all(f(3,:) == 0), 'Silent input must yield finite zeros');
assert(abs(f(1,4)-180) < 10, 'Expected spectral centroid near 180 Hz');
try
    feature_pipeline(x, 200); error('test:NoError', 'Expected invalid fs rejection');
catch err
    assert(~strcmp(err.identifier, 'test:NoError'));
end
try
    feature_pipeline(zeros(1,5), fs); error('test:NoError', 'Expected short signal rejection');
catch err
    assert(strcmp(err.identifier, 'feature_pipeline:ShortSignal'));
end
