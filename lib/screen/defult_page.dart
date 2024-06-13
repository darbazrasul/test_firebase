import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Default Page'),
      ),
      body: Center(
        child: Text('Welcome User!'),
      ),
    );
  }
}
