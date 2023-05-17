import 'package:flutter/material.dart';

import '../bloc/comments_bloc.dart';
import '../bloc/comments_provider.dart';
import '../models/item_model.dart';

class NewsDetail extends StatefulWidget {
  final int itemId;

  const NewsDetail({Key? key, required this.itemId}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('News detail page'),
      ),
      body: buildBody(bloc: commentsBloc),
    );
  }

  Widget buildBody({required CommentsBloc bloc}) {
    return StreamBuilder(
        stream: bloc.itemWithComment,
        builder: (BuildContext context,
            AsyncSnapshot<Map<int, Future<ItemModel>>>snapshot) {
          return
        });
  }
}
