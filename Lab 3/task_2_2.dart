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

class APIClient {
  Future<List<SearchResult>> downloadAndParseJson() async {
    const uriString = 'https://codewithandrea.com/search/search.json';
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
  Future<List<SearchResult>> parseInBackground() async {
    final p = ReceivePort();
    await Isolate.spawn(_decodeAndParseJson, p.sendPort);

    return await p.first;
  }

  Future<void> _decodeAndParseJson(SendPort p) async {
    final jsonData = jsonDecode(encodedJson);
    final resultsJson = jsonData['results'];
    List<SearchResult> my_res = [];
    for (final res in resultsJson) {
      List<String> tag_parsed = [];
      for (final tag in res['tags']) {
        String test = tag as String;
        tag_parsed.add(test);
      }
      my_res.add(SearchResult(res['contentType'], res['title'], tag_parsed,
          res['date'], res['url']));
    }
    Isolate.exit(p, my_res);
  }
}

void main() async {
  APIClient new_cl = APIClient();
  List<SearchResult> res = await new_cl.downloadAndParseJson();
  for (final results in res) {
    print(results);
  }
}
