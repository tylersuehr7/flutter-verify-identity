import 'package:demo_verify/data/argon2_obfuscator.dart';
import 'package:demo_verify/data/shared_preferences_verification_settings_repository.dart';
import 'package:demo_verify/domain/repositories/verification_settings_repository.dart';
import 'package:demo_verify/domain/services/verification_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt injector = GetIt.instance;

Future<void> prepareDependencies() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final verificationSettingsRepo = SharedPreferencesVerificationSettingsRepository(preferences);
  final verificationService = VerificationService(verificationSettingsRepo, Argon2Obfuscator());

  injector.registerSingleton<IVerificationSettingsRepository>(verificationSettingsRepo);
  injector.registerSingleton<VerificationService>(verificationService);
}
