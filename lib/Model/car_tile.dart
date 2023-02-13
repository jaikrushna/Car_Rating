import 'package:flutter/material.dart';
import 'package:car_rating/Screens/Car_info.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';

class User_product_tile extends StatelessWidget {
  final String id;
  final String number;
  final String Name;
  final double milege;
  User_product_tile(
    @required this.id,
    @required this.Name,
    @required this.milege,
    @required this.number,
  );
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Text(
            Name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            milege.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Edit_User_Input.routee, arguments: id);
              },
              icon: Icon(Icons.edit_rounded),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .Deleteprod(id);
                  SnackBar(content: Text('Deleting Successfull!'));
                } catch (error) {
                  SnackBar(content: Text('Deleting Failed!'));
                }
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
