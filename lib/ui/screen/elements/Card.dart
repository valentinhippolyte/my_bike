import 'package:flutter/material.dart';

class StationCard extends StatelessWidget {
  final String address;
  final int distance;
  final String type;

  const StationCard({Key? key,required this.address,required this.distance,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(address),
          subtitle: type.contains('AVEC') ?
              Image.asset('assets/images/logo-cb.jpg', width: 15, height: 15, alignment: Alignment.bottomLeft,) //code if above statement is true
              :Text(type),
          trailing: Text(distance.toString() + 'm'),
        ),
      ),
    );
  }
}