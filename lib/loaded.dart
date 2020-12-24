import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Future<T> Load<T>();

class LoadedView<T> extends StatelessWidget {
  final Load<T> _load;
  final Widget Function(BuildContext context, T model) builder;

  LoadedView({Load load, this.builder}) : _load = load;

  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _load(),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          print("load error ${snapshot.error}");
          return Text("Error loading content.");
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}
