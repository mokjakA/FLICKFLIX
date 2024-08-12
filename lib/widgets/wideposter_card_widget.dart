import 'package:flickflix/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WideposterCardWidget extends StatelessWidget {
  final String poster_path;
  final int id;
  const WideposterCardWidget(
      {super.key, required this.poster_path, required this.id});

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
      child: Container(
        width: 320,
        height: 250,
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
    );
  }
}
