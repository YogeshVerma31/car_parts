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
  final Icon? leadingIcon;
  final String? error;
  final Function()? onTap;
  final Function(String)? onTextChanged;

  const CustomInputField(
      {Key? key,
        required this.title,
        required this.hint,
        required this.readOnly,
        this.leadingIcon,
        this.onTap,
        this.textInputType,
        this.controller,
        this.widget,
        this.error,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 47,
            margin: const EdgeInsets.only(top: 1.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: primaryLightColor,
              border: Border.all(color: primaryLightColor, width: 1.0),
              borderRadius: BorderRadius.circular(30),
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
                            icon: leadingIcon ?? const SizedBox.shrink(),
                            hintStyle: subtitleStyle.copyWith(color: Colors.black),
                            errorText: error,
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: primaryLightColor, width: 0)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: primaryLightColor, width: 0))),
                      )),
                  widget == null
                      ? Container()
                      : Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(child: widget),
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
