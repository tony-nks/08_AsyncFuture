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
  var file = 'assets/data2.txt';

  dynamic result;
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
              child: Text('Button 1'),
              onPressed: () {
                setState(() {
                  file = 'assets/artists.txt';
                  result = fetchFileFromAssets(file);
                });
              }),
          RaisedButton(
              child: Text('Button 2'),
              onPressed: () {
                setState(() {
                  file = 'assets/data.txt';
                  result = fetchFileFromAssets(file);
                });
              }),
          Expanded(
            child: FutureBuilder<String>(
              future: result,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: snapshot.data,
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
