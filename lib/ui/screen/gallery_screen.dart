import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gallery/ui/model/photo.dart';
import 'package:flutter_gallery/ui/screen/photo_screen.dart';
import 'package:flutter_gallery/ui/service/parser.dart';

class Gallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> with SingleTickerProviderStateMixin {
  List<Photo> _photos = List<Photo>();
  bool _loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? "Loading..." : "Gallery"),
        ),
        body: Container(
          child: _buildGridView(context),
        ));
  }

  Widget _buildGridView(BuildContext context){
    return GridView.count(
        crossAxisCount: 2,
      children: List.generate(_photos.length, (index) {
        Photo photo = _photos[index];
        return Card(
          child: Material(
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PhotoPage(url: photo.urls.full)));
              },
              child: GridTile(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: photo.urls.small,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                footer: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                  child: ListTile(
                    title: Text(photo.id, style: TextStyle(color: Colors.white.withOpacity(0.9), shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ]),),
                    subtitle: Text(photo.user.name, style: TextStyle(color: Colors.white.withOpacity(0.7), shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ])),
                  ),
                ),
              ),
            ),
          )
        );
      }),
    );
  }

  // other style using ListView
  Widget _buildListView() {
    return ListView.builder(
        itemBuilder: (context, index) {
          Photo photo = _photos[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Card(
              elevation: 12,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(16.0)),
              child: Column(
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: photo.urls.small,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  ListTile(
                    title: Text(photo.id),
                    subtitle: Text(photo.user.name),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _photos == null ? 0 : _photos.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    Parser.getPhotos().then((photos) {
      setState(() {
        _photos = photos;
        _loading = false;
        debugPrint(_photos.length.toString());
      });
    });
  }
}
