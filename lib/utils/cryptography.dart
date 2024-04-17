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
