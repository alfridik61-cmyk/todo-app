import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/homepage.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_learning/todo_app/Auth_page/Auth_page.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UsernameProvider>(context, listen: false).userdata(context);

  }
  
  

  void logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("LOGOUT"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AuthPage()),
                );
              },
              child: Text("logout"),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final userprovider = Provider.of<UsernameProvider>(context);
    final userdata = userprovider.userData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 167, 187),
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(100),
          child: Text("Profile"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("First Name : ${userdata.firstName}"),
          Text("Last Name : ${userdata.lastName}"),
          Text("Email: ${userdata.email}"),
        ],
      ),
    );
  }
}
