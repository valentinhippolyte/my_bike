import 'package:my_bike/data/model/VlilleResponse.dart';
import 'package:http/http.dart' as http;

class VlilleApi{

  VlilleApiResponse getVlille() {
    Uri url = Uri.parse("https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&q=&facet=nom&facet=commune&facet=etat&facet=type&facet=etatconnexion&rows=300");
    http.get(url);
  }

}