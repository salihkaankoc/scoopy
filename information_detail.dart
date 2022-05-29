import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoopy/bookmark.dart';
import 'package:scoopy/home_page.dart';
import 'package:scoopy/information_model.dart';
import 'package:scoopy/information_page.dart';

class InformationDetail extends StatefulWidget {
  final Info infoIndex;
  const InformationDetail({Key? key, required this.infoIndex})
      : super(key: key);

  @override
  State<InformationDetail> createState() => _InformationDetailState();
}

class _InformationDetailState extends State<InformationDetail> {
  @override
  Widget build(BuildContext context) {
    CollectionReference newsRef = FirebaseFirestore.instance.collection("info");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF2D365C),
        title: const Text(
          'scoopy',
          style: TextStyle(
              fontFamily: 'Coolvetica',
              fontSize: 34,
              letterSpacing: 3,
              color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: newsRef.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.infoIndex.url),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Text(
                        widget.infoIndex.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 500,
                        width: 350,
                        child: Text(
                          widget.infoIndex.desc,
                          maxLines: 30,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
