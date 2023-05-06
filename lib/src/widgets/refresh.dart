import 'package:flutter/material.dart';

import '../bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  const Refresh({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async{
        await bloc.clear();
        await bloc.fetchTopIds();
      },
    );
  }
}
