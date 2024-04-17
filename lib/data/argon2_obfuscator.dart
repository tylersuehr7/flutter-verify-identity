import 'dart:convert';
import 'dart:typed_data';

import 'package:demo_verify/utils/cryptography.dart';
import 'package:demo_verify/utils/obfuscator.dart';
import 'package:pointycastle/export.dart';

/// [Obfuscator] for making pins cryptographically unreadable.
///
/// This implementation specifically uses the Argon2 algorithm due
/// to it being the state of the art in the design of memory-hard
/// functions.
class Argon2Obfuscator extends Obfuscator {
  static const int _keyBitsOut = 256;
  static const int _keyBytesOut = _keyBitsOut ~/ 8;
  static const int _nonceBytes = 32;
  static const int _magicByte = 0xA3;

  const Argon2Obfuscator(super._raw);

  @override
  String obfuscate() {
    final Uint8List nonce = generateSecureEntropy(_nonceBytes);
    final Uint8List packed = _rawObfuscateWithArgon2(nonce);
    return base64Encode(packed);
  }

  @override
  bool verify(String obfuscated) {
    final Uint8List verifiedPacked = base64Decode(obfuscated);

    if (verifiedPacked.length < _nonceBytes || verifiedPacked[0] != _magicByte) {
      throw StateError("Corrupted or invalid obfuscated data!");
    }

    // Extract the nonce from the obfuscated packed data
    final Uint8List nonce = Uint8List(_nonceBytes);
    for (int offset = 1; offset < _nonceBytes + 1; offset++) {
      nonce[offset] = verifiedPacked[offset];
    }

    final Uint8List unverifiedPacked = _rawObfuscateWithArgon2(nonce);

    return constantTimeComparison(verifiedPacked, unverifiedPacked);
  }

  /// Performs obfuscation on underlying passphrase.
  ///
  /// [nonce] the nonce to use in obfuscation
  /// [returns] the obfuscated data
  Uint8List _rawObfuscateWithArgon2(final Uint8List nonce) {
    final Uint8List encodedRaw = utf8.encode(raw);

    final Uint8List derivedResult = (KeyDerivator("argon2")..init(
        Argon2Parameters(
          Argon2Parameters.ARGON2_i,
          nonce,
          iterations: 32,
          lanes: 2,
          desiredKeyLength: _keyBytesOut,
        )
    )).process(encodedRaw);

    final Uint8List packed = Uint8List(nonce.length + derivedResult.length + 1);
    packed.add(_magicByte);
    packed.addAll(nonce);
    packed.addAll(derivedResult);

    return packed;
  }
}
