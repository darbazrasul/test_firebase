import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReadUp extends StatefulWidget {
  const ReadUp({super.key});

  @override
  State<ReadUp> createState() => _ReadUpState();
}

class _ReadUpState extends State<ReadUp> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference users;
  var data;

  @override
  void initState() {
    super.initState();
    users = _db.collection('users');
    data = users.doc('18nc3kXIE5TtjVg1x93J').get();
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
        const SnackBar(content: Text('User set successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to set user: $e')),
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

  Future fetchUser() async {
    setState(() {
      data = users.doc('18nc3kXIE5TtjVg1x93J').get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                fetchUser();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: const Text('ReadUp App'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchUser,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.amber,
              child: FutureBuilder<DocumentSnapshot>(
                future: data,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text(
                      "User: ${data['user']}",
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }

                  return Text(' ');
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: addUser,
            tooltip: 'Add User',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: setUser,
            tooltip: 'Set User',
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: updateUser,
            tooltip: 'Update User',
            child: const Icon(Icons.update),
          ),
        ],
      ),
    );
  }
}
