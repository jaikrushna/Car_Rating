import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:car_rating/Model/Http.dart';
import 'package:car_rating/Model/Car.dart';

class Cars with ChangeNotifier {
  List<Car> _items = [];
  List<Car> get items {
    return [..._items];
  }

  Car findbyid(String id) {
    return _items.firstWhere((car) => car.id == id);
  }

  Future<void> showcars() async {
    var url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/cars.json');
    try {
      var response = await http.get(url);
      var extractdata = json.decode(response.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return;
      }
      final List<Car> _carstoload = [];
      extractdata.forEach((carid, carvalue) {
        _carstoload.add(Car(
          id: carid,
          number: carvalue['number'],
          Name: carvalue['Name'],
          mileage: carvalue['mileage'],
          dof: carvalue['dof'],
        ));
      });
      _items = _carstoload;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addcar(Car product) async {
    var url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/cars.json');
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'Name': product.Name,
          'mileage': product.mileage,
          'dof': product.dof,
          'number': product.number,
        }),
      );
      final newcar = Car(
        id: json.decode(response.body)['name'],
        Name: product.Name,
        mileage: product.mileage,
        dof: product.dof,
        number: product.number,
      );
      _items.add(newcar);
      notifyListeners();
    } catch (Error) {
      throw (Error);
    }
  }

  Future<void> editcar(Car editcar, String id) async {
    final editid = _items.indexWhere((car) => car.id == id);
    if (editid >= 0) {
      final url =
          Uri.parse('https://car-rater-default-rtdb.firebaseio.com/cars.json');
      await http.patch(url,
          body: json.encode({
            'Name': editcar.Name,
            'mileage': editcar.mileage,
            'dof': editcar.dof,
            'car_id': editcar.id,
          }));
      _items[editid] = editcar;
      notifyListeners();
    } else {
      print(".....");
    }
  }

  Future<void> Deletecar(String id) async {
    final url = Uri.parse(
        'https://car-rater-default-rtdb.firebaseio.com/cars/$id.json');
    final _carindex = _items.indexWhere((car) => car.id == id);
    Car _carindexitem = _items[_carindex];
    var response = await http.delete(url);
    _items.removeAt(_carindex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(_carindex, _carindexitem);
      notifyListeners();
      throw HttpRequest('Could not delete product');
    }
    _carindexitem = null;
  }
}
