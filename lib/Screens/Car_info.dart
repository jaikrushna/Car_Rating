import 'package:car_rating/Screens/Car_List.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';
import 'package:car_rating/Model/Product.dart';
import 'package:car_rating/Provider/Constant.dart';

class Edit_User_Input extends StatefulWidget {
  static const routee = '/Editee';
  @override
  _Edit_User_InputState createState() => _Edit_User_InputState();
}

class _Edit_User_InputState extends State<Edit_User_Input> {
  final _formkey = GlobalKey<FormState>();
  final _primefocus = FocusNode();
  final _primefocus2 = FocusNode();
  final _primefocus3 = FocusNode();
  var _newproduct =
      Product(id: null, Name: '', milege: 0.0, dof: 0, number: '');
  @override
  var _initValues = {
    'Name': '',
    'dof': '',
    'number': '',
    'milege': '',
  };

  var _isintistate = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isintistate) {
      final editid = ModalRoute.of(context).settings.arguments as String;
      if (editid != null) {
        _newproduct =
            Provider.of<Products>(context, listen: false).findbyid(editid);
        _initValues = {
          'Name': _newproduct.Name,
          'dof': _newproduct.dof.toString(),
          'milege': _newproduct.milege.toString(),
          'number': _newproduct.number,
        };
      }
    }

    _isintistate = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _primefocus3.dispose();
    _primefocus.dispose();
    _primefocus2.dispose();
    super.dispose();
  }

  Future<void> _Saveform() async {
    final IsValid = _formkey.currentState.validate();
    if (!IsValid) {
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_newproduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .editproduct(_newproduct, _newproduct.id);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addproduct(_newproduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An error occured!"),
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pushNamed(User_product_screen.routee);
                      },
                      child: Text("Okay"),
                    ),
                  ],
                ));
      }
    }

    setState(() {
      _isloading = false;
    });
    Navigator.of(context).pushNamed(User_product_screen.routee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Padding(
          padding: const EdgeInsets.only(left: 78.0),
          child: Text("Edit_Car"),
        ),
        actions: [
          IconButton(
            onPressed: _Saveform,
            icon: Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['Name'],
                      decoration: kInputDecor.copyWith(
                          hintText: 'BMW M5 sport', labelText: 'Name Of Model'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Name of the Car";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                          id: _newproduct.id,
                          Name: value,
                          milege: _newproduct.milege,
                          dof: _newproduct.dof,
                          number: _newproduct.number,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: _initValues['dof'],
                      decoration: kInputDecor.copyWith(
                          hintText: '7', labelText: 'Age Of Car'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter age of the car";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                          id: _newproduct.id,
                          Name: _newproduct.Name,
                          milege: _newproduct.milege,
                          dof: int.parse(value),
                          number: _newproduct.number,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: _initValues['milege'],
                      decoration: kInputDecor.copyWith(
                          hintText: '18.0', labelText: 'Milege(km/l)'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _primefocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a Milege";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please Enter a valid milege";
                        }
                        if (double.parse(value) < 0) {
                          return "Please Enter a real value";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                          id: _newproduct.id,
                          Name: _newproduct.Name,
                          milege: double.parse(value),
                          dof: _newproduct.dof,
                          number: _newproduct.number,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: _initValues['number'],
                      decoration: kInputDecor.copyWith(
                          hintText: 'MH14XXXX90', labelText: 'Number_Plate'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter Number of the Car";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newproduct = Product(
                          id: _newproduct.id,
                          Name: _newproduct.Name,
                          milege: _newproduct.milege,
                          dof: _newproduct.dof,
                          number: value,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
