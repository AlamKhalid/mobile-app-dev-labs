import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;

class SearchResult {
// TODO: add properties and constructors to initialise your model class
  String content_type;
  String title;
  List<String> tags;
  String pubDate;
  String url;

  SearchResult(
      this.content_type, this.title, this.tags, this.pubDate, this.url);

  @override
  String toString() {
    // TODO: implement toString
    return "Search Result => 'ContentType' : ${content_type} 'title' : ${title} 'tags' : ${tags} 'PubDate': ${pubDate} 'url' : ${url}";
  }
}

class SearchResultCustom {
// TODO: add properties and constructors to initialise your model class
  int albumId;
  int id;
  String title;
  String thumbnailUrl;
  String url;

  SearchResultCustom(
      this.albumId, this.title, this.thumbnailUrl, this.id, this.url);

  @override
  String toString() {
    // TODO: implement toString
    return "Search Result => 'Album Id' : ${albumId} 'ID' : ${id} 'Thumbnail URL' : ${thumbnailUrl} 'ID': ${id} 'url' : ${url}";
  }
}

class APIClient {
  Future<List<dynamic>> downloadAndParseJson(var url) async {
    var uriString = url;
    final response = await http.get(Uri.parse(uriString));
    if (response.statusCode == 200) {
      final parser = SearchResultsParser(response.body);
      return parser.parseInBackground();
    } else {
      throw Exception('Failed to load json');
    }
  }
}

class SearchResultsParser {
  SearchResultsParser(this.encodedJson);
  final String encodedJson;
  Future<List<dynamic>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);
    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort p) async {
    // decode and parse the json
    final jsonData = jsonDecode(encodedJson);
    final results = [];
    if (jsonData is Map) {
      final resultsJson = jsonData['results'];
      for (final res in resultsJson) {
        List<String> tag_parsed = [];
        for (final tag in res['tags']) {
          String test = tag as String;
          tag_parsed.add(test);
        }
        results.add(SearchResult(res['contentType'], res['title'], tag_parsed,
            res['date'], res['url']));
      }
    } else {
      for (final res in jsonData) {
        results.add(SearchResultCustom(res['albumId'], res['title'],
            res['thumbnailUrl'], res['id'], res['url']));
      }
    }
    Isolate.exit(p, results);
  }
}

void main() async {
  APIClient new_cl = APIClient();
  String url = 'https://jsonplaceholder.typicode.com/photos';
  List<dynamic> res = await new_cl.downloadAndParseJson(url);
  for (final results in res) {
    print(results);
  }
}
