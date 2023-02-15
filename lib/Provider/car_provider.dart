import 'package:flutter/material.dart';
import '../Model/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:car_rating/Model/Http.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Product findbyid(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> showproducts() async {
    var url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/product.json');
    try {
      var response = await http.get(url);
      var extractdata = json.decode(response.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return;
      }
      final List<Product> _productstoload = [];
      extractdata.forEach((prodid, prodvalue) {
        _productstoload.add(Product(
          id: prodid,
          number: prodvalue['number'],
          Name: prodvalue['Name'],
          mileage: prodvalue['mileage'],
          dof: prodvalue['dof'],
        ));
      });
      _items = _productstoload;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addproduct(Product product) async {
    var url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/product.json');
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
      final newproduct = Product(
        id: json.decode(response.body)['name'],
        Name: product.Name,
        mileage: product.mileage,
        dof: product.dof,
        number: product.number,
      );
      _items.add(newproduct);
      notifyListeners();
    } catch (Error) {
      throw (Error);
    }
  }

  Future<void> editproduct(Product editproduct, String id) async {
    final editid = _items.indexWhere((prod) => prod.id == id);
    if (editid >= 0) {
      final url = Uri.parse(
          'https://car-rater-default-rtdb.firebaseio.com/product.json');
      await http.patch(url,
          body: json.encode({
            'Name': editproduct.Name,
            'mileage': editproduct.mileage,
            'dof': editproduct.dof,
            'car_id': editproduct.id,
          }));
      _items[editid] = editproduct;
      notifyListeners();
    } else {
      print(".....");
    }
  }

  Future<void> Deleteprod(String id) async {
    final url = Uri.parse(
        'https://car-rater-default-rtdb.firebaseio.com/product/$id.json');
    final _prodindex = _items.indexWhere((prod) => prod.id == id);
    Product _prodindexitem = _items[_prodindex];
    var response = await http.delete(url);
    _items.removeAt(_prodindex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(_prodindex, _prodindexitem);
      notifyListeners();
      throw HttpRequest('Could not delete product');
    }
    _prodindexitem = null;
  }
}
