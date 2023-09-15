import 'package:contacts_app/contollers/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text("Sign Up",
                      style: GoogleFonts.sora(
                          fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Please enter your email");
                        }
                        // regular expression for the email. If the user try to enter some illegal thing other than the email then it will throw an error
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)) {
                          return ("Please enter a valid email ");
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label:const Text("Email"),
                        prefixIcon: const Icon(Icons.email)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Password field cannot be empty");
                        }
                        if (value.toString().length < 6) {
                          return ("Password cannot be less than 6 digit");
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.password)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: TextFormField(
                      controller: _confirmpasswordController,
                      validator: (val) {
                        if (_passwordController.text !=
                            _confirmpasswordController.text) {
                          return "Password do not match";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text("Confirm Password"),
                        prefixIcon: const Icon(Icons.password)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .7,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthService()
                              .createAccountWithEmail(_emailController.text,
                                  _passwordController.text)
                              .then(
                                (value) => {
                                  if (value == "Account Created Successfully")
                                    {
                                      Fluttertoast.showToast(
                                        msg: "Account Created Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.blue[800],
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      ),
                                      Navigator.pushReplacementNamed(
                                          context, "/homepage")
                                    }
                                  else
                                    {
                                      Fluttertoast.showToast(
                                        msg: "Unable to create account",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.blue[800],
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      ),
                                    }
                                },
                              );
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    child: OutlinedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/google_logo.png",
                            height: 25,
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          const Text(
                            "Continue with Google",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onPressed: () {
                        AuthService().continueWithGoogle().then(
                              (value) => {
                                if (value == "Login Successfull")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Logged In Successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.blue[800],
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    ),
                                    Navigator.pushReplacementNamed(
                                        context, "/homepage")
                                  }
                                else
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Unable to Login",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.blue[800],
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    ),
                                  }
                              },
                            );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    child: OutlinedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Facebook-logo.png",
                            height: 35,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            "Continue with Facebook",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onPressed: () {
                        AuthService().continueWithFacebook().then(
                              (value) => {
                                if (value == "Login Successfull")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Logged In Successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.blue[800],
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    ),
                                    Navigator.pushReplacementNamed(
                                        context, "/homepage")
                                  }
                                else
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Unable to Login",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.blue[800],
                                      textColor: Colors.white,
                                      fontSize: 16,
                                    ),
                                  }
                              },
                            );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have an Account ? "),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Login"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
