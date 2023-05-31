import 'package:flutter/material.dart';
import 'package:my_bike/ui/screen/elements/Card.dart';

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
                    return StationCard(
                        address: station!.nom! + ' ' + station!.commune!,
                        distance: 0,
                        type: station!.type!,
                        nbplacesdispo: station!.nbplacesdispo!,
                        nbvelodispo: station!.nbvelosdispo!,
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

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}