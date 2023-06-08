import 'package:flutter/material.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemModelMap;

  const Comment({Key? key, required this.itemId, required this.itemModelMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemModelMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Still Loading');
        }
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: Text(item!.text!),
            subtitle: Text(item.by!),
          ),
          const Divider(),
        ];

        item.kids!.map((kidsId) {
          children.add(Comment(itemId: kidsId, itemModelMap: itemModelMap));
        });
        return Column(
          children: children,
        );
      },
    );
  }
}
