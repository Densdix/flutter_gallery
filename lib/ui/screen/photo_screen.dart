import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final String url;

  const PhotoPage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Page"),
      ),
      body: Container(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) =>
              CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

}