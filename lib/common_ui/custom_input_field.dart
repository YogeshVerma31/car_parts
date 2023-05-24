import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/styles.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool readOnly;
  final Color? labelColor;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Function()? onTap;
  final Function(String)? onTextChanged;

  const CustomInputField(
      {Key? key,
        required this.title,
        required this.hint,
        required this.readOnly,
        this.onTap,
        this.textInputType,
        this.controller,
        this.widget,
        this.onTextChanged,
        this.obscureText,
        this.labelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Text(
              title,
              style: titleStyle.copyWith(
                  color: labelColor ?? Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ),
          Container(
            height: 47,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor, width: 1.0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: readOnly,
                        autofocus: false,
                        keyboardType: textInputType,
                        cursorColor: Colors.black,
                        onChanged: onTextChanged,
                        controller: controller,
                        obscureText: obscureText ?? false,
                        style: subtitleStyle.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: subtitleStyle,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: borderColor, width: 0)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: borderColor, width: 0))),
                      )),
                  widget == null
                      ? Container()
                      : Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: widget,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
