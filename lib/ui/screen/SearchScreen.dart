import 'package:flutter/material.dart';

import '../assets/Colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search "),
        backgroundColor: MBColors.gris,
      ),
      backgroundColor: MBColors.grisPerle,
    );
  }
}
