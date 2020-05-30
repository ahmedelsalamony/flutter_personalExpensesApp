
import 'dart:io';

import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {

  final Function handler;
  AdaptiveFlatButton(this.handler);

  @override
  Widget build(BuildContext context) {
    return FlatButton( child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold)),
      textColor: Theme.of(context).primaryColor,
      onPressed: handler,
    );
  }
}
