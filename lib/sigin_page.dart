import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  
  final List<String> _categories = ['Cleaner', 'Programmer', 'Supervisor','Desginer', 'DevOps'];
  String? _selectedCategory;

  Future<void> _createUserRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        
        await _db.collection('userRequests').add({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,  
          'location': _locationController.text,
          'category': _selectedCategory,
          'status': _statusController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'approved': false,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User request created successfully')),
        );

        
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _locationController.clear();
        _statusController.clear();
        setState(() {
          _selectedCategory = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create user request: $e')),
        );
      }
    }
  }

  Future<void> _fetchUserRequests() async {
    try {
      QuerySnapshot querySnapshot = await _db.collection('userRequests').where('approved', isEqualTo: false).get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      for (var doc in docs) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('User Request'),
              content: Text(
                  'Name: ${data['name']}\nEmail: ${data['email']}\nLocation: ${data['location']}\nCategory: ${data['category']}\nStatus: ${data['status']}'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await _approveUserRequest(doc.id, data);
                    Navigator.of(context).pop();
                  },
                  child: Text('Approve'),
                ),
                TextButton(
                  onPressed: () async {
                    await _rejectUserRequest(doc.id);
                    Navigator.of(context).pop();
                  },
                  child: Text('Reject'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user requests: $e')),
      );
    }
  }

  Future<void> _approveUserRequest(String docId, Map<String, dynamic> data) async {
    try {
      String email = data['email'] ?? '';
      String password = data['password'] ?? '';

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email or Password is missing');
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db
          .collection('user')
          .doc('shahanUser')
          .collection('shahanUser')
          .doc(userCredential.user!.uid)
          .set({
        'name': data['name'] ?? '',
        'email': email,
        'location': data['location'] ?? '',
        'category': data['category'] ?? '',
        'status': data['status'] ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });

      
      await _db.collection('userRequests').doc(docId).update({'approved': true});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User approved and created successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve user request: $e')),
      );
    }
  }

  Future<void> _rejectUserRequest(String docId) async {
    try {
      await _db.collection('userRequests').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User request rejected')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject user request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchUserRequests,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createUserRequest,
                child: const Text('Create User Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
