import 'package:catch_error/fetch_file.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var file = 'assets/test1.txt';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Catch error'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text('test good file'),
              onPressed: () {
                setState(() {
                  file = 'assets/artists.txt';
                });
              }),
          RaisedButton(
              child: Text('test bad file'),
              onPressed: () {
                setState(() {
                  file = 'assets/data.txt';
                });
              }),
          Expanded(
            child: FutureBuilder<String>(
              future: fetchFileFromAssets(file),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text('NONE'),
                    );
                    break;
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  case ConnectionState.done:
                      return Text(snapshot.data);
                    break;
                  default:
                    return SingleChildScrollView(
                      child: Text('Default'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
