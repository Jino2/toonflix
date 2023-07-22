import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

import '../models/webtoon_model.dart';

class WebtoonCard extends StatelessWidget {
  final WebtoonModel webtoon;

  const WebtoonCard({super.key, required this.webtoon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(webtoon: webtoon)));
      },
      child: Column(
        children: [
          Container(
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
              child: Image.network(webtoon.thumbnail)),
          const SizedBox(
            height: 14,
          ),
          Text(
            webtoon.title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
