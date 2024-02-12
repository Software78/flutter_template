import 'dart:convert';
import 'package:dio/dio.dart' as dio_http;
import 'package:flutter/material.dart';
import 'package:fluttersanctum/dio.dart';
import 'package:fluttersanctum/models/post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => PostsState();
}

class PostsState extends State<PostScreen> {
  Future<List<Post>> getPosts() async {
    dio_http.Response response = await dio.get(
      '/user/posts',
    );
    List posts = json.decode(response.toString());

    return posts.map((post) => Post.fromJson(post)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text('Posts'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].title),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Text('Failed to load posts');
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
