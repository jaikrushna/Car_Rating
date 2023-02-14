import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String number;
  String Name;
  double milege;
  int dof;

  Product({
    @required this.number,
    @required this.id,
    @required this.Name,
    @required this.milege,
    @required this.dof,
  });
}
