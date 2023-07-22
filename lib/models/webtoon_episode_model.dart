import 'package:json_annotation/json_annotation.dart';

part  'webtoon_episode_model.g.dart';

@JsonSerializable()
class WebtoonEpisodeModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'thumb')
  final String thumbnail;
  @JsonKey(name: 'rating')
  final String rating;
  @JsonKey(name: 'date')
  final String date;

  WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.rating,
    required this.date,
  });

  factory WebtoonEpisodeModel.fromJson(Map<String, dynamic> json) {
    return _$WebtoonEpisodeModelFromJson(json);
  }
}
