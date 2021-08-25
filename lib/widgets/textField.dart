import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final InputDecoration? decoration;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator? validate;

  const TextfieldWidget({Key? key, this.controller, this.hintText, this.labelText, this.decoration, this.obscureText, this.keyboardType, this.validate}) : super(key: key);



  @override
  _TextfieldWidgetState createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validate,
      controller: widget.controller,
      obscureText: widget.obscureText!,
      keyboardType: widget.keyboardType,
      decoration: widget.decoration
    );
  }
}
