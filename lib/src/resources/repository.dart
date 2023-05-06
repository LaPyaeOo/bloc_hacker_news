import 'package:hacker_news/src/models/item_model.dart';

import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  List<Source> sources = [newsDbProvider, NewsApiProvider()];

  List<Cache> caches = [newsDbProvider];

  Future<List<int>?> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem({required int itemId}) async {
    // var item = await newsDbProvider.fetchItem(id: itemId);
    // if (item != null) {
    //   return item;
    // }
    // item = await newsApiProvider.fetchItem(id: itemId);
    // newsDbProvider.addItem(itemModel: item);
    // return item;

    Source? source;
    ItemModel? itemModel;

    for (source in sources) {
      itemModel = await source.fetchItem(id: itemId);
      // print('IM ${itemModel!.descendants}');
      if (itemModel != null) {
        break;
      }
    }

    for (var cache in caches) {
      /// Fixing db conflict method 2 (method 1 is in news_db_provider file)
      // if (cache != source as Cache) {
      //   cache.addItem(itemModel: itemModel!);
      // }
      cache.addItem(itemModel: itemModel!);
    }

    return itemModel!;
  }

  clearCache() async {
    for (Cache cache in caches) {
      await cache.clearCache();
    }
  }
}

abstract class Source {
  Future<List<int>?> fetchTopIds();

  Future<ItemModel?> fetchItem({required int id});
}

abstract class Cache {
  Future<int> addItem({required ItemModel itemModel});

  Future<int> clearCache();
}
