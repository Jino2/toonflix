import 'package:json_annotation/json_annotation.dart';

part 'detail_model.g.dart';
@JsonSerializable()
class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });

  factory WebtoonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$WebtoonDetailModelFromJson(json);
}