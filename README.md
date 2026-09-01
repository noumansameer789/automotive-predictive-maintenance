# DSP-based automotive predictive maintenance

MATLAB feature pipeline for labelled engine-acoustic signals: Butterworth
high-pass filtering, normalisation, time-domain features and spectral features.

The original small labelled dataset produced perfect class separation. That is
documented as a warning, not a deployment claim. A credible next evaluation needs
more engines, operating conditions, recording devices, grouped train/test splits
and a prospectively collected holdout set.

Run `matlab/feature_pipeline.m` with one signal per row and the sample rate in
hertz. The function returns RMS, variance, zero-crossing rate, spectral centroid,
bandwidth and 85% spectral roll-off.
