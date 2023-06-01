import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:my_bike/ui/screen/elements/Card.dart';

import '../../data/dataSource/remote/VlilleApi.dart';
import '../../data/model/VlilleResponse.dart';
import '../assets/Colors.dart';

import 'dart:math';
=======
import 'package:my_bike/data/model/VLilleApiResponse.dart';
import 'package:my_bike/data/dataSource/remote/VLilleApi.dart';
>>>>>>> c5b8f8c01a1f6bd748aeec1a7d832554200b3e36

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);

<<<<<<< HEAD
  VlilleApi api = VlilleApi();
=======
  VLilleApi api = VLilleApi();
>>>>>>> c5b8f8c01a1f6bd748aeec1a7d832554200b3e36

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text("Stations "),
        backgroundColor: MBColors.gris,
      ),
      backgroundColor: MBColors.grisPerle,
      body: FutureBuilder(
          future: api.getVlille(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              VlilleApiResponse? response = snapshot.data;
              if (response != null) {
                List<Records>? records = response.records;
                if (records != null) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        Records currentRecord = records[index];
                        Fields? station = currentRecord.fields;
                        double? longitude = currentRecord.fields?.localisation?[0];
                        double? lattitude = currentRecord.fields?.localisation?[1];

                        return StationCard(
                          address: station!.nom! + ' ' + station!.commune!,
                          distance: calculateDistance(50.63899667255768, 3.0606579737783246, longitude!, lattitude!), // localisation Efficom par défaut
                          type: station!.type!,
                          nbplacesdispo: station!.nbplacesdispo!,
                          nbvelodispo: station!.nbvelosdispo!,
                        );
                      },
                      itemCount: records.length);
                } else {
                  return const Text("Aucune Station Trouvée");
                }
              } else {
                return const CircularProgressIndicator();
              }
            } else {
              return const Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.directions_bike, // Icône de vélo prédéfinie
                      size: 40, // Ajustez la taille de l'icône du vélo selon vos besoins
                      color: Colors.grey, // Couleur de l'icône du vélo
                    ),
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  int calculateDistance(double latitude1, double longitude1, double latitude2, double longitude2) {

    double lat1Radians = degreesToRadians(latitude1);
    double lon1Radians = degreesToRadians(longitude1);
    double lat2Radians = degreesToRadians(latitude2);
    double lon2Radians = degreesToRadians(longitude2);

    double dLat = lat2Radians - lat1Radians;
    double dLon = lon2Radians - lon1Radians;

    double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1Radians) * cos(lat2Radians) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = 6371 * c * 1000;
    return distance.toInt() ;
  }
  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

=======
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
>>>>>>> c5b8f8c01a1f6bd748aeec1a7d832554200b3e36
}
