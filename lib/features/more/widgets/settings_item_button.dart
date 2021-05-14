import 'package:flutter/material.dart';

class SettingsItemButton extends StatelessWidget {
  const SettingsItemButton({
    required Key key,
    required this.text,
    this.secondaryText,
    required this.onPressed
  }) : super(key: key);
  final String text;
  final String? secondaryText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black
                  ),
                ),
                if (secondaryText != null)
                  Text(
                    secondaryText ?? 'No subtitle',
                    style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
