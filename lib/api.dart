import 'dart:convert';

import 'package:http/http.dart' as http;
import 'post.dart';

class Api {
  static const baseUrl = 'https://jsonplaceholder.typicode.com/';

  final http.Client _client = http.Client();

  Future<List<Post>> posts() async {
    final arrayOfPostMaps = await _get('posts');

    // generic array of generic map objects, mapped to List of Post objects.
    List<Post> posts = arrayOfPostMaps.map<Post>((postMap) =>
        Post.fromMap(postMap)
    ).toList();
    return posts;
  }
  
  Future<dynamic> _get(String endpoint, {Map<String, String> headers}) async {
    final response = await _client.get(baseUrl + endpoint, headers: headers);
    _throwExceptionOnInvalid(response);
    final collection = jsonDecode(response.body);
    return collection;
  }

  void _throwExceptionOnInvalid(final http.Response response) {
    if (!(response.statusCode > 199 && response.statusCode < 300)) {
      throw Exception("Error ${response.statusCode} ${response.request}");
    }
  }
}
