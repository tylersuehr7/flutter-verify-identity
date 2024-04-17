import 'package:demo_verify/domain/models/verification_data.dart';
import 'package:demo_verify/domain/models/verification_mode.dart';
import 'package:demo_verify/domain/models/verification_settings.dart';
import 'package:demo_verify/domain/repositories/verification_settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _keyMode = "mode";
const String _keySalt = "salt";
const String _keyData = "data";

class SharedPreferencesVerificationSettingsRepository implements IVerificationSettingsRepository {
  final SharedPreferences preferences;

  const SharedPreferencesVerificationSettingsRepository(this.preferences);

  @override
  Future<VerificationSettings?> getVerificationSettings() async {
    final String? modeStr = preferences.getString(_keyMode);
    final String? saltStr = preferences.getString(_keySalt);
    final String? dataStr = preferences.getString(_keyData);

    if (modeStr == null || saltStr == null || dataStr == null) {
      return null;
    }

    final VerificationMode mode = VerificationMode.values.firstWhere((e) => e.name == modeStr);
    final VerificationData data = VerificationData(salt: saltStr, data: dataStr);

    return VerificationSettings(mode: mode, data: data);
  }

  @override
  Future<void> setVerificationSettings(VerificationSettings settings) async {
    await Future.wait([
      preferences.setString(_keyMode, settings.mode.name),
      preferences.setString(_keySalt, settings.data.salt),
      preferences.setString(_keyData, settings.data.data),
    ]);
  }

  @override
  Future<void> deleteVerificationSettings() async {
    await Future.wait([
      preferences.remove(_keyMode),
      preferences.remove(_keySalt),
      preferences.remove(_keyData),
    ]);
  }
}
