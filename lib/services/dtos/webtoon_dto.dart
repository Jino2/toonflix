import 'package:json_annotation/json_annotation.dart';
import 'package:toonflix/models/webtoon_model.dart';

part 'webtoon_dto.g.dart';

@JsonSerializable()
class WebtoonDto {
  final String title, thumb, id;

  WebtoonDto({
    required this.title,
    required this.thumb,
    required this.id,
  });

  factory WebtoonDto.fromJson(Map<String, dynamic> json) =>
      _$WebtoonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WebtoonDtoToJson(this);

  WebtoonModel toModel() => WebtoonModel(
        title: title,
        thumbnail: thumb,
        id: id,
      );
}
