import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';

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

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.https(baseUrl, id);
    final response = await http.get(url);
    if (response.statusCode != 200) throw Error();
    var json = jsonDecode(response.body);
    return WebtoonDetailModel.fromJson(json);
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    final url = Uri.https(baseUrl, "$id/episodes");
    final response = await http.get(url);
    if (response.statusCode != 200) throw Error();
    return jsonDecode(response.body)
        .cast<Map<String, dynamic>>()
        .map<WebtoonEpisodeModel>((e) => WebtoonEpisodeModel.fromJson(e))
        .toList();
  }
}
