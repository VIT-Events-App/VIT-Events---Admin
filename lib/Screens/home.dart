import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_event.dart';
import 'new_event.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseFirestore.instance.collection('events').orderBy('priority', descending: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIT Events Admin'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewEvent()));
          },
          child: Icon(Icons.add)),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditEvent(
                                    docToEdit: snapshot.data.docs[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Card(
                          color: Colors.white24,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            height: 220,
                            //color: Colors.grey[400],
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      snapshot.data.docs[index]
                                          .data()['imageUrl']
                                          .toString(),
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data.docs[index].data()['title'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data.docs[index]
                                      .data()['short description'],
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data.docs[index].data()['time'],
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Priority : ${snapshot.data.docs[index].data()['priority']}",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
