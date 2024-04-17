part of '../set_pin_screen.dart';

final class _SetPinController extends Cubit<_SetPinState> {
  final VerificationService _verificationService = injector<VerificationService>();

  _SetPinController(): super(const _SetPinState());

  void setNewPin(final TextEditingValue newPin) {
    emit(state.copyWith(newPin: newPin));
  }

  Future<void> usePin() async {
    if (state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true));

    final String pin = state.newPin.text.trim();
    await _verificationService.configurePin(pin);

    emit(state.setSavedPin(pin));
  }
}

final class _SetPinState extends Equatable {
  final TextEditingValue newPin;
  final bool isLoading;
  final String? savedPin;

  const _SetPinState({
    this.newPin = TextEditingValue.empty,
    this.isLoading = false,
    this.savedPin,
  });

  @override
  List<Object?> get props => [
    newPin,
    isLoading,
    savedPin,
  ];

  _SetPinState copyWith({
    final TextEditingValue? newPin,
    final bool? isLoading,
  }) {
    return _SetPinState(
      newPin: newPin ?? this.newPin,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  _SetPinState setSavedPin(final String savedPin) {
    return _SetPinState(
      newPin: newPin,
      isLoading: false,
      savedPin: savedPin,
    );
  }

  bool get isSubmitButtonDisabled {
    final String pin = newPin.text.trim();
    return pin.isEmpty || pin.length < 4 || isLoading;
  }
}
