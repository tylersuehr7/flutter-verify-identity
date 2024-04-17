part of '../verification_screen.dart';

class _VerificationFatalErrorView extends StatelessWidget {
  final String message;

  const _VerificationFatalErrorView(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message, style: const TextStyle(color: Colors.red)));
  }
}
