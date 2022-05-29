import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:scoopy/news_model.dart';

class HomePagee extends StatefulWidget {
  const HomePagee({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePagee> createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
  var news = FirebaseFirestore.instance.collection('news').snapshots();
  bool newsBookmarked = false;

  Widget build(BuildContext context) {
    CollectionReference newsRef = FirebaseFirestore.instance.collection("news");
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: newsRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Son Gelişmeler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var docId = snapshot.data!.docs[index].id;
                      Future<void> bookmarkContt() async {
                        await FirebaseFirestore.instance
                            .collection('news')
                            .doc(docId)
                            .update({
                          'isBookmarked': newsBookmarked,
                        });

                        setState(() {
                          newsBookmarked = !newsBookmarked;
                        });
                      }

                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 220,
                              width: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      snapshot.data!.docs[index]['url']),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 170.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          bookmarkContt();
                                        },
                                        icon: snapshot.data!.docs[index]
                                                ['isBookmarked']
                                            ? const Icon(
                                                Icons.bookmark,
                                                color: Color(0xFF2D365C),
                                                size: 36,
                                              )
                                            : Icon(
                                                Icons.bookmark_outline,
                                                color: Color(0xFF2D365C),
                                                size: 36,
                                              )),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              snapshot.data!.docs[index]['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
