import 'package:flickflix/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PosterCardWidget extends StatelessWidget {
  final String title, poster_path;
  final int id;
  const PosterCardWidget(
      {super.key,
      required this.title,
      required this.poster_path,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DetailScreen(
              poster_path: poster_path,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500$poster_path',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
