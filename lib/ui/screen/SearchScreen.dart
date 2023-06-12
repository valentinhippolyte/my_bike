import 'package:flutter/material.dart';
import '../../data/dataSource/remote/VlilleApi.dart';
import '../screen/ListScreen.dart';
import '../assets/Colors.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController _textEditingController = TextEditingController();
  String searchValue = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(updateSearchValue);
  }

  void updateSearchValue() {
    setState(() {
      searchValue = _textEditingController.text;
      isSearching = searchValue.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(updateSearchValue);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: const Text("Stations"),
            backgroundColor: MBColors.gris,
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Rechercher...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
          if (isSearching)
            Expanded(
              child: ListScreen(searchValue: searchValue, showAppBar: false),
            ),
        ],
      ),
    );
  }
}




// _list.where((fields)=>
// fields.nom.contains(searchValue)||
// fields.commune.contains(searchValue)||
// fields.adresse.contains(searchValue)
// ).toList(),
