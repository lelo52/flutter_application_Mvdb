import 'dart:convert';

import 'package:http/http.dart' as http;

//http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=9533HA48052PTJ8HVLZV&query=인어공주&detail=Y

class MovieApi {
  final api_key = 'LN636A57WG804S1Y7ZF8';

  Future<List<dynamic>> search(String keyword) async {
    String site =
        'http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=$api_key&query=$keyword&detail=Y';
    var response = await http.get(Uri.parse(site));
    if (response.statusCode == 200) {
      var movies =
          jsonDecode(response.body)['Data'][0]['Result'] as List<dynamic>;
      return movies;
    } else {
      return [];
    }
  }
}
