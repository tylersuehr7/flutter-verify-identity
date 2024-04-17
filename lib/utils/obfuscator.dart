abstract class Obfuscation {
  final String _passphrase;

  const Obfuscation(this._passphrase);

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
