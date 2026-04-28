import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? title;
  final Color? titleColor;
  final int? minLines;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function(String)? onChanged;
  final VoidCallback? onSubmitted;

  const CustomTextField({
    super.key,
    this.title,
    this.focusNode,
    this.hintText,
    this.nextFocusNode,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.titleColor,
    this.controller,
    this.obscure,
    this.suffixIcon,
    this.readOnly,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: TextStyle(color: titleColor)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscure ?? false,
          focusNode: focusNode,
          readOnly: readOnly ?? false,
          keyboardType: TextInputType.text,
          minLines: minLines,
          maxLines: obscure == true ? 1 : maxLines,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            fillColor: Colors.grey.shade300,
            filled: true,
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 0.5),
            ),
          ),
          textInputAction: nextFocusNode == null
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: (_) {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
              onSubmitted?.call();
            }
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
