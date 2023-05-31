import 'package:flutter/material.dart';

import '../../data/dataSource/remote/VlilleApi.dart';
import '../../data/model/VlilleResponse.dart';
import '../assets/Colors.dart';

class ListScreen extends StatelessWidget {

  ListScreen({Key? key}) : super(key: key);

  VlilleApi api = VlilleApi();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search "),
        backgroundColor: MBColors.gris,
      ),
      backgroundColor: MBColors.grisPerle,
      body: FutureBuilder(
          future: api.getVlille(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              VlilleApiResponse? response = snapshot.data;
              if(response != null){
                List<Records>? records = response.records;
                if(records != null){
                  return ListView.builder(itemBuilder: (context, index){
                    Records currentRecord = records[index];
                    Fields? station = currentRecord.fields;
                    return ListTile(
                      title: Text(station!.nom!),
                    );
                  }, itemCount: records.length);
                } else {
                  return const Text("Aucune Station Trouvée");
                }
              } else {
                return const CircularProgressIndicator();
              }
            }else{
              return const CircularProgressIndicator();
            }

          }
      ),
    );
  }
}