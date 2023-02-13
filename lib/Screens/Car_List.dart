import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:car_rating/Model/Product.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';
import 'package:car_rating/Model/car_tile.dart';
// import 'package:shop_it/Screens/App_Drawer.dart';
import 'package:car_rating/Screens/Car_info.dart';

class User_product_screen extends StatelessWidget {
  static const routee = '/userproduct';
  Future<void> _refreshProd(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).showproducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final userproduct = Provider.of<Products>(context);
    return RefreshIndicator(
      onRefresh: () => _refreshProd(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("User_Product"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Editee');
              },
              icon: Icon(Icons.add_circle_rounded),
            ),
          ],
        ),
        // drawer: App_Drawer(),
        body: FutureBuilder(
            future: _refreshProd(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        child: Consumer<Products>(
                          builder: (ctx, snap, _) => Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemBuilder: (_, i) => Column(
                                children: [
                                  User_product_tile(
                                      snap.items[i].id.toString(),
                                      snap.items[i].name.toString(),
                                      snap.items[i].milege),
                                  Divider(),
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
