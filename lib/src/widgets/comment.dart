import 'package:flutter/material.dart';

import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemModelMap;
  final int depth;

  const Comment(
      {Key? key,
      required this.itemId,
      required this.itemModelMap,
      required this.depth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemModelMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item!),
            subtitle: item.by == '' ? const Text('Deleted') : Text(item.by!),
            contentPadding: EdgeInsets.only(
              right: 16,
              left: (depth + 1) * 16,
            ),
          ),
          const Divider(),
        ];

        item.kids!.map(
          (kidsId) {
            children.add(
              Comment(
                itemId: kidsId,
                itemModelMap: itemModelMap,
                depth: depth + 1,
              ),
            );
          },
        ).toList();

        ///when use .map() over an object, the Iterable that is returned is lazy.
        ///This means it is not evaluated by calling .map(). To evaluate it, we need to call .toList()
        ///
        ///for (var kidsId in item.kids!) {
        //           children.add(
        //             Comment(
        //               itemId: kidsId,
        //               itemModelMap: itemModelMap,
        //               depth: depth +1,
        //             ),
        //           );
        //         }
        return Column(
          children: children,
        );
      },
    );
  }
  Widget buildText(ItemModel item){
    String text = item.text!.replaceAll("&#x27", "'")
    .replaceAll("<p>", "\n\n")
    .replaceAll("</p>", "");
    return Text(text);
  }
}
