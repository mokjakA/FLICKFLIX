import 'dart:convert';

import 'package:flickflix/models/detail_model.dart';
import 'package:flickflix/models/flick_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';
  static const String popular = 'popular';
  static const String now = 'now-playing';
  static const String coming = 'coming-soon';
  static const String detail = 'movie?id=';

  static Future<List<FlickModel>> getPopularFlick() async {
    final url = Uri.parse('$baseUrl/$popular');
    var response = await http.get(url);
    List<FlickModel> flickModels = [];

    if (response.statusCode == 200) {
      //성공적 호출
      //response에 page, results 로 나와있기 떄문에 한단계가 더 필요함
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      final List<dynamic> flicks = decodedData['results'];

      for (var flick in flicks) {
        flickModels.add(FlickModel(flick));
      }

      return flickModels;
    }
    throw Error();
  }

  static Future<List<FlickModel>> getFlicks(String option) async {
    Uri url;
    if (option == 'now') {
      url = Uri.parse('$baseUrl/$now');
    } else if (option == 'coming') {
      url = Uri.parse('$baseUrl/$coming');
    } else {
      // 예외 처리: option이 'now' 또는 'coming'이 아닌 경우
      throw ArgumentError('Invalid option: $option');
    }

    var response = await http.get(url);
    List<FlickModel> flickModels = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      final List<dynamic> flicks = decodedData['results'];
      for (var flick in flicks) {
        flickModels.add(FlickModel(flick));
      }
      return flickModels;
    }
    throw Error();
  }

  static Future<DetailModel> getDetailFlick(int id) async {
    final url = Uri.parse('$baseUrl/$detail$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(response.body);
      return DetailModel(decodedData);
    }
    throw Error();
  }
}

//adult / backdo