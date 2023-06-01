import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_bike/ui/assets/Colors.dart';
import 'package:my_bike/ui/screen/ListFavScreen.dart';
import 'package:my_bike/ui/screen/SearchScreen.dart';

import 'firebase_options.dart';
import 'ui/screen/ListScreen.dart';

<<<<<<< HEAD
import 'ui/screen/ListScreen.dart';

void main() {
=======
Future<void> main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
>>>>>>> d0d9ce20a90137ce6f85275a319740c73e17cb52
  runApp(const MyApp());
}

<<<<<<< HEAD
int _selectedIndex = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
=======
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

>>>>>>> c5b8f8c01a1f6bd748aeec1a7d832554200b3e36
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
<<<<<<< HEAD
      home: Scaffold(
        body: Center(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              ListScreen(),
              const ListFavScreen(),
              const SearchScreen(),
            ],
          ),
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
=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: ListScreen(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Main Page (list)' ,
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmptyPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmptyPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty Page'),
      ),
      body: const Center(
        child: Text(
          'This is an empty page.',
          style: TextStyle(fontSize: 24),
>>>>>>> c5b8f8c01a1f6bd748aeec1a7d832554200b3e36
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