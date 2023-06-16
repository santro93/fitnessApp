import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_fit/screens/dashboard_screen.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';
import 'package:urban_fit/utils/constant.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? finalEmail;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //////////////////   Email  Sign  In  /////////////
  Future<void> signInButton() async {
    const snackBar = SnackBar(
      content: Text("User is logged In"),
      duration: Duration(milliseconds: 1000),
    );
    if (_formKey.currentState!.validate() &&
        emailController.text == "test@gmail.com" &&
        passwordController.text == "1234567") {
      try {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(isLoggedInkey, true);
      } catch (err) {
        String result = err.toString();
        log(result);
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ));
    } else {
      const snackBar = SnackBar(
          content: Text("User Can't logged In"),
          duration: Duration(milliseconds: 1000));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '',
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Email",
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.name,
                  controller: passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter Password",
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "Forgot Password ?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _getButtonWidget(
                  header: 'Sign in',
                  textSize: 20,
                  borderColor: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Don't have an account ?",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                _getButtonWidget(
                  header: 'Sign Up',
                  textSize: 20,
                  borderColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtonWidget({
    String? header,
    Color? color,
    double? textSize,
    Color? textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate() && header == 'Sign in') {
          signInButton();
        }
        if (_formKey.currentState!.validate() && header == 'Sign Up') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height / 12.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          border: Border.all(color: borderColor!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                header!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
