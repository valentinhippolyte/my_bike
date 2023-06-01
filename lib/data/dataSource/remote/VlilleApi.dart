import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_bike/data/model/VLilleApiResponse.dart';
import 'package:http/http.dart' as http;

class VLilleApi {
  Future<VLilleApiResponse> getVLille() async {
    Uri url = Uri.parse(
        "https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion&rows=300");
    http.Response response = await http.get(url);
    VLilleApiResponse vLilleApiResponse =
        await compute(vLilleResponseFromJson, response.body);
    return vLilleApiResponse;
  }

  VLilleApiResponse vLilleResponseFromJson(String body) {
    return VLilleApiResponse.fromJson(jsonDecode(body));
  }
}