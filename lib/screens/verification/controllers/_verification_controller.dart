part of '../verification_screen.dart';

const int _maxVerificationAttempts = 3;

final class _VerificationController extends Cubit<_VerificationState> {
  final VerificationService _verificationService = injector<VerificationService>();

  _VerificationController(): super(const _VerificationUninitialized());

  Future<void> initialize() async {
    if (state is! _VerificationUninitialized) {
      return;
    }

    emit(const _VerificationInitializing());

    try {
      final VerificationSettings settings = await _verificationService.getVerificationSettings();
      emit(_VerificationPending(settings: settings));
    } on MissingVerificationSettingsException {
      emit(const _NoVerificationSettings());
    } catch(ex) {
      emit(_VerificationFatalError(ex.toString()));
    }
  }

  void setPin(final TextEditingValue pin) {
    final dynamic state = this.state;
    if (state is _VerificationPending) {
      emit(state.copyWith(pin: pin));
    }
  }

  Future<void> verify() async {
    dynamic state = this.state;

    if (state is! _VerificationPending || state.isLoading) {
      return;
    }

    emit((state = state.copyWith(isLoading: true)));

    try {
      final String pin = state.pin.text.trim();
      await _verificationService.verifyIdentityByPin(pin);
      emit(const _VerificationSuccess());
    } on UnableToVerifyIdentityException {
      if (state.failedAttempts + 1 > _maxVerificationAttempts) {
        emit(const _VerificationLockout());
      } else {
        final int failedAttempts = state.failedAttempts;
        emit((state = state.copyWith(failedAttempts: failedAttempts + 1, isLoading: false)));
      }
    } catch(ex) {
      emit(_VerificationFatalError(ex.toString()));
    }
  }
}

sealed class _VerificationState extends Equatable {
  const _VerificationState();

  @override
  List<Object?> get props => [];

  bool get isSubmitButtonDisabled {
    final dynamic state = this;

    if (state is! _VerificationPending) {
      return true;
    }

    final String pin = state.pin.text.trim();
    return state.isLoading || pin.isEmpty || pin.length < 4;
  }
}

final class _VerificationUninitialized extends _VerificationState {
  const _VerificationUninitialized();
}

final class _VerificationInitializing extends _VerificationState {
  const _VerificationInitializing();
}

final class _NoVerificationSettings extends _VerificationState {
  const _NoVerificationSettings();
}

final class _VerificationFatalError extends _VerificationState {
  final String reason;

  const _VerificationFatalError(this.reason);

  @override
  List<Object> get props => [reason];
}

final class _VerificationPending extends _VerificationState {
  final VerificationSettings settings;
  final bool isLoading;
  final TextEditingValue pin;
  final int failedAttempts;

  const _VerificationPending({
    required this.settings,
    this.isLoading = false,
    this.pin = TextEditingValue.empty,
    this.failedAttempts = 0,
  });

  _VerificationPending copyWith({
    final VerificationSettings? settings,
    final bool? isLoading,
    final TextEditingValue? pin,
    final int? failedAttempts,
  }) {
    return _VerificationPending(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      pin: pin ?? this.pin,
      failedAttempts: failedAttempts ?? this.failedAttempts,
    );
  }

  @override
  List<Object?> get props => [
    settings,
    isLoading,
    pin,
    failedAttempts,
  ];
}

final class _VerificationSuccess extends _VerificationState {
  const _VerificationSuccess();
}

final class _VerificationLockout extends _VerificationState {
  const _VerificationLockout();
}
