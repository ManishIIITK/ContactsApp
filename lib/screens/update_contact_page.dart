import 'package:contacts_app/contollers/crud.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateContactPage extends StatefulWidget {
  const UpdateContactPage(
      {super.key,
      required this.docId,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email});
  final String docId, firstName, lastName, phone, email;

  @override
  State<UpdateContactPage> createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  final TextEditingController _firstNameContoller = TextEditingController();
  final TextEditingController _lastNameContoller = TextEditingController();
  final TextEditingController _phoneContoller = TextEditingController();
  final TextEditingController _emailContoller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameContoller.text = widget.firstName;
    _lastNameContoller.text = widget.lastName;
    _phoneContoller.text = widget.phone;
    _emailContoller.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Update Contact",style: TextStyle(fontWeight: FontWeight.bold))),
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
                        val!.isEmpty ? "Name cannot be empty" : null,
                    controller: _firstNameContoller,
                    decoration: InputDecoration(
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
                        CRUDServices().updateContact(
                            _firstNameContoller.text,
                            _lastNameContoller.text,
                            _phoneContoller.text,
                            _emailContoller.text,
                            widget.docId);
                      }
                      Fluttertoast.showToast(
                        msg: "Contact Updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blue[800],
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Update",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      CRUDServices().deleteContact(widget.docId);
                      Fluttertoast.showToast(
                        msg: "Contact Deleted",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blue[800],
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
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
