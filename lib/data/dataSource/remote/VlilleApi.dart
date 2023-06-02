import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:my_bike/data/model/VlilleResponse.dart';
import 'package:http/http.dart' as http;

class VlilleApi {
  VlilleApiResponse? vlilleMemory;

  Future<VlilleApiResponse> getVlille() async {
    if(vlilleMemory != null) {
      return Future.value(vlilleMemory);
    } else {
      Uri url = Uri.parse(
          "https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion&rows=300");
      http.Response response = await http.get(url);
      VlilleApiResponse futureVlille = await compute(vlilleResponseFromJson, response.body);
      vlilleMemory = futureVlille;
      return futureVlille;
    }
  }

  VlilleApiResponse vlilleResponseFromJson(String body){
    return VlilleApiResponse.fromJson(jsonDecode(body));
  }
}