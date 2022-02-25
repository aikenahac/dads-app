import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';

final _doneStyle = AppTheme.textStyle.copyWith(
  fontWeight: FontWeight.w600,
  color: Colors.grey[600],
  decoration: TextDecoration.lineThrough,
);

final _notDoneStyle = AppTheme.textStyle.copyWith(
  fontWeight: FontWeight.w600,
);

final _itemDecoration = BoxDecoration(
  gradient: AppTheme.gradient,
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      offset: Offset(0.0, 10.0),
    ),
  ],
);

class ActivityWidget extends StatefulWidget {
  const ActivityWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.done,
  }) : super(key: key);

  final int id;
  final String name;
  final bool done;

  @override
  State<ActivityWidget> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {
  bool _bought = false;
  String _name = '';

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    setState(() {
      _bought = widget.done;
      _name = widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: _itemDecoration,
          width: width * 0.8,
          height: height * 0.06,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
    );
  }
}
