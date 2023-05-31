import 'package:flutter/material.dart';
import 'package:my_bike/ui/screen/ListeScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListeScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        title: Text(title),
    ),
    body: const Center(
    child: Text(
    ' Les stations ',
    style: TextStyle(fontSize: 24),
    ),
    ),
      bottomNavigationBar: const BottomAppBar(


        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            IconButton(
              icon: Icon(Icons.bike_scooter),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }

}

