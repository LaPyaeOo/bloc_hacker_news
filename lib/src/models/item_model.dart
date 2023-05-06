import 'dart:convert';

class ItemModel {

  final String? by;
  final int? descendants;
  final int? id;
  final List<dynamic>? kids;
  final int? score;
  final String? text;
  final int? time;
  final String? title;
  final String? type;
  final String? url;

  // Initializer list

  ItemModel.fromJson(Map<String, dynamic> jsonMap)
      : by = jsonMap['by'] ?? '',
        descendants = jsonMap['descendants'] ?? 0,
        id = jsonMap['id'] ?? 0,
        kids = jsonMap['kids'] ?? [],
        score = jsonMap['score'] ?? 0,
        text = jsonMap['text'] ?? '',
        time = jsonMap['time'] ?? 0,
        title = jsonMap['title'] ?? '',
        type = jsonMap['type'] ?? '',
        url = jsonMap['url'] ?? '';

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : by = parsedJson['by'] ?? '',
        descendants = parsedJson['descendants'] ?? 0,
        id = parsedJson['id'] ?? 0,
        kids = json.decode(parsedJson['kids']) ?? [],
        score = parsedJson['score'] ?? 0,
        text = parsedJson['text'] ?? '',
        time = parsedJson['time'] ?? 0,
        title = parsedJson['title'] ?? '',
        type = parsedJson['type'] ?? '',
        url = parsedJson['url'] ?? '';

  Map<String, dynamic> toMapForDatabase() {
    return <String, dynamic>{
      "by": by,
      "descendants": descendants,
      "id": id,
      "kids": json.encode(kids),
      "score": score,
      "text": text,
      "time": time,
      "title": title,
      "type": type,
      "url": url,
    };
  }
}
