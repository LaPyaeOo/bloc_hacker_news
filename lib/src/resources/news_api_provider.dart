import 'dart:convert';

import 'package:hacker_news/src/resources/repository.dart';

import '../../constant/api_const.dart';
import '../../src/models/item_model.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider implements Source {
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse(topStories));
    final ids = jsonDecode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem({required int id}) async {
    final response = await client.get(Uri.parse('$root/v0/item/$id.json'));
    final fetchItem = jsonDecode(response.body);
    return ItemModel.fromJson(fetchItem);
  }
}
