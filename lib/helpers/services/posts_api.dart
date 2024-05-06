import 'package:flutter/material.dart';

import '../../vaahextendflutter/services/api.dart';

//for testing Api class from vaah flutter
class PostsApi {
  static const String apiEndPoint = '/';
  static Map<String, dynamic>? fetchedPosts;

  static Future<void> fetchPosts() async {
    try {
      Map<String, dynamic>? posts = await Api.ajax(
        url: apiEndPoint,
        method: RequestMethod.get,
        alertType: AlertType.toast,
        onStart: () async {
          debugPrint('Fetching posts...');
        },
        onCompleted: () async {
          debugPrint('Posts fetched successfully!');
        },
        onError: (error) async {
          debugPrint('Error fetching posts: $error');
        },
      );

      if (posts != null) {
        //debugPrint('User data: $posts');
        fetchedPosts = posts;
      } else {
        debugPrint('Failed to fetch user data.');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }
}
