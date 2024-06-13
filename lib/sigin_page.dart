import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReadUp extends StatefulWidget {
  const ReadUp({super.key});

  @override
  State<ReadUp> createState() => _ReadUpState();
}

class _ReadUpState extends State<ReadUp> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference users;

  @override
  void initState() {
    super.initState();
    users = _db.collection('users');
  }

  Future<void> addUser() async {
    try {
      await users.add({
        'user': 'darbaz',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
    }
  }

   

  Future<void> setUser() async {
    try {
      await users.doc('18nc3kXIE5TtjVg1x93J').set({
        'user': 'navid',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add user: $e')),
      );
    }
  }

  Future<void> updateUser() async {
    try {
      await users.doc('18nc3kXIE5TtjVg1x93J').update({
        'user': 'sdfghbj',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadUp App'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: TextButton(
            onPressed: () async {
              await updateUser();
            },
            child: const Text('Add User'),
          ),
        ),
      ),
    );
  }
}
