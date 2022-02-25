import 'package:dads_app/pages/activities.page.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:dads_app/widgets/album_page/header.widget.dart';
import 'package:dads_app/widgets/album_page/photo.widget.dart';
import 'package:dads_app/widgets/tab.widget.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                    isActive: true,
                    onTap: () {},
                  ),
                  PageTab(
                    text: 'Activities',
                    isActive: false,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(ActivitiesPage.routeName);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Header(
              title: 'Family album',
              description: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Pictures of your loved ones.',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                    const TextSpan(text: '\n'),
                    TextSpan(
                      text: 'In one ',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: 'space.',
                      style: AppTheme.textStyle.copyWith(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: width,
                height: height * 0.7,
                child: GridView.count(
                  mainAxisSpacing: 7.0,
                  crossAxisSpacing: 7.0,
                  crossAxisCount: 3,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(
                    10,
                    (index) {
                      return const PhotoWidget(
                        image: 'https://upload.wikimedia.org/wikipedia/commons/d/df/Family_Portrait.jpg',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
