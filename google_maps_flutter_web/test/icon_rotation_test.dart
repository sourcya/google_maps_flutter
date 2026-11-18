// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
// ignore: implementation_imports
import 'package:google_maps_flutter_web/src/icon_rotation.dart';

void main() {
  test('rotations within a step share one value', () {
    expect(snapIconRotation(87.3), snapIconRotation(87.4));
    expect(snapIconRotation(87.3), 87);
    expect(snapIconRotation(88.6), 90);
  });

  test('the snapped angle is within half a step of the real one', () {
    for (var degrees = 0.0; degrees < 360; degrees += 0.37) {
      final double snapped = snapIconRotation(degrees);
      final double difference = ((snapped - degrees + 540) % 360) - 180;
      expect(
        difference.abs(),
        lessThanOrEqualTo(kIconRotationStepDegrees / 2 + 1e-9),
      );
    }
  });

  test('a whole fleet of bearings needs at most 360 / step variants', () {
    final Set<double> variants = <double>{
      for (var degrees = 0.0; degrees < 360; degrees += 0.1)
        snapIconRotation(degrees),
    };

    expect(variants.length, 360 ~/ kIconRotationStepDegrees);
  });

  test('angles are normalized to [0, 360)', () {
    expect(snapIconRotation(360), 0);
    expect(snapIconRotation(-1), 0);
    expect(snapIconRotation(-4), 357);
    expect(snapIconRotation(720.4), 0);
    expect(snapIconRotation(359), 0);
  });

  test('a value near a full turn snaps to zero, not 360', () {
    expect(snapIconRotation(359.9), 0);
    expect(snapIconRotation(358.4), 357);
  });

  test('an invalid angle becomes zero', () {
    expect(snapIconRotation(double.nan), 0);
    expect(snapIconRotation(double.infinity), 0);
  });

  test('a custom step is honoured', () {
    expect(snapIconRotation(47, step: 10), 50);
    expect(snapIconRotation(44, step: 10), 40);
  });
}
