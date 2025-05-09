import 'package:flutter/material.dart';

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
  final List<User> userList = [
    User(
      username: "username1",
      fullname: "Full Name 1",
      email: "user1@gmail.com",
      age: 10,
      isGirl: true,
      job: "Student",
      imageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHAh6rdeZkX7aDKMyQahJvRgnNM2BJDWlkhKIuHX7vVT8KMTR2lP-r3P-yKdkBahzpf3g&usqp=CAU",
    ),
    User(
      username: "username2",
      fullname: "Full Name 2",
      email: "user2@gmail.com",
      age: 20,
      isGirl: false,
      job: "Engineer",
      imageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS16w0fMl0goS525bVU6MN5rwc_9DqfbQAdUQ&s",
    ),
    User(
      username: "username3",
      fullname: "Full Name 3",
      email: "user3@gmail.com",
      age: 30,
      isGirl: true,
      job: "Doctor",
      imageUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVvcb1jc0Mz2y9RIwk7d4R07doX3M9LXSYYTGBiOdPY1jlg7qWCL5pf0mVX5iGHCeEYyI&usqp=CAU",
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return UserInformationWidget(user: _users[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemCount: _users.length,
    );
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
                    Image(image: NetworkImage(user.imageUrl ?? imagePlaceHolderUrl)),
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
}
