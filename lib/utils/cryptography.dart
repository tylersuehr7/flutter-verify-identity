import 'dart:typed_data';

import 'package:pointycastle/export.dart';
import 'package:pointycastle/src/platform_check/platform_check.dart';

/// Securely generates a random octet sequence of given length.
///
/// [outputBytes] the number of bytes to output
/// [returns] the random octet sequence
Uint8List generateSecureEntropy(final int outputBytes) {
  final FortunaRandom random = FortunaRandom();
  random.seed(KeyParameter(Platform.instance.platformEntropySource().getBytes(32)));
  return random.nextBytes(outputBytes);
}

/// Computes equality of 2 byte arrays in constant-time.
/// Always use this when comparing crypto sequences to thwart timing attacks.
bool constantTimeComparison(final Uint8List a, final Uint8List b) {
  final int n = a.length;
  if (n != b.length) return false;

  var mismatch = 0;
  for (int i = 0; i < n; i++) {
    mismatch |= a[i] ^ b[i];
  }

  return mismatch == 0;
}
