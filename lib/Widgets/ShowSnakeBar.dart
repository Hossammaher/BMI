
import 'package:flutter/material.dart';


class ShowSnakeBar {

  void showSnakeBarr(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

}



