import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/cubit/posts_cubit.dart';
import 'package:hello_world/data/repository/posts_repostory.dart';
import 'package:hello_world/data/services/posts_services.dart';
import 'package:hello_world/presentation/posts_screen.dart';

void main() {
  runApp(PaginationApp(
    repository: PostsRepository(PostsService()),

  ));
}

class PaginationApp extends StatelessWidget {

  final PostsRepository repository;

  const PaginationApp({Key key, this.repository}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostsView(),
      ),
    );
  }
}
