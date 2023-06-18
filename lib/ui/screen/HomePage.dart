import 'package:flutter/material.dart';
import 'package:my_bike/ui/assets/Colors.dart';
import 'package:my_bike/ui/screen/ListFavScreen.dart';
import 'package:my_bike/ui/screen/SearchScreen.dart';
import 'ListScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            ListScreen(searchValue: ''),
            ListFavScreen(),
            SearchScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Stations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoris',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Recherche',
            ),
          ],
          backgroundColor: MBColors.gris,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: MBColors.bleu,
          unselectedItemColor: MBColors.grisPerle,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}