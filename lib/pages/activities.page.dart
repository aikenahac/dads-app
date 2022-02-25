import 'package:dads_app/pages/album.page.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:dads_app/widgets/album_page/header.widget.dart';
import 'package:dads_app/widgets/tab.widget.dart';
import 'package:flutter/material.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  static const String routeName = '/activities';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppTheme.secondary,
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PageTab(
                    text: 'Album',
                    isActive: false,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(AlbumPage.routeName);
                    },
                  ),
                  PageTab(
                    text: 'Activities',
                    isActive: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Header(
              title: 'Your activities',
              description: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Activities you\'d like to do with',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'your family',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
