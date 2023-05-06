 import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/models/item_model.dart';
import 'package:hacker_news/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Fetch top ids', () async {
    final newsApiProvider = NewsApiProvider();

    newsApiProvider.client = MockClient((request) async {
      return Response(jsonEncode([1, 2, 3, 4]), 200);
    });
    final ids = await newsApiProvider.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });

  test('Fetch item from id', () async {
    final newsApiProvider = NewsApiProvider();
    final jsonMap = {
      'id': 123,
      'deleted': true,
      'type': 'aaa',
      'by': 'aaa',
      'time': 2,
      'text': 'aaa',
      'dead': false,
      'parent': 'aaa',
      'kids': [1, '2'],
      'url': 'https',
      'score': 2,
      'title': 'aaa',
      'descendants': 2
    };
    newsApiProvider.client = MockClient((request) async {
      return Response(jsonEncode(jsonMap), 200);
    });

    ItemModel item = await newsApiProvider.fetchItem(id: 900);

    expect(item.id, 123);
  });
}
