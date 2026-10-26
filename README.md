# Automotive predictive maintenance

This small study is now presented with the other engineering studies in the [consolidated portfolio](https://github.com/noumansameer789/noumansameer789/tree/main/engineering-studies/automotive-predictive-maintenance).

## Scope

MATLAB feature extraction study. No engine recordings, classifier validation, plots from real recordings or deployment evidence are included.

The existing source remains here for traceability. This is a study, not an additional completed deployed product.

## Verification boundary

The extractor preserves amplitude for RMS/variance, rejects sample rates at or below 200 Hz and short inputs, and handles silent signals. `matlab/test_feature_pipeline.m` provides synthetic regression checks. These checks require MATLAB and Signal Processing Toolbox and were not executed in the publication environment; no engine-fault accuracy is claimed.
