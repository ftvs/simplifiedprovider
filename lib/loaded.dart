import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef Future<T> Load<T>();

class LoadedView<T> extends StatefulWidget {
  final Load<T> _load;
  final Widget Function(BuildContext context, T model) builder;

  LoadedView({Load load, this.builder}) : _load = load;

  @override
  _LoadedViewState<T> createState() => _LoadedViewState<T>();
}

class _LoadedViewState<T> extends State<LoadedView<T>> {
  Future<T> _futureResult;
  
  @override
  void initState() {
    super.initState();

    _futureResult = widget._load();
  }
  
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _futureResult,
      builder: (context, snapshot) {
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
