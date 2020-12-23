import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Future<T> Load<T>();

class LoadedView<T> extends StatefulWidget {
  final Load<T> _load;
  final Widget Function(BuildContext context, T model) builder;

  LoadedView({Load load, this.builder}) : _load = load;

  @override
  _LoadedViewState createState() => _LoadedViewState<T>();
}

class _LoadedViewState<T> extends State<LoadedView<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget._load(),
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return widget.builder(context, snapshot.data);
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
