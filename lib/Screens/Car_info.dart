import 'package:car_rating/Screens/Car_List.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rating/Provider/car_provider.dart';
import 'package:car_rating/Provider/Constant.dart';
import 'package:car_rating/Model/Car.dart';

class Car_Info extends StatefulWidget {
  static const routee = '/Editee';
  @override
  _Car_InfoState createState() => _Car_InfoState();
}

class _Car_InfoState extends State<Car_Info> {
  final _formkey = GlobalKey<FormState>();
  final _primefocus = FocusNode();
  final _primefocus2 = FocusNode();
  final _primefocus3 = FocusNode();
  var _newcar = Car(id: null, Name: '', mileage: 0.0, dof: 0, number: '');
  @override
  var _initValues = {
    'Name': '',
    'dof': '',
    'number': '',
    'mileage': '',
  };

  var _isintistate = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isintistate) {
      final editid = ModalRoute.of(context).settings.arguments as String;
      if (editid != null) {
        _newcar = Provider.of<Cars>(context, listen: false).findbyid(editid);
        _initValues = {
          'Name': _newcar.Name,
          'dof': _newcar.dof.toString(),
          'mileage': _newcar.mileage.toString(),
          'number': _newcar.number,
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
    if (_newcar.id != null) {
      await Provider.of<Cars>(context, listen: false)
          .editcar(_newcar, _newcar.id);
    } else {
      try {
        await Provider.of<Cars>(context, listen: false).addcar(_newcar);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An error occured!"),
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pushNamed(Car_List.routee);
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
    Navigator.of(context).pushNamed(Car_List.routee);
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
                        _newcar = Car(
                          id: _newcar.id,
                          Name: value,
                          mileage: _newcar.mileage,
                          dof: _newcar.dof,
                          number: _newcar.number,
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
                        _newcar = Car(
                          id: _newcar.id,
                          Name: _newcar.Name,
                          mileage: _newcar.mileage,
                          dof: int.parse(value),
                          number: _newcar.number,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      initialValue: _initValues['mileage'],
                      decoration: kInputDecor.copyWith(
                          hintText: '18.0', labelText: 'mileage(km/l)'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _primefocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_primefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please Enter a mileage";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please Enter a valid mileage";
                        }
                        if (double.parse(value) < 0) {
                          return "Please Enter a real value";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newcar = Car(
                          id: _newcar.id,
                          Name: _newcar.Name,
                          mileage: double.parse(value),
                          dof: _newcar.dof,
                          number: _newcar.number,
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
                        _newcar = Car(
                          id: _newcar.id,
                          Name: _newcar.Name,
                          mileage: _newcar.mileage,
                          dof: _newcar.dof,
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
