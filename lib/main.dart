import 'package:flutter/material.dart';
import 'package:simplifiedprovider/loaded.dart';
import 'package:simplifiedprovider/post.dart';

import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoadedView<List<Post>>(
              load: () => api.posts(),
              builder: (_, model) {
                return Column(children: [
                  Text(model[0].title),
                  Text(model[1].title),
                ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
