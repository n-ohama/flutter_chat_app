import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .where("name", isEqualTo: username)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByUserEmail(String userEmail) async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();
    } catch (e) {
      print(e.toString());
    }
  }

  uploadUserInfo(userMap) {
    try {
      FirebaseFirestore.instance.collection("users").add(userMap);
    } catch (e) {
      print(e.toString());
    }
  }

  createChatroom(String chatroomId, Map chatroomMap) {
    try {
      FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatroomId)
          .set(chatroomMap);
    } catch (e) {
      print(e.toString());
    }
  }

  getConversation(String chatroomId) {
    try {
      return FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatroomId)
          .collection("chats")
          .orderBy("time", descending: false)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  addConversation(String chatroomId, chatMap) {
    try {
      FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatroomId)
          .collection("chats")
          .add(chatMap);
    } catch (e) {
      print(e.toString());
    }
  }

  getMyChatrooms(String username) {
    try {
      return FirebaseFirestore.instance
          .collection("chatroom")
          .where("users", arrayContains: username)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }
}
