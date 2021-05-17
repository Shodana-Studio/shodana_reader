import 'package:flutter/material.dart';
// Taken from settings_ui package and modified
class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({
    Key? key,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.maxLines,
    this.subtitlePadding = const EdgeInsets.only(
      left: 15.0,
      right: 15.0,
      bottom: 6.0,
    ),
    this.titlePadding = const EdgeInsets.only(
      left: 15.0,
      right: 15.0,
      bottom: 6.0,
    ),
  }) : super(key: key);

  final String? title;
  final EdgeInsetsGeometry titlePadding;
  final Widget? subtitle;
  final TextStyle? titleTextStyle;
  final int? maxLines;
  final EdgeInsetsGeometry subtitlePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 6.0,
              ),
              child: Text(
                title!,
                style: titleTextStyle ??
                    TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (subtitle != null) ... [
            Padding(
              padding: subtitlePadding,
              child: subtitle,
            ),
          ]
        ]
      ),
    );
  }
}
