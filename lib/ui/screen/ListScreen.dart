import 'package:flutter/material.dart';
import 'package:my_bike/data/dataSource/remote/VlilleApi.dart';

class ListScrren extends StatelessWidget {
  ListScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VlilleApi api = VlilleApi();
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: FutureBuilder(
        future: api.getVlille(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            String? adress = snapshot.data?.records?.first.fields?.adresse;
              if(adress != null){
                return Text(adress);
            }else{
                return Text("No adress");
              }
          }else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
