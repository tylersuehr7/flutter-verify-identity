abstract class Obfuscator {
  /// Obfuscates the underlying passphrase.
  ///
  /// [raw] the passphrase to be hashed
  ///
  /// [returns] obfuscated passphrase
  String obfuscate(String raw);

  /// Verifies the given obfuscated data with passphrase.
  ///
  /// [obfuscated] the obfuscated data to test against
  /// [raw] the passphrase to be verified
  ///
  /// [returns] true if matches; otherwise false
  bool verify(String obfuscated, String raw);
}
