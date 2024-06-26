import 'package:demo_verify/domain/exceptions/missing_verification_settings_exception.dart';
import 'package:demo_verify/domain/exceptions/unable_to_verify_identity_exception.dart';
import 'package:demo_verify/domain/models/identity.dart';
import 'package:demo_verify/domain/models/verification_mode.dart';
import 'package:demo_verify/domain/models/verification_settings.dart';
import 'package:demo_verify/domain/repositories/verification_settings_repository.dart';
import 'package:demo_verify/utils/obfuscator.dart';

final class VerificationService {
  final IVerificationSettingsRepository _verificationSettingsRepo;
  final Obfuscator _obfuscator;

  const VerificationService(this._verificationSettingsRepo, this._obfuscator);

  Future<VerificationSettings> getVerificationSettings() async {
    final VerificationSettings? settings = await _verificationSettingsRepo.getVerificationSettings();

    if (settings == null) {
      throw const MissingVerificationSettingsException();
    }

    return settings;
  }

  Future<void> configurePin(final String pin) async {
    final String hashedPin = _obfuscator.obfuscate(pin);

    final VerificationSettings settings = VerificationSettings(
      mode: VerificationMode.pin,
      data: hashedPin,
    );

    await _verificationSettingsRepo.setVerificationSettings(settings);
  }

  Future<void> clearPin() async {
    await _verificationSettingsRepo.deleteVerificationSettings();
  }

  Future<void> verifyIdentityByUsername(final String username, final String password) async {
    // Note: no authentication system was prepared, so just compare
    // password to a fake one for the purpose of this demonstration
    if (username != defaultUser.username || password != "abc123") {
      throw const UnableToVerifyIdentityException();
    }
  }

  Future<void> verifyIdentityByPin(final String pin) async {
    final VerificationSettings settings = await getVerificationSettings();

    if (VerificationMode.pin != settings.mode) {
      throw const UnableToVerifyIdentityException();
    }

    if (!_obfuscator.verify(settings.data, pin)) {
      throw const UnableToVerifyIdentityException();
    }
  }
}
