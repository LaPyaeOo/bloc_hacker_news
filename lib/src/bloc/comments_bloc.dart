import 'package:rxdart/rxdart.dart';

import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  Repository? _repository;

  // Stream
  Stream<Map<int, Future<ItemModel>>> get itemWithComment =>
      _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComment => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    _repository = Repository();
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        print('INDEX $index');
        cache[id] = _repository!.fetchItem(itemId: id);
        cache[id]!.then((ItemModel itemModel) {
          for (int kidsId in itemModel.kids!) {
            fetchItemWithComment(kidsId);
          }
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
