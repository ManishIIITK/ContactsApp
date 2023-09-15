import 'package:contacts_app/contollers/crud.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _firstNameContoller = TextEditingController();
  final TextEditingController _lastNameContoller = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Create New Contact",style: TextStyle(fontWeight: FontWeight.bold))),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? "First Name cannot be empty" : null,
                    controller: _firstNameContoller,
                    decoration:InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("First Name"),
                      prefixIcon: const Icon(Icons.person)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    controller: _lastNameContoller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("Last Name"),
                      prefixIcon: const Icon(Icons.person)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? "Phone Number cannot be empty" : null,
                    controller: _phoneContoller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("Phone"),
                      prefixIcon: const Icon(Icons.phone)
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)) {
                          return ("Please enter a valid email ");
                        }
                        // regular expression for the email. If the user try to enter some illegal thing other than the email then it will throw an error
                      }
                      return null;
                    },
                    controller: _emailContoller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: const Text("Email"),
                      prefixIcon: const Icon(Icons.email)
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
                        CRUDServices().createNewContact(
                            _firstNameContoller.text,
                            _lastNameContoller.text,
                            _phoneContoller.text,
                            _emailContoller.text);
                        Fluttertoast.showToast(
                          msg: "Added to Contact",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.blue[800],
                          textColor: Colors.white,
                          fontSize: 16,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Save",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
