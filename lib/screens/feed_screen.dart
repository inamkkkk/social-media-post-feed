import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_feed/models/post.dart';
import 'package:social_media_feed/services/post_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostService>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Feed'),
      ),
      body: Consumer<PostService>(
        builder: (context, postService, child) {
          if (postService.posts.isEmpty && !postService.isLoading) {
            return Center(child: Text('No posts available.'));
          }
          if (postService.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: postService.posts.length,
            itemBuilder: (context, index) {
              final post = postService.posts[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.user.profileImageUrl),
                ),
                SizedBox(width: 8.0),
                Text(post.user.username, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl: post.imageUrl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200.0, // Fixed height for performance
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.text),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              DateFormat('MMM d, yyyy hh:mm a').format(post.timestamp),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
