import 'package:flutter/material.dart';

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({
    Key? key,
    this.leading,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  final Widget? leading;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null)
            leading!,
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 24.0),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
