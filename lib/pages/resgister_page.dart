// ignore_for_file: unused_local_variable, prefer_const_constructors, must_be_immutable

import 'package:chat_apps/constants.dart';
import 'package:chat_apps/pages/chatpage.dart';
import 'package:chat_apps/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custom_text_file.dart';

class ResgisterPage extends StatefulWidget {
  ResgisterPage({Key? key}) : super(key: key);
  static String id = 'register page';

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  String? email;

  String? password;

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
                children: [
                  Text(
                    'Scholar Chat',
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
                'REGISTER',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
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
                    //     isloading = true;
                    setState(() {});
                    try {
                      await registerUser();
                      Navigator.pushNamed(context, ChatPage.id);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showSnackBar(
                            context, 'The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        showSnackBar(
                            context, 'The account already exists for that');
                      }
                    } catch (e) {
                      showSnackBar(context, 'error');
                    }
                    //  isloading = false;
                    setState(() {});
                  } else {}
                },
                text: 'Register',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Text(
                      '  Login',
                      style: TextStyle(
                        color: Color(0xffc7ede6),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 77,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
