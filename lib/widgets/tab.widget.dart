import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';

const _activeDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ],
  borderRadius: BorderRadius.all(Radius.circular(45.0)),
  color: AppTheme.primary,
);

final _unActiveDecoration = BoxDecoration(
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
  ],
  borderRadius: const BorderRadius.all(Radius.circular(45.0)),
  color: AppTheme.primary.withOpacity(0.75),
);

class PageTab extends StatelessWidget {
  const PageTab({
    Key? key,
    required this.text,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final bool isActive;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.0,
        height: 30.0,
        decoration: isActive ? _activeDecoration : _unActiveDecoration,
        child: Center(
          child: Text(
            text,
            style: AppTheme.textStyle,
          ),
        ),
      ),
    );
  }
}
