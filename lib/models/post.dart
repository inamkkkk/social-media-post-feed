import 'package:social_media_feed/models/user.dart';

class Post {
  final String id;
  final User user;
  final String text;
  final String imageUrl;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.user,
    required this.text,
    required this.imageUrl,
    required this.timestamp,
  });
}
