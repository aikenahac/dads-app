import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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
  bool _done = false;
  String _name = '';

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() {
    setState(() {
      _done = widget.done;
      _name = widget.name;
    });
  }

  void _updateBought(bool value) async {
    final Map<String, dynamic> updateItem = {
      'data': {'done': value}
    };

    try {
      setState(() {
        _done = value;
      });

      await API.put(
        '/activities/${widget.id}',
        updateItem,
      );
    } catch (e) {
      print(e);
    }
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
              children: [
                Checkbox(
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppTheme.primary;
                    }

                    return Colors.grey[400];
                  }),
                  shape: const CircleBorder(),
                  value: _done,
                  onChanged: (bool? value) => _updateBought(value!),
                ),
                _name.length < 35
                    ? Text(
                        _name,
                        style: _done ? _doneStyle : _notDoneStyle,
                      )
                    : SizedBox(
                        width: width * 0.6,
                        child: Marquee(
                          text: _name,
                          style: _done ? _doneStyle : _notDoneStyle,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
