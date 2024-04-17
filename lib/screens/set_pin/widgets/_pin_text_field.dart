part of '../set_pin_screen.dart';

class _PinTextField extends StatelessWidget {
  const _PinTextField();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<_SetPinController, _SetPinState>(
      listener: (context, state) {
        // Close screen when a pin was set by user
        if (state.savedPin != null) {
          context.pop();
        }
      },
      builder: (context, state) {
        final TextEditingController pinController = TextEditingController.fromValue(state.newPin);
        return TextField(
          enabled: !state.isLoading,
          controller: pinController,
          keyboardType: const TextInputType.numberWithOptions(),
          textInputAction: TextInputAction.go,
          maxLength: 4,
          onChanged: (_) => context.read<_SetPinController>().setNewPin(pinController.value),
          onEditingComplete: () => context.read<_SetPinController>().setNewPin(pinController.value),
          decoration: const InputDecoration(
            hintText: "0000",
          ),
        );
      },
    );
  }
}
