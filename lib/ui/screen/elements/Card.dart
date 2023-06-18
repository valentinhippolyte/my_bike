import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_bike/ui/assets/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StationCard extends StatefulWidget {
  final String address;
  final int distance;
  final String type;
  final int nbvelodispo;
  final int nbplacesdispo;
  final String localistion;

  const StationCard({
    Key? key,
    required this.nbplacesdispo,
    required this.nbvelodispo,
    required this.address,
    required this.distance,
    required this.localistion,
    required this.type,
  }) : super(key: key);

  @override
  _StationCardState createState() => _StationCardState();
}

class _StationCardState extends State<StationCard> {
  bool isFavorite = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> launchGoogleMaps(String localistion) async {
    final googleMapsUrl = 'https://maps.google.com/maps?saddr=50.63101451960266, 3.0634013161982456&daddr=$localistion';
    await launch(googleMapsUrl);
  }

  Future<void> toggleFavorite() async {
    final user = _auth.currentUser;
    final userId = user?.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    isFavorite = !isFavorite;

    if (userId != null) {
      if (isFavorite) {
        // Ajouter le favori dans Firestore
        await _firestore.collection('favorites').add({
          'userId': userId,
          'address': widget.address,
          'distance': widget.distance,
          'type': widget.type,
          'nbvelodispo': widget.nbvelodispo,
          'nbplacesdispo': widget.nbplacesdispo,
          'localistion': widget.localistion,
        });
      } else {
        // Supprimer le favori de Firestore
        final favoritesSnapshot = await _firestore
            .collection('favorites')
            .where('userId', isEqualTo: userId)
            .where('address', isEqualTo: widget.address)
            .where('distance', isEqualTo: widget.distance)
            .where('type', isEqualTo: widget.type)
            .where('nbvelodispo', isEqualTo: widget.nbvelodispo)
            .where('nbplacesdispo', isEqualTo: widget.nbplacesdispo)
            .where('localistion', isEqualTo: widget.localistion)
            .get();

        if (favoritesSnapshot.docs.isNotEmpty) {
          final favoriteId = favoritesSnapshot.docs[0].id;
          await _firestore.collection('favorites').doc(favoriteId).delete();
        }
      }
    }
  }

  Future<bool> isStationFavorite() async {
    final user = _auth.currentUser;
    final userId = user?.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if (userId != null) {
      final favoritesSnapshot = await _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .where('address', isEqualTo: widget.address)
          .where('distance', isEqualTo: widget.distance)
          .where('type', isEqualTo: widget.type)
          .where('nbvelodispo', isEqualTo: widget.nbvelodispo)
          .where('nbplacesdispo', isEqualTo: widget.nbplacesdispo)
          .where('localistion', isEqualTo: widget.localistion)
          .get();

      return favoritesSnapshot.docs.isNotEmpty;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    isStationFavorite().then((value) {
      setState(() {
        isFavorite = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.address),
          subtitle: widget.type.contains('AVEC')
              ? Image.asset(
            'assets/images/logo-cb.jpg',
            width: 15,
            height: 15,
            alignment: Alignment.bottomLeft,
          ) // code if above statement is true
              : Text(widget.type),
          trailing: Text('${widget.distance}m'),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  onClosing: () {},
                  backgroundColor: MBColors.gris,
                  builder: (BuildContext context) {
                    bool b = false;
                    return StatefulBuilder(
                      builder: (BuildContext context, setState) => Wrap(
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
                                      widget.address,
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
                                            Text(widget.nbplacesdispo.toString()),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            const Text("Nombre de Vélos :"),
                                            Text(widget.nbvelodispo.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          setState (() {
                                            isFavorite = !isFavorite;
                                          });
                                        },
                                        icon: isFavorite
                                            ? const Icon(Icons.favorite, size: 18) // Filled icon if favorite
                                            : const Icon(Icons.favorite_outline, size: 18), // Empty icon otherwise
                                        label: isFavorite ? const Text("Supprimer des favoris") : const Text("Ajouter aux favoris"),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          launchGoogleMaps(widget.localistion);
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
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
