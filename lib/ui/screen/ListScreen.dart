

import 'package:flutter/material.dart';
import 'package:my_bike/data/dataSource/remote/VLilleApi.dart';

class ListScreen extends StatelessWidget {
   ListScreen({Key? key}) : super(key: key);

  VLilleApi api =VLilleApi() ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(" LA LISTE"),
      ),
      body: FutureBuilder(
        future: api.getVLille(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            String? adress =snapshot.data?.records?.first.fields?.adresse;
            if(adress != null){
              return Text(adress);
            }else{
              return Text("Pas d'adresse");
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
