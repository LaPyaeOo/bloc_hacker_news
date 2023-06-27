import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hacker_news/src/bloc/stories_provider.dart';

import '../services/languages_service/app_translation.dart';
import '../services/languages_service/language.dart';
import '../services/languages_service/language_controller.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';
import 'dart:developer' as developer;

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
    storiesBloc.fetchTopIds();
    Get.put(LocaleCont());

    /// For language changes
    // return Scaffold(
    // appBar: AppBar(
    //   title: Text(
    //     AppTranslation.of(context).getTranslatedValue("English")!.toString(),
    //   ),
    // ),
    // body: Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: Language.languageList()
    //           .map(
    //             (e) => Padding(
    //               padding: EdgeInsets.only(right: 10),
    //               child: ElevatedButton(
    //                 onPressed: () {
    //                   Get.find<LocaleCont>()
    //                       .updateLocale(_changeLanguage(e, context));
    //                 },
    //                 child: Text("${e.name} ${e.flag}"),
    //               ),
    //             ),
    //           )
    //           .toList(),
    //     ),
    //     // buildList(storiesBloc: storiesBloc),
    //   ],
    // ),
    // );
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
  Locale _changeLanguage(Language language, context) {
    Locale a;
    switch (language.languageCode) {
      case english: // here ENGLISH is a constant that I've created in another file called `constant.dart` file and same for other languages
        a = Locale(language.languageCode, "US");

        break;
      case myanmar:
        a = Locale(language.languageCode, "MM");

        break;

      default:
        a = Locale(language.languageCode, 'US');
    }
    return a;
  }
}

const String english = "en";
const String myanmar = "my";
