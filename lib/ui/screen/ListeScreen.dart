import 'package:flutter/material.dart';

import '../../data/dataSource/remote/VlilleApi.dart';

class ListeScreen extends StatelessWidget {

     ListeScreen({Key? key}) : super(key: key);

  VlilleApi api = VlilleApi();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("la liste "),
      ),
      body: FutureBuilder(
          future: api.getVlille(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              String? adress = snapshot.data?.records?.first.fields?.adresse;
              if(adress != null){
                  return Text(adress);
                }else{
                 return const Text("pas de station ");
                }
              }else{
                 return const CircularProgressIndicator();
              }

            }
      ),
    );
  }
}
