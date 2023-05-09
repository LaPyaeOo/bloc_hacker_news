import 'package:flutter/material.dart';

import '../../constant/route_const.dart';
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
          return const NewsList();
        },
      );
    } else {
      if (settings.name!.contains('/')) {
        int itemId = int.parse(settings.name!.replaceFirst('/', 'to'));
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return NewsDetail(itemId: itemId,);
          },
        );
      } else {
        return _errorRoute();
      }
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error Route'),
          ),
          body: Container(),
        );
      },
    );
  }
}
