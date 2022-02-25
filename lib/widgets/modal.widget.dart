import 'package:flutter/material.dart';

// Customized popup dialog widget
class Modal extends StatelessWidget {
  const Modal({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: SizedBox(
        width: double.infinity,
        child: body,
      ),
    );
  }
}
