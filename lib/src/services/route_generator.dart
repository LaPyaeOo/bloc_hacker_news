import 'package:flutter/material.dart';

import '../../constant/route_const.dart';
import '../bloc/comments_provider.dart';
import '../bloc/stories_provider.dart';
import '../screens/news_detail.dart';
import '../screens/news_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    /// With switch statement
    // switch (settings.name) {
    //   case newsListRoute:
    //     return MaterialPageRoute(builder: (BuildContext context){
    //       return const NewsList();
    //     });
    //   case detailRoute:
    //     return MaterialPageRoute(
    //       builder: (BuildContext context) {
    //         return const NewsDetail();
    //       },
    //     );
    //   default:
    //     return _errorRoute();
    // }
    if (settings.name == newsListRoute) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          int itemId = int.parse(settings.name!.replaceFirst('/', ''));
          final commentBloc = CommentsProvider.of(context);
          commentBloc.fetchItemWithComment(itemId);
          return NewsDetail(itemId: itemId,);
        },
      );
    }
  }
  /// Add error route if need

  // static Route _errorRoute() {
  //   return MaterialPageRoute(
  //     builder: (BuildContext context) {
  //       return Scaffold(
  //         appBar: AppBar(
  //           title: const Text('Error Route'),
  //         ),
  //         body: Container(),
  //       );
  //     },
  //   );
  // }
}
