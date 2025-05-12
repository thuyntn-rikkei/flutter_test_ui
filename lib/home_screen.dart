import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_ui/Routes.dart';

import 'grid_user_screen.dart';
import 'list_user_screen.dart';
import 'user.dart';

import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  List<User> userList = [];
  bool isLoading = true;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("My Home Page State build");
    // if (isLoading) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    final List<Widget> views = [
      ListUserInformationScreen(users: userList), // Linear View
      GridListUserInformationScreen(users: userList)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.linear_scale),
            label: 'Linear View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Grid View',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.push(Routes.addNewUser);

          if (result != null && result is User) {
            setState(() {
              userList.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadUsers().then((users) {
      setState(() {
        userList = users;
        isLoading = false;
      });
    });
  }
}

Future<List<User>> loadUsers() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final List<dynamic> data = json.decode(response);

  return data.map((json) => User.fromJson(json)).toList();
}