import 'verification_mode.dart';

final class VerificationSettings {
  final VerificationMode mode;
  final String data;

  const VerificationSettings({
    required this.mode,
    required this.data,
  });
}
