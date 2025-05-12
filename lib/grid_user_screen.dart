import 'package:flutter/material.dart';

import 'user.dart';

class GridListUserInformationScreen extends StatefulWidget {
  final List<User> users;

  const GridListUserInformationScreen({super.key, required this.users});

  @override
  State<GridListUserInformationScreen> createState() => GridListUserInformationScreenState();
}

class GridListUserInformationScreenState extends State<GridListUserInformationScreen> {

  @override
  void initState() {
    super.initState();
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
      itemCount: widget.users.length,
      itemBuilder: (BuildContext context, int index) {
        return GridUserInformationWidget(user: widget.users[index]);
      },
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