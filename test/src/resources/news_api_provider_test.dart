import 'package:flutter_test/flutter_test.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((response) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    final expectation = [1, 2, 3, 4];
    print(
        'typeids = ${ids.runtimeType}, myexpectaion is = ${expectation.runtimeType}');
    expect(ids, expectation);
  });

  test('fetch item with id', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((response) async {
      final jsonMap = {
        "by": "dhouston",
        "descendants": 71,
        "id": 8863,
        "kids": [
          9224,
          8917,
          8952,
          8958,
          8884,
          8887,
          8869,
          8940,
          8908,
          9005,
          8873,
          9671,
          9067,
          9055,
          8865,
          8881,
          8872,
          8955,
          10403,
          8903,
          8928,
          9125,
          8998,
          8901,
          8902,
          8907,
          8894,
          8870,
          8878,
          8980,
          8934,
          8943,
          8876
        ],
        "score": 104,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "url": "http://www.getdropbox.com/u/2/screencast.html"
      };

      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(8863);
    expect(item.by, 'dhouston');
    expect(item.id, 8863);
    expect(item.kids, [
      9224,
      8917,
      8952,
      8958,
      8884,
      8887,
      8869,
      8940,
      8908,
      9005,
      8873,
      9671,
      9067,
      9055,
      8865,
      8881,
      8872,
      8955,
      10403,
      8903,
      8928,
      9125,
      8998,
      8901,
      8902,
      8907,
      8894,
      8870,
      8878,
      8980,
      8934,
      8943,
      8876
    ]);
  });
}
