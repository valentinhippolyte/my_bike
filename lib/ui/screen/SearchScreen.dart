
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









// import 'package:flutter/material.dart';
//
// import '../assets/Colors.dart';
//
// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchBarState createState() => _SearchBarState();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Search "),
//         backgroundColor: MBColors.gris,
//       ),
//       backgroundColor: MBColors.grisPerle,
//     );
//   }
// }
//
// class _SearchBarState extends State<SearchScreen> {
//    TextEditingController _textEditingController = TextEditingController();
//
//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: _textEditingController,
//       decoration: InputDecoration(
//         hintText: 'Rechercher...',
//         prefixIcon: Icon(Icons.search),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//       onChanged: (value) {
//
//       },
//     );
//   }
// }
//
//
// // _list.where((fields)=>
// // fields.nom.contains(searchValue)||
// // fields.commune.contains(searchValue)||
// // fields.adresse.contains(searchValue)
// // ).toList(),