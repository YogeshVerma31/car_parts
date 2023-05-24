import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningDialogBox extends StatefulWidget {
  /// Creates a widget combines of  [Container].
  /// [title], [descriptions], [onPressed] must not be null.
  ///
  /// This widget will return dialog to show warning.
  /// For e.g. when user tap on report user icon will show [WarningDialogBox] to warn user about the action.
  const WarningDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.disableButtonTitle,
      this.singleButton = false,
      this.onPressed,
      this.buttonColor = '',
      this.enableButtonTitle})
      : super(key: key);

  final String? title,
      descriptions,
      enableButtonTitle,
      disableButtonTitle,
      buttonColor;
  final bool? singleButton;
  final Function(String)? onPressed;

  @override
  _WarningDialogBoxState createState() => _WarningDialogBoxState();
}

class _WarningDialogBoxState extends State<WarningDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  Stack contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _addSpacing,
              _addSpacing,
              _getTitleLabel,
              _getDescription,
              _addSpacing,
              _showEnableButton,
            ],
          ),
        ),
      ],
    );
  }

  Text get _getTitleLabel {
    return Text(widget.title!,);
  }

  InkWell get _showEnableButton {
    return InkWell(
      onTap: () =>
          {Navigator.pop(context), widget.onPressed!(widget.enableButtonTitle!)},
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(widget.enableButtonTitle! ,
        ),
      ),
    );
  }

  InkWell get _showDisableButton {
    return InkWell(
      onTap: () => {Navigator.pop(context)},
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text( widget.disableButtonTitle!),
        ),
      );
  }

  Container get _getDescription {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Text(widget.descriptions!),
    );
  }

  SizedBox get _addSpacing {
    return const SizedBox(
      height: 10,
    );
  }

}
