import 'package:flutter/material.dart';
import 'package:urban_fit/assets/model/user_model.dart';
import 'package:urban_fit/screens/sign_in_screen.dart';
import 'package:urban_fit/service/database_helper.dart';
import 'package:urban_fit/utils/commom_widgets/common_appbar.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final RegExp _mobileRegex = RegExp(r'^[0-9]{10}$');
  final RegExp _nameRegex = RegExp(r"^[A-Za-z].{5,}$");
  final RegExp _passwordRegex = RegExp(r'^.{6,}$');
  final RegExp _emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

  DataBaseHelper? database;
  List<UserModel> usertable = [];

  Future<void> createUsers() async {
    const snackBar = SnackBar(
      content: Text("User Account is created"),
      duration: Duration(milliseconds: 1000),
    );
    if (_formKey.currentState!.validate()) {
      final UserModel createNewUser = UserModel(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          mobile: _mobileController.text);
      await database!.createUser(createNewUser);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SigninPage()),
      );
    } else {
      const snackBar = SnackBar(
          content: Text("User Account is not created"),
          duration: Duration(milliseconds: 1000));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    database = DataBaseHelper.instance;
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '',
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Welcome to Urban Fit!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Create account",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        } else if (!_nameRegex.hasMatch(value)) {
                          return 'Enter name with 1st character capital & atleast 6 character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a mobile number';
                        } else if (!_mobileRegex.hasMatch(value)) {
                          return 'Please enter a 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email address';
                        } else if (!_emailRegex.hasMatch(value)) {
                          return 'Please enter a email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        } else if (!_passwordRegex.hasMatch(value)) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _getButtonWidget(
                      header: 'Sign Up',
                      textSize: 20,
                      borderColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Have an account?",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  _getButtonWidget(
                    header: 'Sign In',
                    textSize: 20,
                    borderColor: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
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
        if (_formKey.currentState!.validate() && header == 'Sign Up') {
          createUsers();
        }
        if (header == 'Sign In') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SigninPage()),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.26,
        height: MediaQuery.of(context).size.height / 14.4,
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
