import 'package:hacker_news/src/models/item_model.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  ///Getter to Stream
  Stream<List<int>> get topIds => _topIds.stream;

  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  /// Getter to sink
   fetchItem(int id)async {
     _itemsFetcher.sink.add(id);
     // _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
   }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids!);
  }

  StoriesBloc() {
     // _itemsFetcher.stream.asBroadcastStream().transform(_itemTransformer()).pipe(_itemsOutput);
    _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  _itemTransformer(){
    return ScanStreamTransformer<int,Map<int,Future<ItemModel>>>(
      (Map<int, Future<ItemModel>> cache, int id, index) {
        cache[id] =   _repository.fetchItem(itemId: id);
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  clear(){
    return _repository.clearCache();
  }


  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
