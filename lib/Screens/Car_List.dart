import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';
import 'package:car_rating/Model/car_tile.dart';

class Car_List extends StatelessWidget {
  static const routee = '/carlist';
  Future<void> _refreshCar(BuildContext context) async {
    await Provider.of<Cars>(context, listen: false).showcars();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshCar(context),
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
            future: _refreshCar(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        child: Consumer<Cars>(
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
                        onRefresh: () => _refreshCar(context),
                      )),
      ),
    );
  }
}
