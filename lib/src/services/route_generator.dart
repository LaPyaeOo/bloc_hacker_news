import 'package:flutter/material.dart';

import '../../constant/route_const.dart';
import '../screens/news_detail.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailRoute:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const NewsDetail();
          },
        );
      default:
        return _errorRoute();
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
