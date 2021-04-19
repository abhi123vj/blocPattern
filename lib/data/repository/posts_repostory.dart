import 'package:hello_world/data/models/posts.dart';
import 'package:hello_world/data/services/posts_services.dart';

class PostsRepository{
  final PostsService service;
  PostsRepository(this.service);
  Future<List<Post>> fetchPosts(int page) async{
    final posts = await service.fetchPosts(page);
    return  posts.map((e) => Post.fromJson(e)).toList();
  }
 
}