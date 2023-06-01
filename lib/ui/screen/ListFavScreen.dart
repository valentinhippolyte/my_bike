import 'package:flutter/material.dart';
import 'package:my_bike/ui/assets/Colors.dart';

class ListFavScreen extends StatelessWidget {
  const ListFavScreen({Key? key}) : super(key: key);

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
