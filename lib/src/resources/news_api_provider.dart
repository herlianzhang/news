import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    final itemModel = ItemModel.fromJson(parsedJson);
    return itemModel;
  }
}