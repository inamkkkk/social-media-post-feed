import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_feed/screens/feed_screen.dart';
import 'package:social_media_feed/services/post_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => PostService(),
      child: MaterialApp(
        title: 'Social Media Feed',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedScreen(),
      ),
    );
  }
}
