import 'package:flutter/material.dart';

class TextButtonWithDetail extends StatelessWidget {
  const TextButtonWithDetail({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final Widget? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        subtitle: subtitle,
      ),
    );
  }
}
