import 'package:contacts_app/contollers/string_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDServices {
  User? user = FirebaseAuth.instance.currentUser;

  // create new contact to the firestore

  Future createNewContact(String firstName,String lastName, String phone, String email) async {
    Map<String, dynamic> data = {
      "firstName": firstName.capitalize(),
      "lastName":lastName,
      "phone": phone,
      "email": email
    };
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .add(data);
      print("New Contact Created");
    } catch (err) {
      print(err.toString());
    }
  }

  // read contacts from firestore
  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("contacts")
        .orderBy("firstName");

    // perform serach
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = "$searchQuery\uf8ff";
      contactsQuery = contactsQuery.where("firstName",
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }
    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  //

  // updating the existing contact
  Future updateContact(
      String firstName,String lastName, String phone, String email, String docId) async {
    Map<String, dynamic> data = {"firstName": firstName, "lastName" : lastName, "email" : email, "phone": phone};
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docId)
          .update(data);
      print("Contact Update");
    } catch (err) {
      print(err.toString());
    }
  }

  // delete the existing contact
  Future deleteContact(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("contacts")
          .doc(docId)
          .delete();
      print("Contact removed");
    } catch (err) {
      print(err.toString());
    }
  }
}
