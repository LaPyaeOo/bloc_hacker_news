import 'package:flutter/cupertino.dart';

import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc storiesBloc;

  StoriesProvider({Key? key, required Widget child})
      : storiesBloc = StoriesBloc(),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(StoriesProvider oldWidget) => true;

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()
            as StoriesProvider)
        .storiesBloc;
  }
}



