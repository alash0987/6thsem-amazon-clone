import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String hintText;
  final int maxline;
  CustomTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.maxline = 1,
      required this.hintText});
  final String title;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.title,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxline,
    );
  }
}
