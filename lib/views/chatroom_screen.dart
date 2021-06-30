import 'package:chat_app/constants.dart';
import 'package:chat_app/model/auth.dart';
import 'package:chat_app/model/database.dart';
import 'package:chat_app/model/shared_functions.dart';
import 'package:chat_app/views/conversation_screen.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/widgets/auth_page.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatroomScreen extends StatefulWidget {
  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  AuthMethods authMethods = AuthMethods();
  Stream roomStream;
  getUserInfo() async {
    Constants.myName = await SharedFunctions.sharedUsername();
    setState(
        () => roomStream = databaseMethods.getMyChatrooms(Constants.myName));
  }

  Widget roomStreamBuilder() {
    return StreamBuilder(
      stream: roomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final mapOfRoom = snapshot.data.docs[index].data() as Map;
                  final String opponentName = mapOfRoom["chatroomId"]
                      .replaceAll(
                          RegExp("${Constants.myName}_|_${Constants.myName}"),
                          "");
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ConversationScreen(mapOfRoom["chatroomId"]),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.black26,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              opponentName.substring(0, 1).toUpperCase(),
                              style: simpleTextStyle(),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(opponentName, style: simpleTextStyle()),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
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
              SharedFunctions.saveLoggedIn(false);
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
      body: roomStreamBuilder(),
    );
  }
}
