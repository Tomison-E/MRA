import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef Validator = String? Function(String? input);
typedef OnSubmit = void Function(String? input);

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField(
      {Key? key, this.textController, required this.validator, this.onSubmit})
      : super(key: key);
  final TextEditingController? textController;
  final Validator validator;
  final OnSubmit? onSubmit;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: k585666,
      obscureText: _obscureText,
      controller: widget.textController,
      validator: widget.validator,
      onSaved: widget.onSubmit,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: SvgPicture.asset(
              _obscureText ? kShowPasswordSvg : kHidePasswordSvg,),
        ),
      ),
    );
  }
}
