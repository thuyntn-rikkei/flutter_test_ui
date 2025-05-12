import 'package:flutter/material.dart';

import 'user.dart';
class AddNewUserScreen extends StatefulWidget {
  final String title;

  const AddNewUserScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUserScreen> {
  final Map<String, TextEditingController> controllers = {
    'username': TextEditingController(),
    'fullname': TextEditingController(),
    'email': TextEditingController(),
    'age': TextEditingController(),
    'job': TextEditingController(),
  };

  bool isGirl = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserInformationItemWidget(label: 'Username', controller: controllers['username']!),
            UserInformationItemWidget(label: 'Full Name', controller: controllers['fullname']!),
            UserInformationItemWidget(label: 'Email', controller: controllers['email']!),
            UserInformationItemWidget(label: 'Age', controller: controllers['age']!),
            UserInformationItemWidget(label: 'Job', controller: controllers['job']!),

            RadioListTile<bool>(
              title: Text('Male'),
              value: false,
              groupValue: isGirl,
              onChanged: (bool? value) {
                setState(() {
                  isGirl = value!;
                });
              },
            ),
            RadioListTile<bool>(
              title: Text('Female'),
              value: true,
              groupValue: isGirl,
              onChanged: (bool? value) {
                setState(() {
                  isGirl = value!;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                    saveUserInformation(
                      context,
                      controllers['username']!.text,
                      controllers['fullname']!.text,
                      controllers['email']!.text,
                      int.parse(controllers['age']!.text),
                      isGirl,
                      controllers['job']!.text,
                    );
                },
                child: Text('Submit'),
              ),
            )

          ]
        ),
      ),
    );
  }
}

class UserInformationItemWidget extends StatelessWidget{
  final String label;
  final TextEditingController controller;

  const UserInformationItemWidget({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
   return Container(
     margin: EdgeInsets.only(bottom: 16),
     child: TextField(
       decoration: InputDecoration(
         border: OutlineInputBorder(),
         labelText: label,
       ),
       keyboardType: TextInputType.name,
       controller: controller,
     ),
   );
  }
}

void saveUserInformation(
  BuildContext context,
  String username,
  String fullname,
  String email,
  int age,
  bool isGirl,
  String job,
){
  var user = User(username: username, fullname: fullname, email: email, age: age, isGirl: isGirl, job: job);
  print("Add new user ${user.toString()}");
  Navigator.pop(context, user);
}