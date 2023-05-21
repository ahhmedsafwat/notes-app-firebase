import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text('please Wait'),
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        actions: [],
      );
    },
  );
}
