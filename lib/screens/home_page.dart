import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/contollers/auth.dart';
import 'package:contacts_app/contollers/crud.dart';
import 'package:contacts_app/contollers/string_extension.dart';
import 'package:contacts_app/screens/update_contact_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<QuerySnapshot> _stream;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchfocusNode = FocusNode();

  @override
  void initState() {
    _stream = CRUDServices().getContacts();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }

  // search function to perform search

  searchContacts(String val) {
    _stream = CRUDServices().getContacts(searchQuery: val);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Contacts",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // implementing search box
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width * .8, 80),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: TextFormField(
                onChanged: (value) =>
                    {searchContacts(value.capitalize()), setState(() {})},
                focusNode: _searchfocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text("Search"),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchfocusNode.unfocus();
                            _stream = CRUDServices().getContacts();
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      child: Text(FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(children: [Text(FirebaseAuth.instance.curr)],),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(FirebaseAuth.instance.currentUser!.email.toString()),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  AuthService().logout();
                  Fluttertoast.showToast(
                    msg: "Logged Out Successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.blue[800],
                    textColor: Colors.white,
                    fontSize: 16,
                  );
                  Navigator.pushReplacementNamed(context, "/loginpage");
                },
                leading: const Icon(Icons.logout_rounded),
                title: const Text("logout"),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/addnewcontact");
          },
          child: const Icon(Icons.person_add),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("Loading"),
                );
              } else {
                return snapshot.data!.docs.isEmpty
                    ? const Center(
                        child: Text(
                          "No contacts Found",
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    : ListView(
                        children: snapshot.data!.docs
                            .map(
                              (DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                return ListTile(
                                  leading: CircleAvatar(
                                      child: Text(data["firstName"][0]
                                          .toString()
                                          .toUpperCase())),
                                  title: Row(
                                    children: [
                                      Text(data["firstName"]),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(data["lastName"]),
                                    ],
                                  ),
                                  subtitle: Text(data["phone"]),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.call),
                                    onPressed: () {},
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateContactPage(
                                            firstName: data["firstName"],
                                            lastName: data["lastName"],
                                            phone: data["phone"],
                                            email: data["email"],
                                            docId: document.id),
                                      ),
                                    )
                                  },
                                );
                              },
                            )
                            .toList()
                            .cast(),
                      );
              }
            }),
      ),
    );
  }
}
