import 'package:flutter/material.dart';

import 'fetch_file.dart';

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
      home: MyHomePage(title: 'Load file'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String result = '';
  Future<String> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchFileFromAssets('assets/$name.txt');
  }

  final poiskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.black, width: 2.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: poiskController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 15, bottom: 15),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                name = poiskController.text;
                                _dataFuture = fetchFileFromAssets('assets/$name.txt');
                              });
                            },
                            child: Text(
                              'Найти',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<String>(
                    future: _dataFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text(
                                'Подключение потсутсвуте, пожалуйтса введите имя файла и нажмите Найти'),
                          );
                          break;
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.done:
                          return SingleChildScrollView(
                              child: Text(snapshot.data));
                          break;
                        default:
                          return SingleChildScrollView(
                            child: Text('Default'),
                          );
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
