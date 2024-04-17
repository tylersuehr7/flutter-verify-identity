import 'verification_data.dart';
import 'verification_mode.dart';

final class VerificationSettings {
  final VerificationMode mode;
  final VerificationData data;

  const VerificationSettings({
    required this.mode,
    required this.data,
  });
}
