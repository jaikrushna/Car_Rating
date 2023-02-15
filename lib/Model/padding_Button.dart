// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

class padding_button extends StatelessWidget {
  final Color colour;
  final VoidCallback OnPressed;
  final String Title;
  const padding_button({
    Key key,
    @required this.colour,
    @required this.OnPressed,
    @required this.Title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: OnPressed,
          minWidth: 70.0,
          height: 42.0,
          child: Text(
            Title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
