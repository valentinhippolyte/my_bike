import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_bike/ui/assets/Colors.dart';
import 'package:my_bike/ui/screen/elements/Card.dart';

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
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Aucun favori enregistré",
                        style: TextStyle(
                            fontSize: 20,
                            color: MBColors.blanc,
                            fontWeight: FontWeight.bold
                        )
                    )
                  ],
                ),
              ],
            );
          } else {
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                // Affichez les détails du favori dans un widget personnalisé
                return StationCard(
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
        title: const Text("Favoris "),
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
