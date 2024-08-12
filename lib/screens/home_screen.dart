import 'package:flickflix/models/flick_model.dart';
import 'package:flickflix/services/api_service.dart';
import 'package:flickflix/widgets/poster_card_widget.dart';
import 'package:flickflix/widgets/wideposter_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<FlickModel>> popularFlickModels =
      ApiService.getPopularFlick();
  final Future<List<FlickModel>> nowFlickModels = ApiService.getFlicks('now');
  final Future<List<FlickModel>> comingFlickModels =
      ApiService.getFlicks('coming');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff202a37),
        appBar: AppBar(
          title: const Text(
            'FLICK FLIX',
            style: TextStyle(
              fontFamily: 'NanumGothicCoding',
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff202a37),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: popularFlickModels,
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
                      return _buildWidePosterList(
                          context: context,
                          title: 'Popular Movies',
                          flicks: snapshot.data!,
                          sizedBoxHeight: 0);
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: nowFlickModels,
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
                      return _buildPosterList(
                          context: context,
                          title: 'Now in Cinemas',
                          flicks: snapshot.data!,
                          sizedBoxHeight: 50);
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: comingFlickModels,
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
                      return _buildPosterList(
                          context: context,
                          title: 'Coming soon',
                          sizedBoxHeight: 0,
                          flicks: snapshot.data!);
                    } else {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidePosterList(
      {required BuildContext context,
      required String title,
      required List<FlickModel> flicks,
      required double sizedBoxHeight}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sizedBoxHeight,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return WideposterCardWidget(
                poster_path: flicks[index].poster_path,
                id: flicks[index].id,
              );
            },
            itemCount: flicks.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPosterList(
      {required BuildContext context,
      required String title,
      required double sizedBoxHeight,
      required List<FlickModel> flicks}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sizedBoxHeight,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return PosterCardWidget(
                title: flicks[index].title,
                poster_path: flicks[index].poster_path,
                id: flicks[index].id,
              );
            },
            itemCount: flicks.length,
            separatorBuilder: (context, index) => const SizedBox(
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}
