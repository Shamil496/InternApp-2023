
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:real_app/documents_page.dart';

class Loader extends StatefulWidget {

  final String serviceAddress;
  final bool isPending;
  //mainpageden json linkini ve hangi butona basılarak geldiğini alıyor(bekleyen/kabul edilen/reddedilen)

  const Loader( this.isPending,this.serviceAddress, {super.key} );

  @override
  State<Loader> createState() => _LoadState();
}

class _LoadState extends State<Loader> {
  @override

  void initState() {

    super.initState();
    _fetchFromAPI();
  }

  Future<void> _fetchFromAPI() async {//loading sırasında yüklemesi için json dosyasını çekme işlemini burada hallediyoruz
    String serviceAddress = widget.serviceAddress;
    Uri serviceUri = Uri.parse(serviceAddress);

    HttpClientRequest request = await HttpClient().getUrl(serviceUri);
    HttpClientResponse response = await request.close();
    String stringData = await response.transform(const Utf8Decoder()).join();
    Map jsonObject = jsonDecode(stringData);

    List categories = jsonObject.keys.toList();

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) =>
            DocumentsPage(widget.isPending ,jsonObject, categories)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 200),
              child: SizedBox(

                height: 75,
                width: 75,

                child: CircularProgressIndicator(
                  color:Colors.lightBlueAccent,
                  strokeWidth: 5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Image(
                image: AssetImage('assets/tci.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}