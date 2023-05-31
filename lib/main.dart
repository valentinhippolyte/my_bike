import 'package:flutter/material.dart';


import 'ui/screen/ListScreen.dart';

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
      home: MyHomePage(),

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ListScreen(),
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
