import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';
import 'package:car_rating/Model/car_tile.dart';

class User_product_screen extends StatelessWidget {
  static const routee = '/userproduct';
  Future<void> _refreshProd(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).showproducts();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshProd(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Padding(
            padding: EdgeInsets.only(left: 83.0),
            child: Text("Car List"),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Editee');
              },
              icon: const Icon(Icons.add_circle_rounded),
            ),
          ],
        ),
        body: FutureBuilder(
            future: _refreshProd(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        child: Consumer<Products>(
                          builder: (ctx, snap, _) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: ListView.builder(
                              itemBuilder: (_, i) => Column(
                                children: [
                                  Car_tile(
                                    snap.items[i].id,
                                    snap.items[i].Name,
                                    snap.items[i].mileage,
                                    snap.items[i].number,
                                    snap.items[i].dof,
                                  ),
                                  const Divider(),
                                ],
                              ),
                              itemCount: snap.items.length,
                            ),
                          ),
                        ),
                        onRefresh: () => _refreshProd(context),
                      )),
      ),
    );
  }
}
