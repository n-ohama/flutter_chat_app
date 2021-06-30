import 'package:chat_app/constants.dart';
import 'package:chat_app/model/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatroomId;
  ConversationScreen(this.chatroomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream messageStream;

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMap = {
        "message": messageController.text,
        "sender": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversation(widget.chatroomId, chatMap);
      messageController.text = "";
    }
  }

  Widget conversationStreamBuilder() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final mapOfMessage = snapshot.data.docs[index].data() as Map;
                  final bool isSender =
                      mapOfMessage["sender"] == Constants.myName;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    alignment:
                        isSender ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isSender ? myColorList : opponentColorList,
                        ),
                        borderRadius: isSender ? myRadius : opponentRadius,
                      ),
                      child: Text(
                        mapOfMessage["message"],
                        style: simpleTextStyle(),
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
    setState(() =>
        messageStream = databaseMethods.getConversation(widget.chatroomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            conversationStreamBuilder(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54ffffff),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => sendMessage(),
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
                        child: Image.asset("assets/images/send.png"),
                      ),
                    ),
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

// class MessageTile extends StatelessWidget {
//   final String message;
//   MessageTile({this.message});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(
//         message,
//         style: simpleTextStyle(),
//       ),
//     );
//   }
// }
