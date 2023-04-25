import 'dart:convert';
import 'package:covid_19_app/Model/country_api_model.dart';
import 'package:covid_19_app/Services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<CountryApiModel> fetchWorldStateRecord() async {
    final reponse = await http.get(Uri.parse(AppUrls.worldStateAPi));
    if (reponse.statusCode == 200) {
      var data = jsonDecode(reponse.body.toString());
      return CountryApiModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countryListApi() async {
    var data;
    final reponse = await http.get(Uri.parse(AppUrls.countrylist));
    if (reponse.statusCode == 200) {
      data = jsonDecode(reponse.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
