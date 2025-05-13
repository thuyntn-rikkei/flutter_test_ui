import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<int> streamInts;

  @override
  void initState() {
    super.initState();
    streamInts = Stream.periodic(Duration(seconds: 1), (count) => count);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),
        body: Center(
          child: StreamBuilder(
            stream: streamInts,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.none) return Text("No data");
              else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                print("Data ${asyncSnapshot.data},Error ${asyncSnapshot.error}");
                return Text("Waiting for data");
              } else if (asyncSnapshot.connectionState == ConnectionState.active) {
                print("Data ${asyncSnapshot.data},Error ${asyncSnapshot.error}",);
                if (asyncSnapshot.hasData) return Text("Data ${asyncSnapshot.data}");
                if (asyncSnapshot.hasError) return Text("Error ${asyncSnapshot.error}");
                return Text("No data");
              } else {
                return Text("Stream closed");
              }
            },
          ),
        ),
      ),
    );
  }
}
