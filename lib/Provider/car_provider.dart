import 'package:flutter/material.dart';
import '../Model/Product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:car_rating/Model/Http.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'C1',
    //   number: 'MH14FT5510',
    //   Name: 'Mercedez-Benz',
    //   milege: 15,
    //   dof: '7',
    // ),
    // Product(
    //   id: 'C2',
    //   number: 'MH16FT7480',
    //   Name: 'Skoda-Rapid',
    //   milege: 12,
    //   dof: '3',
    // )
  ];
  List<Product> get items {
    return [..._items];
  }

  Product findbyid(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> showproducts([Showfilterstatus = false]) async {
    var url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/product.json');
    try {
      var response = await http.get(url);
      var extractdata = json.decode(response.body) as Map<String, dynamic>;
      if (extractdata == null) {
        return null;
      }
      final List<Product> _productstoload = [];
      extractdata.forEach((prodid, prodvalue) {
        _productstoload.add(Product(
          id: prodid,
          number: prodvalue['number'],
          Name: prodvalue['Name'],
          milege: prodvalue['milege'],
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
          'milege': product.milege,
          'dof': product.dof,
          'number': product.number,
        }),
      );
      final newproduct = Product(
        id: json.decode(response.body)['name'],
        Name: product.Name,
        milege: product.milege,
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
            'milege': editproduct.milege,
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
    final url =
        Uri.parse('https://car-rater-default-rtdb.firebaseio.com/product.json');
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
