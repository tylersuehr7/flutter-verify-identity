import 'package:demo_verify/domain/models/verification_settings.dart';
import 'package:demo_verify/domain/repositories/verification_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesVerificationSettingsRepository implements IVerificationSettingsRepository {
  final SharedPreferences preferences;

  const SharedPreferencesVerificationSettingsRepository(this.preferences);

  @override
  Future<VerificationSettings?> getVerificationSettings() {
    // TODO: implement getVerificationSettings
    throw UnimplementedError();
  }

  @override
  Future<void> setVerificationSettings(VerificationSettings settings) {
    // TODO: implement saveVerificationSettings
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVerificationSettings() {
    // TODO: implement deleteVerificationSettings
    throw UnimplementedError();
  }
}
