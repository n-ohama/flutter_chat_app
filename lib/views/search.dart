import 'package:chat_app/constants.dart';
import 'package:chat_app/model/database.dart';
import 'package:chat_app/views/conversation_screen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();
  QuerySnapshot searchSnapshot;

  searchByUsername() {
    databaseMethods.getUserByUsername(searchController.text).then((value) {
      setState(() => searchSnapshot = value);
    });
  }

  startConversation(String opponentName) {
    if (opponentName != Constants.myName) {
      final chatroomId = getChatRoomId(opponentName, Constants.myName);
      List<String> users = [opponentName, Constants.myName];
      Map<String, dynamic> chatroomMap = {
        "users": users,
        "chatroomId": chatroomId,
      };

      databaseMethods.createChatroom(chatroomId, chatroomMap);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConversationScreen(chatroomId)),
      );
    } else {
      print("it's Me");
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final snapshotMap = searchSnapshot.docs[index].data() as Map;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshotMap["name"],
                          style: simpleTextStyle(),
                        ),
                        Text(
                          snapshotMap["email"],
                          style: simpleTextStyle(),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => startConversation(snapshotMap["name"]),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          snapshotMap["name"] != Constants.myName
                              ? "Message"
                              : "Me",
                          style: simpleTextStyle(),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        : Container();
  }

  @override
  void initState() {
    searchByUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54ffffff),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => searchByUsername(),
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x36ffffff),
                            Color(0x0fffffff),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
