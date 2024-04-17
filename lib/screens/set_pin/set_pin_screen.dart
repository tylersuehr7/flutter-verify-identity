import 'package:demo_verify/domain/services/verification_service.dart';
import 'package:demo_verify/injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'controllers/_set_pin_controller.dart';
part 'widgets/_description_text.dart';
part 'widgets/_pin_text_field.dart';

class SetPinScreen extends StatelessWidget {
  static final String screenName = (SetPinScreen).toString();

  const SetPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<_SetPinController>(
      create: (_) => _SetPinController(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Set a Pin")),
        bottomNavigationBar: SafeArea(
          child: ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<_SetPinController, _SetPinState>(
                builder: (context, state) => FilledButton(
                  onPressed: state.isSubmitButtonDisabled ? null : context.read<_SetPinController>().usePin,
                  child: const Text("Use"),
                ),
              ),
            ],
          ),
        ),
        body: const SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _DescriptionText(),
                  _PinTextField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
