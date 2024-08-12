import 'package:flickflix/models/detail_model.dart';
import 'package:flickflix/services/api_service.dart';
import 'package:flickflix/widgets/rating_stars_widget.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String poster_path;
  final int id;
  const DetailScreen({super.key, required this.poster_path, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<DetailModel> detailFlick;

  @override
  void initState() {
    super.initState();
    detailFlick = ApiService.getDetailFlick(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${widget.poster_path}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder(
              future: detailFlick,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final detail = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Back to list',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        height: 250,
                      ),
                      Text(
                        detail.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      RatingStarsWidget(rating: detail.vote_average),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        detail.genres.join(', '),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Storyline',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            detail.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xfff9d749),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Buy ticket',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
