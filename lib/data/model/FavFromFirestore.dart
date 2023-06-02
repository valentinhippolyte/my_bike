class FavFromFirestore {
  List<int>? stationsFav;

  FavFromFirestore({this.stationsFav});

  FavFromFirestore.fromJson(Map<String, dynamic> json) {
    stationsFav = json['stationsFav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stationsFav'] = stationsFav;
    return data;
  }
}