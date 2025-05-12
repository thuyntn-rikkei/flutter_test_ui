import 'package:flutter/material.dart';

import 'user.dart';

class ListUserInformationScreen extends StatefulWidget {
  final List<User> users;

  const ListUserInformationScreen({super.key, required this.users});

  @override
  State<StatefulWidget> createState() {
    return ListUserInformationScreenState();
  }
}

class ListUserInformationScreenState extends State<ListUserInformationScreen> {

  @override
  void initState() {
    super.initState();
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