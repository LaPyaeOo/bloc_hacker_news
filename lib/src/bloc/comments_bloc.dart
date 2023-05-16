import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, ItemModel>>();

  // Stream
  Stream<Map<int, ItemModel>> get itemWithComment => _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComment => _commentsFetcher.sink.add;

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
