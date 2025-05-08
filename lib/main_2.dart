import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final user = User(
    "User1",
    "Nguyen Van A",
    "user1@gmail.com",
    20,
    true,
    "Developer",
  );

  @override
  Widget build(BuildContext context) {
    print("MyApp rebuild");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(user: user, title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final User? user;
  final String title;

  const MyHomePage({super.key, this.user, required this.title});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late final User? user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    print("MyHomePageState rebuild");
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: UserInheritedWidget(
        user,
        child: const UserInformationWidget(),
      ),
    );
  }
}

class UserInheritedWidget extends InheritedWidget {
  final User? user;

  const UserInheritedWidget(this.user, {super.key, required super.child});

  static UserInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserInheritedWidget>();
  }

  @override
  bool updateShouldNotify(UserInheritedWidget oldWidget) {
    return user != oldWidget.user;
  }
}

class GeneralInformationWidget extends StatelessWidget {
  const GeneralInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("GeneralInformationWidget rebuild");
    final user = UserInheritedWidget.of(context)?.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("General Information"),
        Text(user?.username ?? "Username"),
        Text(user?.fullname ?? "Fullname"),
        Text(user?.email ?? "Email"),
        Text(user?.age?.toString() ?? "Age"),
        Text(user?.isGirl == true ? "Woman" : "Man"),
      ],
    );
  }
}

class JobInformationWidget extends StatelessWidget {
  const JobInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("JobInformationWidget rebuild");
    final user = UserInheritedWidget.of(context)?.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Job Information"),
        Text(user?.job ?? "Job"),
      ],
    );
  }
}

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print("UserInformationWidget rebuild");
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text("User Information"),
            GeneralInformationWidget(),
            SizedBox(height: 20),
            JobInformationWidget(),
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

  User(this.username, this.fullname, this.email, this.age, this.isGirl, this.job);
}
