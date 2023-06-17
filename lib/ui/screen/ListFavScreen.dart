import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bike/ui/assets/Colors.dart';

import '../../data/dataSource/remote/FavFromFirestore.dart';
import '../../data/dataSource/remote/VlilleApi.dart';

class ListFavScreen extends StatefulWidget {
  const ListFavScreen({Key? key}) : super(key: key);

  @override
  State<ListFavScreen> createState() => _ListFavScreenState();
}

class _ListFavScreenState extends State<ListFavScreen> {
  VlilleApi api = VlilleApi();
  FavFromFirestore? favFromFirestore ;
  final fieldRef = FirebaseFirestore.instance
      .collection('FAVORIS')
      .withConverter<FavFromFirestore>(
    fromFirestore: (snapshots, _) => FavFromFirestore.fromJson(snapshots.data()!),
    toFirestore: (field, _) => field.toJson(),
  );

  @override
  void initState() {
    super.initState();
    fieldRef
        .doc('StationsBike')
        .get()
        .then((value) {
      setState(() {
        favFromFirestore = value.data();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fav "),
        backgroundColor: MBColors.gris,
      ),
      backgroundColor: MBColors.grisPerle,
    );
  }
}
