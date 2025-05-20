import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../component/tcolor.dart';
import '../../../screens/clipper.dart';
import '../shared/colors.dart';
import '../shared/contants.dart';
import '../shared/snackbar.dart';
import 'register.dart';
import '../../../screens/firstscreen.dart'; // صفحة رئيسية بعد تسجيل الدخول

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // التحقق من الإدخال
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, "Please fill in all fields");
      return;
    }

    // إظهار مؤشر تحميل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // الانتقال للصفحة الرئيسية بعد تسجيل الدخول
      if (!mounted) return;
      Navigator.pop(context); // إغلاق الـ loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Firstscreen()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // إغلاق الـ loading
      showSnackBar(context, "Error: ${e.message}");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Tcolor.background, // لو أردت لون عادي: Colors.white
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: ClipperImage(),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Tcolor.background,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Tcolor.buttonColor),
                  ),
                ),

                SizedBox(height: 64),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter your email",
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 33),
                TextField(
                  controller: passwordController,
                  obscureText: !isVisable,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      icon: Icon(
                        isVisable ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 33),
                ElevatedButton(
                  onPressed: signIn,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 19, color: Tcolor.background),
                  ),
                ),
                const SizedBox(height: 33),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Register()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.black, fontSize: 18),
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
