import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Boton 1')),
            ElevatedButton(onPressed: () {}, child: Text('Boton 2')),
            ElevatedButton(onPressed: () {}, child: Text('Boton 3')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Boton 4')),
                ElevatedButton(onPressed: () {}, child: Text('Boton 5')),
                ElevatedButton(onPressed: () {}, child: Text('Boton 6')),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Boton 7')),
                ElevatedButton(onPressed: () {}, child: Text('Buton 8')),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Boton 9')),
                ElevatedButton(onPressed: () {}, child: Text('Buton 10')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
