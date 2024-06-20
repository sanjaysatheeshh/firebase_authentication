import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loadingScreen(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(child: CircularProgressIndicator()),
      );
    },
  );
}
