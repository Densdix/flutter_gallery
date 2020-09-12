import 'package:flutter_gallery/ui/model/photo.dart';
import 'package:http/http.dart' as http;

class Parser {

  static const String url = 'http://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

  static Future<List<Photo>> getPhotos()async {
    // This example uses the Google Books API to search for books about http.
    // https://developers.google.com/books/docs/overview
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List<Photo> photos = photoFromJson(response.body);
      print('Parsing success');
      return photos;

    } else {
      print('Request failed with status: ${response.statusCode}.');
      return List<Photo>();
    }
  }

}