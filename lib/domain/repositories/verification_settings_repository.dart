import '../models/verification_settings.dart';

abstract interface class IVerificationSettingsRepository {
  Future<VerificationSettings?> getVerificationSettings();
  Future<void> setVerificationSettings(VerificationSettings settings);
  Future<void> deleteVerificationSettings();
}
