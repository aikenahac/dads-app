import 'package:dads_app/api/api.client.dart';
import 'package:dads_app/models/album/album_photo.model.dart';
import 'package:dads_app/pages/activities.page.dart';
import 'package:dads_app/utils/family.util.dart';
import 'package:dads_app/utils/theme.util.dart';
import 'package:dads_app/widgets/album_page/header.widget.dart';
import 'package:dads_app/widgets/album_page/photo.widget.dart';
import 'package:dads_app/widgets/modal.widget.dart';
import 'package:dads_app/widgets/tab.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({Key? key}) : super(key: key);

  static const routeName = '/album';

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  final ImagePicker _picker = ImagePicker();

  List<AlbumPhoto> _album = [];

  @override
  void initState() {
    super.initState();
    _loadAlbum();
  }

  void _loadAlbum() async {
    final List<AlbumPhoto> _temp = await getFamilyAlbum();

    setState(() {
      _album = _temp;
    });
  }

  void _uploadImage(String type) async {
    final XFile? _image;
    if (type == 'gallery') {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    } else if (type == 'camera') {
      _image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      _image = await _picker.pickImage(source: ImageSource.gallery);
    }

    if (_image != null) {
      await API.postPhoto('/upload', _image);

      _loadAlbum();
    }
  }

  void enlargePhoto(height, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Modal(
        body: Image.network(
          imageUrl,
          fit: BoxFit.contain,
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
                child: _album.isNotEmpty
                    ? GridView.count(
                        mainAxisSpacing: 7.0,
                        crossAxisSpacing: 7.0,
                        crossAxisCount: 3,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                          _album.length,
                          (i) {
                            return GestureDetector(
                              onTap: () => enlargePhoto(
                                height,
                                API.baseUrl + _album[i].image.url,
                              ),
                              child: PhotoWidget(
                                image: API.baseUrl + _album[i].image.url,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        overlayOpacity: 0.0,
        backgroundColor: AppTheme.primary,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            label: 'Camera',
            child: const Icon(Icons.photo_camera_outlined),
            onTap: () => _uploadImage('camera'),
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
          ),
          SpeedDialChild(
            label: 'Gallery',
            child: const Icon(Icons.photo),
            onTap: () => _uploadImage('gallery'),
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
