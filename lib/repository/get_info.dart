import 'dart:convert';
import 'package:http/http.dart' as http;

 abstract class GetInformationRepository {

   GetInformationRepository._();

 static getInformation({required String name}) async {
    try {
      final url =
          Uri.parse("http://universities.hipolabs.com/search?country=$name");
      final res = await http.get(url);
      dynamic data = jsonDecode(res.body);

      return data;
    } catch (e) {
      print(e);
    }
  }


 static getInformationWeather({required String name}) async {
    try {
      final url =
      Uri.parse("https://api.weatherapi.com/v1/forecast.json?key=0aafe5ca2dc742cb8d7125331222212&q=$name");
      final res = await http.get(url);
      dynamic data = jsonDecode(res.body);

      return data;
    } catch (e) {
      print(e);
    }
  }
}