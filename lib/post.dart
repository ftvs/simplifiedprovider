import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final int userId;
  final String title;

  Post({this.id, this.userId, this.title});

  factory Post.fromMap(final Map<String, dynamic> map) => _$PostFromJson(map);
}