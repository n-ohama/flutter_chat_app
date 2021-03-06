import 'package:chat_app/model/auth.dart';
import 'package:chat_app/model/database.dart';
import 'package:chat_app/model/shared_functions.dart';
import 'package:chat_app/views/chatroom_screen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() => isLoading = true);
      Map<String, String> userMap = {
        "name": nameController.text,
        "email": emailController.text,
      };
      SharedFunctions.saveUsername(nameController.text);
      SharedFunctions.saveUsermail(emailController.text);
      authMethods
          .signUpWithEmailAndPassword(emailController.text, passController.text)
          .then((value) {
        print(value.uid);
        databaseMethods.uploadUserInfo(userMap);
        SharedFunctions.saveLoggedIn(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatroomScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 200,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                return value.length < 4
                                    ? "Please provide a valid username"
                                    : null;
                              },
                              controller: nameController,
                              style: simpleTextStyle(),
                              decoration: textFieldDecoration("username"),
                            ),
                            TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please provide a valid email";
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: simpleTextStyle(),
                              decoration: textFieldDecoration("email"),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : "Please provide 6+ character password";
                              },
                              controller: passController,
                              style: simpleTextStyle(),
                              decoration: textFieldDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Forget Password?",
                          style: simpleTextStyle(),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => signMeUp(),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff007ef4),
                                Color(0xff2a75bc),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Sign Up",
                            style: simpleTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Sign Up with Google",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have account? ",
                              style: simpleTextStyle()),
                          GestureDetector(
                            onTap: () => widget.toggle(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "SignIn now",
                                style: underLineStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
