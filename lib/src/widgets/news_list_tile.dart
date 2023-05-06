import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
        stream: bloc.items,
        builder: (context,
            AsyncSnapshot<Map<int, Future<ItemModel>>> asyncSnapShot) {
          if (!asyncSnapShot.hasData) {
            return const LoadingContainer();
          }
          return FutureBuilder(
              future: asyncSnapShot.data![itemId],
              builder: (context, AsyncSnapshot<ItemModel> itemSnapShot) {
                if (!itemSnapShot.hasData) {
                  return const LoadingContainer();
                }
                return buildTile(itemSnapShot.data!);
              });
        });
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title!),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [
              const Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        const Divider(height: 5.0,),
      ],
    );
  }
}
