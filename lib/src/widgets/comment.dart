import 'package:flutter/material.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemModelMap;

  const Comment({Key? key, required this.itemId, required this.itemModelMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder(); 
  }
}
