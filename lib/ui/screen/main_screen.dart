import 'package:flutter/material.dart';

import 'gallery_screen.dart';

class GalleryApp extends StatelessWidget {
  final theme = ThemeData(
    fontFamily: "GoogleSans",
    primaryColor: Colors.amber,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gallery",
      theme: theme,
      home: Gallery(),
    );
  }
}
