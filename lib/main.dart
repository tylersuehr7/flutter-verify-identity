import 'package:demo_verify/application/application.dart';
import 'package:flutter/cupertino.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await prepareDependencies();
  Application.run();
}
