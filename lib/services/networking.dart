import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String apiKey = DotEnv().env['APIKEY'];

class NetworkService {
  final String url;

  NetworkService({this.url});

  Future fetchAPI(String url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch API');
    }
  }
}
