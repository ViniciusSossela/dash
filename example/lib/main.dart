import 'package:dash/dash.dart';
import 'package:example/state_management.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage('Flutter and Dash Home Page'),
    );
  }
}

class MyHomeBloc extends Bloc {
  static MyHomeBloc instance() => MyHomeBloc();

  final _counter = BehaviorSubject<int>.seeded(0);
  Stream<int> get counter => _counter.stream;
  Function(int) get updateCounter => _counter.sink.add;

  increment() => updateCounter((_counter.value ?? 0) + 1);

  @override
  dispose() {
    _counter.close();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = $Provider().of<MyHomeBloc>();

  @override
  void dispose() {
    $Provider().dispose<MyHomeBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: _bloc.counter,
              builder: (context, snap) => snap.hasData
                  ? Text(
                      '${snap.data}',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  : Text('loading...'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bloc.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
