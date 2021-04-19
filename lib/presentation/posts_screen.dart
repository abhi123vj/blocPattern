import 'dart:async';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/cubit/posts_cubit.dart';
import 'package:hello_world/data/models/posts.dart';

class PostsView extends StatelessWidget {
  final scrollController =  ScrollController();

  void setupScrollController(context){
    scrollController.addListener(() {
      if(scrollController.position.atEdge){
        if(scrollController.position.pixels!=0){
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    setupScrollController(context);

    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
     appBar: AppBar(
       title: Text("Posts"),
       ),
       body: _postsLists(scrollController),
    );
  }
}
Widget _postsLists(scrollController){
  return  BlocBuilder<PostsCubit,PostsState>(
    builder: (context,state){
     if(state is PostsLoading && state.isFirstFetch){
      return _loadingIndicator();
    }
    List<Post> posts = [];
    bool isLoading = false;
    if (state is PostsLoading){
      posts = state.oldPosts;
      isLoading = true;

    }else if (state is PostsLoaded){
      posts = state.posts;
    }
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index){
        if(index<posts.length)
          return _post(posts[index],context);
        else{
          Timer(Duration(milliseconds: 30),(){
             scrollController.jumpTo(scrollController.position.maxScrollExtend);
          });
         
          return _loadingIndicator();
        }
    }, separatorBuilder: (context,index){
      return Divider(
        color: Colors.grey[400],
      );
    }, itemCount: posts.length + (isLoading ? 1 : 0));
  }
  );
}

Widget _post(Post post, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("${post.id}.${post.title}",
      style: TextStyle(
        fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold
      ),),
      SizedBox(height: 10,),
      Text(post.body)
    ],),
  );
}

Widget _loadingIndicator() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: CircularProgressIndicator(),),
  );
}