import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_bike/ui/screen/elements/Card.dart';

import '../../data/dataSource/remote/VlilleApi.dart';
import '../../data/model/VlilleResponse.dart';
import '../assets/Colors.dart';

import 'dart:math';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);

  VlilleApi api = VlilleApi();

  final fieldsRef = FirebaseFirestore.instance.collection('FAVOIRS').withConverter<Fields>(
    fromFirestore: (snapshots, _)=> Fields.fromJson(snapshots.data()!),
    toFirestore: (fields, _)=> fields.toJson()
  );
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
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
                String searchValue = "Lille";
                records!.where((element) => element.fields!.commune!.contains(searchValue)).toList();
                if (records != null) {
                  // Trier les records par ordre croissant de distance
                  records.sort((a, b) {
                    double? longitudeA = a.fields?.localisation?[0];
                    double? latitudeA = a.fields?.localisation?[1];
                    double? longitudeB = b.fields?.localisation?[0];
                    double? latitudeB = b.fields?.localisation?[1];

                    int distanceA = calculateDistance(50.63899667255768, 3.0606579737783246, longitudeA!, latitudeA!);
                    int distanceB = calculateDistance(50.63899667255768, 3.0606579737783246, longitudeB!, latitudeB!);

                    return distanceA.compareTo(distanceB);
                  });
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

}
