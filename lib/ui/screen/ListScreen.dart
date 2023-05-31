import 'package:flutter/material.dart';
import 'package:my_bike/data/model/VLilleApiResponse.dart';
import 'package:my_bike/data/dataSource/remote/VLilleApi.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);

  VLilleApi api = VLilleApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des adresses"),
      ),
      body: FutureBuilder<VLilleApiResponse>(
        future: api.getVLille(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final records = snapshot.data?.records;
            if (records != null && records.isNotEmpty) {
              return ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final station = records[index].fields;
                  return ListTile(
                    title: Text(station?.nom ?? "Nom inconnu"),
                    subtitle: Text(station?.adresse ?? "Adresse inconnue"),
                    leading: Icon(Icons.location_on),
                  );
                },
              );
            } else {
              return const Center(child: Text("Aucune adresse trouvée"));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else {
            return const Center(child: Text("Aucune donnée disponible"));
          }
        },
      ),
    );
  }
}
