import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/activity/activity_list_item.model.dart';
import 'package:dads_app/pages/album.page.dart';
import 'package:dads_app/utils/family.util.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:dads_app/widgets/activities_page/activity.widget.dart';
import 'package:dads_app/widgets/album_page/header.widget.dart';
import 'package:dads_app/widgets/modal.widget.dart';
import 'package:dads_app/widgets/tab.widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  static const String routeName = '/activities';

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final TextEditingController _activityController = TextEditingController();

  List<ActivityListItem> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  void _loadActivities() async {
    final List<ActivityListItem> _temp = await getFamilyActivities();

    setState(() {
      _activities = _temp;
    });
  }

  void createItem() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();

    final int _me = _storage.getInt('me') ?? 2;
    final int _family = _storage.getInt('family') ?? 2;

    final Map<String, dynamic> create = {
      'data': {
        'short': _activityController.text,
        'uploader': _me,
        'family': _family,
      }
    };

    try {
      await API.post(
        '/activities',
        create,
      );

      _loadActivities();
    } catch (e) {
      print(e);
    }
  }

  void addActivity() {
    showDialog(
      context: context,
      builder: (context) => Modal(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 180.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _activityController,
                  decoration: AppTheme.inputDecoration.copyWith(
                    label: const Text(
                      'Activity',
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text(
                        'Create',
                        style: TextStyle(color: AppTheme.primary),
                      ),
                      onPressed: () {
                        createItem();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              child: SizedBox(
                width: width,
                height: height * 0.7,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _activities.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    if (i == _activities.length - 1) {
                      return Column(
                        children: [
                          ActivityWidget(
                            id: _activities[i].id,
                            name: _activities[i].attributes.short,
                            done: _activities[i].attributes.done,
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      );
                    }
                    return ActivityWidget(
                      id: _activities[i].id,
                      name: _activities[i].attributes.short,
                      done: _activities[i].attributes.done,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addActivity(),
        child: const Icon(Icons.add),
        backgroundColor: AppTheme.primary,
      ),
    );
  }
}
