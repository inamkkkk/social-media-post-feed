import 'package:flutter/material.dart';
import 'package:social_media_feed/models/post.dart';
import 'package:social_media_feed/models/user.dart';
import 'dart:math';

class PostService extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // Generate dummy data
    _posts = _generateDummyPosts(20);

    _isLoading = false;
    notifyListeners();
  }

  List<Post> _generateDummyPosts(int count) {
    List<Post> dummyPosts = [];
    final random = Random();

    for (int i = 0; i < count; i++) {
      final userId = 'user_$i';
      final user = User(
        id: userId,
        username: 'User $i',
        profileImageUrl: 'https://picsum.photos/id/${i + 10}/50/50',
      );

      final postId = 'post_$i';
      final post = Post(
        id: postId,
        user: user,
        text: 'This is a dummy post $i.  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        imageUrl: 'https://picsum.photos/id/${i + 1}/600/400',
        timestamp: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      );

      dummyPosts.add(post);
    }

    return dummyPosts;
  }
}
