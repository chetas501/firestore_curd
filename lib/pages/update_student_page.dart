import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String? id;
  const UpdateStudentPage({Key? key, this.id}) : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({
          'name': name,
          'email': email,
          'password': password,
        })
        .then((value) => print('Updated User'))
        .catchError((error) => print('Failed to update user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Student"),
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('students')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something when wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            var data = snapshot.data!.data();
            var name = data!['name'];
            var email = data['email'];
            var password = data['password'];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    initialValue: name,
                    autofocus: false,
                    onChanged: (value) => name = value,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    initialValue: email,
                    autofocus: false,
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    initialValue: password,
                    obscureText: true,
                    autofocus: false,
                    onChanged: (value) => password = value,
                    decoration: InputDecoration(
                        labelText: password,
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      } else if (value.length < 6) {
                        return 'It should be min of 6 char';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updateUser(widget.id, name, email, password);
                              Navigator.pop(context);
                            }
                            ;
                          },
                          child:
                              Text("Update", style: TextStyle(fontSize: 18))),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Reset', style: TextStyle(fontSize: 18)),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      )
                    ],
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}