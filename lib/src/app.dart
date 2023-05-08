import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/stories_provider.dart';
import '../constant/route_const.dart';
import 'screens/news_detail.dart';
import 'screens/news_list.dart';
import 'services/route_generator.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: const MaterialApp(
        title: 'Hacker News',
        home: NewsList(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
