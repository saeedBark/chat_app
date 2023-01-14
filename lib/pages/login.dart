// ignore_for_file: prefer_const_constructors

import 'package:chat_apps/constants.dart';
import 'package:chat_apps/pages/chatpage.dart';
import 'package:chat_apps/pages/resgister_page.dart';
import 'package:chat_apps/widgets/custom_botton.dart';
import 'package:chat_apps/widgets/custom_text_file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static String id = 'login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;
  //bool isloading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(
                height: 75,
              ),
          Container(
           height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/saeed_bark.jpeg',),),
              color: Colors.white,
              shape: BoxShape.circle,


            ),
          ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    ' Chat',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomFormTextFile(
                onchanged: (data) {
                  email = data;
                },
                hindText: 'Email',
              ),
              SizedBox(
                height: 10,
              ),
              CustomFormTextFile(
                obscureText: true,
                onchanged: (data) {
                  password = data;
                },
                hindText: 'Password',
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      // isloading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        print(e);
                        showSnackBar(context, 'error');
                      }
                      //   isloading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Login'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'don\'t have an accoun ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ResgisterPage.id);
                    },
                    child: Text(
                      '  Register',
                      style: TextStyle(
                        color: Color(0xffc7ede6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
