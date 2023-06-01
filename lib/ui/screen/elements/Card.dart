import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_bike/ui/assets/Colors.dart';

class StationCard extends StatelessWidget {
  final String address;
  final int distance;
  final String type;
  final int nbvelodispo;
  final int nbplacesdispo;
  final String coordonnees;

  const StationCard({
    Key? key,
    required this.nbplacesdispo,
    required this.nbvelodispo,
    required this.address,
    required this.distance,
    required this.type, required this.coordonnees,
  }) : super(key: key);

  Future<void> launchGoogleMaps(String coordonnees) async {
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$coordonnees';
    await launch(googleMapsUrl);
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return Center(
      child: Card(
        child: ListTile(
          leading: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 28.0,
              ),
            ],
          ),
          title: Text(address),
          subtitle: type.contains('AVEC')
              ? Image.asset(
            'assets/images/logo-cb.jpg',
            width: 15,
            height: 15,
            alignment: Alignment.bottomLeft,
          ) // code if above statement is true
              : Text(type),
          trailing: Text('${distance}m'),
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: MBColors.gris,
              builder: (context) {
                return Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text(
                                address,
                                style: const TextStyle(color: MBColors.blanc),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: MBColors.blanc,
                              ),
                            ),
                          ]),
                          Card(
                            child: ListTile(
                              dense: true,
                              leading: const Icon(Icons.info),
                              title: Row(
                                children: [
                                  Column(
                                    children: [
                                      const Text("Nombre de Places :"),
                                      Text(nbplacesdispo.toString()),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      const Text("Nombre de Vélos :"),
                                      Text(nbvelodispo.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    isFavorite = !isFavorite;
                                  },
                                  icon: isFavorite
                                      ? const Icon(Icons.favorite, size: 18) // Filled icon if favorite
                                      : const Icon(Icons.favorite_outline, size: 18), // Empty icon otherwise
                                  label: const Text("Ajouter aux favoris"),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 30, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    launchGoogleMaps(coordonnees);
                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    size: 18,
                                  ),
                                  label: const Text("Itinéraire"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
