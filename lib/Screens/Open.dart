import 'package:car_rating/Model/padding_Button.dart';
import 'package:flutter/material.dart';
import 'package:car_rating/Screens/Car_info.dart';
import 'package:car_rating/Screens/Car_List.dart';

class Open extends StatelessWidget {
  const Open() : super();
  static const routee = '/Open';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 300.0,
              child: Image.asset('assets/car.png'),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              padding_button(
                  colour: Colors.black,
                  OnPressed: () =>
                      Navigator.of(context).pushNamed(Edit_User_Input.routee),
                  Title: "ADD CAR"),
              SizedBox(
                width: 50,
              ),
              padding_button(
                  colour: Colors.black,
                  OnPressed: () => Navigator.of(context)
                      .pushNamed(User_product_screen.routee),
                  Title: "CAR LIST"),
            ],
          )
        ],
      ),
    );
  }
}
