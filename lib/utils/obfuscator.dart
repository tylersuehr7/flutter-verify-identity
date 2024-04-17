abstract class Obfuscator {
  final String raw;

  const Obfuscator(this.raw);

  /// Obfuscates the underlying passphrase.
  ///
  /// [returns] obfuscated passphrase
  String obfuscate();

  /// Verifies the given obfuscated data with passphrase.
  ///
  /// [obfuscated] the obfuscated data to test against
  /// [returns] true if matches; otherwise false
  bool verify(final String obfuscated);
}
