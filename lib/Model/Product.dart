// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String number;
  String Name;
  double mileage;
  int dof;

  Product({
    @required this.number,
    @required this.id,
    @required this.Name,
    @required this.mileage,
    @required this.dof,
  });
}
