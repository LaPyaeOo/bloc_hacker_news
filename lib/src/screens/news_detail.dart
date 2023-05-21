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
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading');
        }
        final itemFuture = snapshot.data![widget.itemId];
        return FutureBuilder(
          future: itemFuture,
          builder:
              (BuildContext context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const Text('Loading');
            }
            // return buildTitle(itemSnapshot.data!);
            /// Combination of item title and recursive comments
            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    return
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
