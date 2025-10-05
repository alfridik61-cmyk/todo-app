import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/homepage.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';
import 'package:flutter_application_learning/todo_app/user_data/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_learning/todo_app/Auth_page/Auth_page.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // final List<UserData> _userdata = [];
  // List<UserData> get userdata => _userdata;
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
    final isloading = userprovider.isloading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white12,
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
      body: Center(
        child: userdata == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://dummyjson.com/icon/emilys/128",
                        ),
                        radius: 30,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "First Name : ${userdata.firstName}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Last Name : ${userdata.lastName}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Age : ${userdata.age}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Gender : ${userdata.gender}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Email : ${userdata.email}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Phone : ${userdata.phone}",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Username : ${userdata.username}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
      ),

      // body: child: if(userdata.username == null){

      // }
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [

      //     Text("First Name : ${userdata.firstName}"),
      //     Text("Last Name : ${userdata.lastName}"),
      //     Text("Email: ${userdata.email}"),
      //   ],
      // ),
    );
  }
}
