import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_bike/ui/assets/Colors.dart';

class ListFavScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getUserId() async {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return null;
  }

  Widget buildFavoritesList(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final favorites = snapshot.data?.docs ?? [];
          if (favorites.isEmpty) {
            return const Text('Vous n\'avez pas encore ajouté de favoris.');
          } else {
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                // Affichez les détails du favori dans un widget personnalisé
                return FavoriteItem(
                  // Passer les données du favori au widget personnalisé
                  address: favorite['address'],
                  distance: favorite['distance'],
                  type: favorite['type'],
                  nbvelodispo: favorite['nbvelodispo'],
                  nbplacesdispo: favorite['nbplacesdispo'],
                  localistion: favorite['localistion'],
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fav "),
        backgroundColor: MBColors.gris,
      ),
      backgroundColor: MBColors.grisPerle,
      body: FutureBuilder<String?>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userId = snapshot.data;
            if (userId != null) {
              return buildFavoritesList(userId);
            } else {
              return const Text('Vous devez vous connecter pour voir vos favoris.');
            }
          }
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String address;
  final int distance;
  final String type;
  final int nbvelodispo;
  final int nbplacesdispo;
  final String localistion;

  const FavoriteItem({
    Key? key,
    required this.address,
    required this.distance,
    required this.type,
    required this.nbvelodispo,
    required this.nbplacesdispo,
    required this.localistion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: InkWell(
        child: ListTile(
          title: Text(address),
          subtitle: type.contains('AVEC')
              ? Image.asset(
            'assets/images/logo-cb.jpg',
            width: 15,
            height: 15,
            alignment: Alignment.bottomLeft,
          )
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
                                    // Ajoutez le code pour ajouter ou supprimer des favoris
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 18,
                                  ),
                                  label: const Text("Supprimer des favoris"),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(0, 10, 30, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Ajoutez le code pour l'action d'itinéraire
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
