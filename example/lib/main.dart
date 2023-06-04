import 'package:flutter/material.dart';
import 'package:wave_navigation_bar/wave_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave Navigation Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wave Navigation Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _bottomNavigationKey = GlobalKey<WaveNavigationBarState>();

  int _currentPage=0;

  @override
  Widget build(BuildContext context) {
 
      return Scaffold(

        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_currentPage.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ),

        bottomNavigationBar: WaveNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 75.0,
          selectedIconBackgrounColor: Colors.black,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          onChanged:(int index){
            setState(() {

              _currentPage=index;
            });
          },
          items: const [
            Icon(
                Icons.home_outlined,size: 30,),

            Icon(
                Icons.history,size: 30,),
            Icon(
                Icons.person_pin,size: 30,),
          ],
        ),
      );


   
 
  }
}
