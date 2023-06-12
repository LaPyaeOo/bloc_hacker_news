import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/stories_provider.dart';

import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';
import 'dart:developer'as developer;

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this)
      ..addListener(() {})
      ..repeat(period: const Duration(seconds: 1));
    _colorTween = _animationController.drive(ColorTween(
      begin: Colors.cyan,
      end: Colors.yellow,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News List'),
      ),
      body: buildList(storiesBloc: storiesBloc),
    );
  }

  /// Usage of Listview.builder and FutureBuilder
  ///
  ///
/*

Widget buildList() {
  return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext buildContext, int index) {
        return FutureBuilder(
            future: getFuture(),
            builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? Text('Im visible $index with ${snapshot.data}')
                  : Text('Not fetching data $index with ${snapshot.data}');
            });
      });
}

getFuture() {
  return Future.delayed(const Duration(seconds: 2), () => 'hi');
}

*/

  Widget buildList({required StoriesBloc storiesBloc}) {
    return StreamBuilder(
      stream: storiesBloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: _colorTween,
            ),
          );
        }
        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              developer.log('IS $index');
              storiesBloc.fetchItem(snapshot.data![index]);
              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          ),
        );
      },
    );
  }

// Widget buildList({required StoriesBloc storiesBloc}) {
//   return StreamBuilder(
//       stream: storiesBloc.topIds,
//       builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               valueColor: _colorTween,
//             ),
//           );
//         }
//         return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (BuildContext context, int index) {
//               // storiesBloc.fetchItem(snapshot.data![index]);
//               return Text('${snapshot.data![index]}');
//             });
//       });
// }
}
