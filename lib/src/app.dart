import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hacker_news/src/bloc/stories_provider.dart';
import 'bloc/comments_provider.dart';
import 'screens/news_list.dart';
import 'services/languages_service/app_translation.dart';
import 'services/languages_service/language_controller.dart';
import 'services/route_generator.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Get.put(LocaleCont());
    /// For language changes
    // return GetBuilder<LocaleCont>(
    //     builder: (controller) => CommentsProvider(
    //           child: StoriesProvider(
    //             child: MaterialApp(
    //               title: 'Hacker News',
    //               locale: controller.locale,
    //               localeResolutionCallback: (deviceLocale, supportedLocales) {
    //                 for (var locale in supportedLocales) {
    //                   if (locale.languageCode == deviceLocale!.languageCode &&
    //                       locale.countryCode == deviceLocale.countryCode) {
    //                     return deviceLocale;
    //                   }
    //                 }
    //                 return supportedLocales.first;
    //               },
    //               supportedLocales: const [
    //                 Locale('en', 'US'),
    //                 Locale('my', 'MM')
    //               ],
    //               localizationsDelegates: const [
    //                 GlobalMaterialLocalizations.delegate,
    //                 GlobalWidgetsLocalizations.delegate,
    //                 GlobalCupertinoLocalizations.delegate,
    //                 AppTranslation.delegate,
    //               ],
    //               home: NewsList(),
    //               onGenerateRoute: RouteGenerator.generateRoute,
    //             ),
    //           ),
    //         ));
    ////
    return CommentsProvider(
      child: StoriesProvider(
        child: const MaterialApp(
          title: 'Hacker News',
          supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppTranslation.delegate,
          ],
          home: NewsList(),
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
