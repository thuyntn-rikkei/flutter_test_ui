import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter View Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter View Example'),
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

class ListUserInformationScreen extends StatefulWidget {
  final List<User> users;

  const ListUserInformationScreen({super.key, required this.users});

  @override
  State<StatefulWidget> createState() {
    return ListUserInformationScreenState();
  }
}

class ListUserInformationScreenState extends State<ListUserInformationScreen> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    _users = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    print("ListUserInformationScreenState build");
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return UserInformationWidget(user: widget.users[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount:widget.users.length,
    );
  }

  @override
  void didUpdateWidget(covariant ListUserInformationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.users != widget.users) {
      _users = widget.users;
    }
  }
}

class GridListUserInformationScreen extends StatefulWidget {
  final List<User> users;

  const GridListUserInformationScreen({super.key, required this.users});

  @override
  State<GridListUserInformationScreen> createState() => GridListUserInformationScreenState();
}

class GridListUserInformationScreenState extends State<GridListUserInformationScreen> {
  late List<User> _users;

  @override
  void initState() {
    super.initState();
    _users = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    print("GridListUserInformationScreenState build");
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 3 / 9.5,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemCount: _users.length,
      itemBuilder: (BuildContext context, int index) {
        return GridUserInformationWidget(user: _users[index]);
      },
    );
  }

  @override
  void didUpdateWidget(covariant GridListUserInformationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.users != widget.users) {
      _users = widget.users;
    }
  }
}


class UserInformationWidget extends StatelessWidget {
  final User user;
  final imagePlaceHolderUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";

  const UserInformationWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print("UserInformationWidget rebuild");
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              "User Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Card(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "General Information",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                user.username ?? "Username",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text(
                              "Full Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                user.fullname ?? "Fullname",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                user.email ?? "Email",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text(
                              "Age",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                user.age?.toString() ?? "Age",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                user.isGirl == true ? "Woman" : "Man",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        const Text(
                          "Job Information",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Current Job",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(user.job ?? "Job", textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Image(image: NetworkImage(user.imageUrl ?? imagePlaceHolderUrl)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Active",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridUserInformationWidget extends StatelessWidget {
  final User user;
  final imagePlaceHolderUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";

  const GridUserInformationWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print("GridUserInformationWidget rebuild");
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "General Information",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Username",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.username ?? "Username",
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "Full Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.fullname ?? "Fullname",
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.email ?? "Email",
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "Age",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.age?.toString() ?? "Age",
                      textAlign: TextAlign.right,
                    ),
                    const Text(
                      "Gender",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.isGirl == true ? "Woman" : "Man",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 20),
                    const Text(
                      "Job Information",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Current Job",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user.job ?? "Job", textAlign: TextAlign.right),
                    SizedBox(height: 20),
                    Image(image: AssetImage("assets/flutter.png")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<User>> loadUsers() async {
  final String response = await rootBundle.loadString('assets/users.json');
  final List<dynamic> data = json.decode(response);

  return data.map((json) => User.fromJson(json)).toList();
}

class User {
  final String? username;
  final String? fullname;
  final String? email;
  final int? age;
  final bool? isGirl;
  final String? job;
  final String? imageUrl;

  User({
    this.username,
    this.fullname,
    this.email,
    this.age,
    this.isGirl,
    this.job,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      age: json['age'],
      isGirl: json['isGirl'],
      job: json['job'],
      imageUrl: json['imageUrl'],
    );
  }
}
