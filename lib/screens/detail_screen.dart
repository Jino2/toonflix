import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/widgets/episode_widget.dart';

import '../models/detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen({super.key, required this.webtoon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> webtoonEpisodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonById(widget.webtoon.id);
    webtoonEpisodes = ApiService.getLatestEpisodesById(widget.webtoon.id);
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    final likeToons = prefs.getStringList('likeToons');
    if (likeToons == null) {
      prefs.setStringList('likeToons', []);
      return;
    }

    if (likeToons.contains(widget.webtoon.id.toString())) {
      setState(() {
        isLiked = true;
      });
    }
  }

  void toggleLike() {
    final newIsLiked = !isLiked;
    const likeToonsKey = 'likeToons';
    final likeToons = prefs.getStringList(likeToonsKey);
    if (likeToons == null) return;

    if (newIsLiked) {
      likeToons.add(widget.webtoon.id.toString());
    } else {
      likeToons.remove(widget.webtoon.id.toString());
    }
    prefs.setStringList(likeToonsKey, likeToons);

    setState(() {
      isLiked = newIsLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          widget.webtoon.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: toggleLike,
            icon: Icon(
              isLiked ? Icons.favorite_outlined : Icons.favorite_outline_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Center(
                child: Hero(
                  tag: widget.webtoon.id,
                  child: Container(
                    width: 200,
                    height: 300,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.network(widget.webtoon.thumbnail),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoonDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "${snapshot.data!.genre} / ${snapshot.data!.age}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return Text('...');
                },
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: webtoonEpisodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!
                          .map((e) => EpisodeWidget(
                                episode: e,
                                webtoonId: widget.webtoon.id,
                              ))
                          .toList(),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
