import 'package:flutter/material.dart';
import 'package:flutter_application_learning/todo_app/provider_/username_provider.dart';
import 'package:flutter_application_learning/todo_app/user_data/userData.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(
    text: "emilys",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "emilyspass",
  );
  bool obsecurepassword = true;

  @override
  Widget build(BuildContext context) {
    UsernameProvider provider = Provider.of<UsernameProvider>(
      context,
      listen: false,
    );
    // if (provider.isloading) {
    //   return Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    // if (provider.userData == null) {
    //   return Center(child: Text("no data"));
    // }

    return Scaffold(
      backgroundColor: Color(0xFFE5DDD5),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign in to your account",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: obsecurepassword,
                  decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obsecurepassword = !obsecurepassword;
                        });
                      },
                      icon: Icon(
                        obsecurepassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your password";
                    }
                    if (value.length < 6) {
                      return "password must be atleast 6 characters";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                // onPressed: () {
                //   Provider.of<UsernameProvider>(context, listen: false).login(
                //     context: context,
                //     username: _usernameController.text.trim(),
                //     password: _passwordController.text.trim(),
                //   );
                // },
                onPressed: () {
                  // if (isloading) return;
                  // setState(() => isloading = true);

                  provider.login(
                    context: context,
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim(),
                    expiresInMins: 1,
                  );
                  // setState(() => isloading = false);
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
