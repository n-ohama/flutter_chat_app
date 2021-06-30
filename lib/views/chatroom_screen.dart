import 'package:chat_app/constants.dart';
import 'package:chat_app/model/auth.dart';
import 'package:chat_app/model/shared_functions.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/widgets/auth_page.dart';
import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  AuthMethods authMethods = AuthMethods();
  setUserName() async {
    Constants.myName = await SharedFunctions.sharedUsername();
  }

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AuthPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        ),
      ),
    );
  }
}
