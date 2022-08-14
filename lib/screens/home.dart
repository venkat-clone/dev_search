import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget sujjections(String s) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [Expanded(child: Text("data")), Icon(Icons.abc)],
      ),
    );
  }

  String present = "";

  Widget search(Map<String, String> map,
      {double padding = 4.0, double size = 32}) {
    

    return Container(
      width: 450,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurStyle: BlurStyle.normal,
                      blurRadius: 5)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=> _launch(map["domain"]!),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Image(
                      image: AssetImage("assets/images/${map['img']}"),
                      width: size,
                      height: size,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: TextField(
                      expands: false,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          labelText: map["site"],
                          border: InputBorder.none,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.all(0)
                      ),
                      onChanged: (tex) {
                        present = tex;
                      },
                      onSubmitted: (s) => _launch(map["url"]! + s),
                      
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async => _launch(map["url"]! + present),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
          // sujjections("s")
        ],
      ),
    );
  }

  var websites = {
    "google": {
      "url": "https://www.google.com/search?q=",
      "domain":"https://www.google.com",
      "site": "Google",
      "img": "google.jpg"
    },
    "github": {
      "url": "https://github.com/search?q=",
      "domain":"https://github.com/",
      "site": "Git Hub",
      "img": "Git.png"
    },
    "stackoverflow": {
      "url": "https://stackoverflow.com/search?q=",
      "domain":"https://stackoverflow.com/",
      "site": "Stack overflow",
      "img": "Stack.png"
    },
    "youtube": {
      "url": "https://www.youtube.com/results?search_query=",
      "domain":"https://www.youtube.com/",
      "site": "Youtube",
      "img": "youtube.png"
    },
  };

  _launch(String url) async {
    if (url != "" && await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                    child: Text("Dev Search",
                    style: GoogleFonts.blackOpsOne(
                      fontSize: 64
                    )
                    )
                ),
                search(websites['google']!),
                search(websites["github"]!, size: 22, padding: 10),
                search(websites["stackoverflow"]!, size: 28),
                search(websites["youtube"]!, size: 28),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          websites.forEach(
                              (key, value) => _launch(value["url"]! + present));
                        },
                        child: const Text("Search all"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
