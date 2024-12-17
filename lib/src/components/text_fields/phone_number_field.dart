import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mra/src/res/values/constants/app_values.dart';

typedef Validator = String? Function(String? input);
typedef OnSubmit = void Function(String? input);

class CustomPhoneNumberTextField extends StatefulWidget {
  const CustomPhoneNumberTextField(
      {super.key, this.textController, this.validator, this.onSubmit});
  final TextEditingController? textController;
  final Validator? validator;
  final OnSubmit? onSubmit;

  @override
  State<CustomPhoneNumberTextField> createState() =>
      _CustomPhoneNumberTextFieldState();
}

class _CustomPhoneNumberTextFieldState
    extends State<CustomPhoneNumberTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: k585666,
      controller: widget.textController,
      validator: widget.validator,
      onSaved: widget.onSubmit,
      keyboardType: const TextInputType.numberWithOptions(),
      style: Theme.of(context).textTheme.bodyMedium,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
