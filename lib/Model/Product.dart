import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  String id;
  String number;
  String Name;
  double milege;
  String dof;

  Product({
    @required this.number,
    @required this.id,
    @required this.Name,
    @required this.milege,
    @required this.dof,
  });

  // Future<void> toogle_fav_status(String token, String user_id) async {
  //   // final oldfav = isfav;
  //   // isfav = !isfav;
  //   notifyListeners();
  //   final url = Uri.parse(
  //       'https://shopit-53507-default-rtdb.firebaseio.com/product');
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: json.encode(
  //         // isfav,
  //       ),
  //     );
  //     if (response.statusCode >= 400) {
  //       isfav = oldfav;
  //       _isfav(oldfav);
  //       notifyListeners();
  //     }
  //     _isfav(isfav);
  //   } catch (error) {
  //     isfav = oldfav;
  //     _isfav(oldfav);
  //     notifyListeners();
  //   }
  // }
}
