import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  PasswordFormField({
    Key key,
    this.initialValue,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  final String initialValue;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController c;
  bool _obscureText = true;

  test() {
    key.currentState.validate();
  }
  @override
  Widget build(BuildContext context) => TextFormField(
    key: key,
    initialValue: widget.initialValue,
    obscureText: _obscureText,
    validator: widget.validator,
    onSaved: widget.onSaved,
    onFieldSubmitted: (s){print('onFieldSubmitted: $s');},
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
           _obscureText = !_obscureText; 
          });
        },
      )
    ),
  );
}
