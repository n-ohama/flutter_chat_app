import 'package:chat_app/model/auth.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  signInMe() {
    if (formKey.currentState.validate()) {
      setState(() => isLoading = true);
      authMethods
          .signInWithEmailAndPassword(emailController.text, passController.text)
          .then((value) {
        print(value.uid);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
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
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : "Please provide 6+ character password";
                              },
                              controller: passController,
                              obscureText: true,
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
                        onTap: () => signInMe(),
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
                            "Sign In",
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
                          "Sign In with Google",
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account? ",
                              style: simpleTextStyle()),
                          Text("Register now", style: underLineStyle()),
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
