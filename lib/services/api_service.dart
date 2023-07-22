import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/webtoon_model.dart';
import 'dtos/webtoon_dto.dart';

class ApiService {
  static const String baseUrl = "webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final url = Uri.https(baseUrl, today);
    final response = await http.get(url);
    if (response.statusCode != 200) throw Error();
    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    final res = json
        .map<WebtoonModel>((e) => WebtoonDto.fromJson(e).toModel())
        .toList();
    return res;
  }
}
