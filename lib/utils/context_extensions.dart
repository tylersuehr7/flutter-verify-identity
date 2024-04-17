import 'package:demo_verify/screens/verification/verification_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension IdentityContextExtensions on BuildContext {

  void verifyAndGoNamed(final String name, {
    final Map<String, String> pathParameters = const <String, String>{},
    final Map<String, dynamic> queryParameters = const <String, dynamic>{},
    final Object? extra,
  }) {
    goNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: namedLocation(
          name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        ),
        extra: extra,
      ),
    );
  }

  void verifyAndGo(final String location, {
    final Object? extra,
  }) {
    goNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: location,
        extra: extra,
      ),
    );
  }

  void verifyAndPushNamed(final String name, {
    final Map<String, String> pathParameters = const <String, String>{},
    final Map<String, dynamic> queryParameters = const <String, dynamic>{},
    final Object? extra,
  }) {
    pushNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: namedLocation(
          name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        ),
        extra: extra,
      ),
    );
  }

  void verifyAndPush(final String location, {
    final Object? extra,
  }) {
    pushNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: location,
        extra: extra,
      ),
    );
  }

  void verifyAndReplaceNamed(final String name, {
    final Map<String, String> pathParameters = const <String, String>{},
    final Map<String, dynamic> queryParameters = const <String, dynamic>{},
    final Object? extra,
  }) {
    replaceNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: namedLocation(
          name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
        ),
        extra: extra,
      ),
    );
  }

  void verifyAndReplace(final String location, {
    final Object? extra,
  }) {
    replaceNamed(
      VerificationScreen.screenName,
      extra: VerificationScreenArgs(
        location: location,
        extra: extra,
      ),
    );
  }

}
