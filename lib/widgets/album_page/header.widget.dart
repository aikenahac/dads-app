import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final Widget description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.textStyle.copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        description,
      ],
    );
  }
}
