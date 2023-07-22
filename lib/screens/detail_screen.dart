import 'package:flutter/material.dart';
import 'package:toonflix/main.dart';

import '../models/webtoon_model.dart';

class DetailScreen extends StatelessWidget {
  final WebtoonModel webtoon;

  const DetailScreen({super.key, required this.webtoon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          webtoon.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
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
              child: Image.network(webtoon.thumbnail),
            ),
          ),
        ],
      ),
    );
  }
}
