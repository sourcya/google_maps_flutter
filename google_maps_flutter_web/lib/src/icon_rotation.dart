// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// The step, in degrees, that a rotated marker icon is snapped to.
///
/// The JS Maps API cannot rotate an image icon, so each distinct rotation of an
/// icon is drawn into its own bitmap. Rotations such as a vehicle's bearing
/// (87.3, 87.4, ...) are almost all different, so a large fleet needed one
/// bitmap per marker. Snapping to a few degrees shares one bitmap per icon and
/// step (120 at 3 degrees) while staying within 1.5 degrees of the real angle,
/// which is not visible at marker size.
const double kIconRotationStepDegrees = 3;

/// [degrees] normalized to [0, 360) and snapped to the nearest [step].
double snapIconRotation(
  double degrees, {
  double step = kIconRotationStepDegrees,
}) {
  if (!degrees.isFinite) {
    return 0;
  }
  final double normalized = ((degrees % 360) + 360) % 360;
  return ((normalized / step).round() * step) % 360;
}
