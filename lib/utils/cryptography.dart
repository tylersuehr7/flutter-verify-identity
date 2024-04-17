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

/// Quick data copy from src array to another.
///
/// [src] the source array to be copied from
/// [srcOffset] the offset from which to start reading src
/// [srcLength] the length of data to read from src
/// [dest] the destination array to be written to
/// [destOffset] the offset from which to start writing dest
///
/// [throws] RangeError if dest not large enough to be written into
void arrayCopy(
  final Uint8List src,
  final int srcOffset,
  final int srcLength,
  final Uint8List dest,
  final int destOffset,
) {
  final int iterations = srcOffset + srcLength;

  int i = srcOffset;
  int j = destOffset;

  for (; i < iterations; i++, j++) {
    dest[j] = src[i];
  }
}

/// Quick data concatenation of multiple arrays.
///
/// [data] the arrays to be concatenated
/// [returns] the concatenated array
Uint8List arrayConcat(final List<Uint8List> data) {
  int totalLength = 0;
  for (final Uint8List array in data) {
    totalLength += array.length;
  }

  final Uint8List buffer = Uint8List(totalLength);

  int offset = 0;
  for (final Uint8List array in data) {
    arrayCopy(array, 0, array.length, buffer, offset);
    offset += array.length;
  }

  return buffer;
}

/// Quick data memory reset for an array.
///
/// [src] the array whose contents to be reset
/// [fill] the data to fill array with
void arrayMemset(final Uint8List src, final int fill) {
  for (int i = 0; i < src.length; i++) {
    src[i] = fill;
  }
}
