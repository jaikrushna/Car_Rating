// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:car_rating/Screens/Car_info.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';

class Car_tile extends StatelessWidget {
  final String id;
  final String number;
  final String Name;
  final double mileage;
  final int dof;
  const Car_tile(this.id, this.Name, this.mileage, this.number, this.dof,
      {Key key})
      : super(key: key);
  Color _rang() {
    if ((mileage >= 15) && (dof <= 5)) {
      return const Color(0x889EF29C);
    } else if ((mileage >= 15) && (dof > 5)) {
      return const Color(0x88F2DA88);
    } else {
      return const Color(0x66CB2727);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text(
        number,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              const Text("Model: "),
              Text(
                Name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("mileage:"),
              Text(
                mileage.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              const Text(
                " Km/L",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
      tileColor: _rang(),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Car_Info.routee, arguments: id);
              },
              icon: const Icon(Icons.edit_rounded),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Cars>(context, listen: false).Deletecar(id);
                  const SnackBar(content: Text('Deleting Successfull!'));
                } catch (error) {
                  const SnackBar(content: Text('Deleting Failed!'));
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
