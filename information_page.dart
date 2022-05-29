import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoopy/information_detail.dart';
import 'package:scoopy/information_model.dart';

class InformationsPage extends StatefulWidget {
  const InformationsPage({Key? key}) : super(key: key);

  @override
  State<InformationsPage> createState() => _InformationsPageState();
}

class _InformationsPageState extends State<InformationsPage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference newsRef = FirebaseFirestore.instance.collection("info");
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
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Text(
                            'Bilgi Kutusu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var indexx = snapshot.data!.docs[index];
                      return Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                width: 120,
                                height: 110,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    snapshot.data!.docs[index]['url']),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    snapshot.data!.docs[index]['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InformationDetail(
                                                    infoIndex: Info
                                                        .fromDocumentSnapshot(
                                                            indexx))));
                                  },
                                  child: SizedBox(
                                    height: 100,
                                    width: 250,
                                    child: Text(
                                      snapshot.data!.docs[index]['desc'],
                                      maxLines: 5,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
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
