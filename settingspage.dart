import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SetPage extends StatefulWidget {
  const SetPage({Key? key}) : super(key: key);

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  Widget build(BuildContext context) {
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
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  'Uygulama Ayarları',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 36,
                  color: Color(0xFF2D365C),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Uygulamayı Oyla'),
                        content:
                            Text('Geri Bildiriminiz İçin Teşekkür Ederiz.'),
                        actions: [
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.all(8.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2D365C),
                            ),
                            child: Text('Gönder'),
                            onPressed: () {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_SHORT, // length
                                gravity: ToastGravity.BOTTOM,
                                msg: 'Geri Bildiriminiz İçin Teşekkürler!',
                                backgroundColor: Color(0xFF2D365C),
                                textColor: Colors.white,
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Uygulamayı Oyla',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Icon(
                  Icons.notifications,
                  size: 36,
                  color: Color(0xFF2D365C),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Bildirim Ayarları',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Icon(
                  Icons.mail,
                  size: 36,
                  color: Color(0xFF2D365C),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Bize Ulaşın',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Icon(
                  Icons.message,
                  size: 36,
                  color: Color(0xFF2D365C),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Geri Bildirim Gönder',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
