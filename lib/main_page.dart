

import 'package:flutter/material.dart';
import 'package:real_app/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_app/login_screen.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String serviceAddress = "https://my-json-server.typicode.com/typicode/demo/db";//json datası bu siteye göre gösterilecek şekilde ayarlandı documents_page ve document_id sayfaları gerekli şekilde adapte edilmeli
  String user = "X kişisi"; //normalde kişi adı çekilip yazılacak
  Map jsonObject = {} ;
  List categories = [];
  bool exit = false;
  bool help = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return false;},
      child: (
        Scaffold(
            appBar: AppBar(
              title: Text(user),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black38,
              actions: [
                DropdownButton(items: const [
                DropdownMenuItem(value:"Exit",child: Text("Çıkış Yap"),),
                DropdownMenuItem(value: "Help",child: Text("Yardım"),),
                ], onChanged: (value){
                  if (value == "Exit"){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
                              },
                              child: const Text("Evet")),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text("Hayır"))
                        ],
                        title: const Text("Uyarı!"),
                        contentPadding: const EdgeInsets.all(20),
                        content: const Text("Çıkmak İstediğinize Emin misiniz"),
                      ),
                    );
                  }
                  else if (value == "Help"){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          ElevatedButton(
                              onPressed: (){
                              Navigator.of(context).pop();
                              },
                              child: const Text("Çıkış")),
                        ],
                        title: const Text("Yardım"),
                        contentPadding: const EdgeInsets.all(20),
                        content: const Text("Ana ekran: Bekleyen talepler butonu ile henüz değerlendirilmemiş talepleri görüp değerlendirebilirsiniz.\n"
                          "Kabul edilen talepler butonu" "ile arşivde tutulan onayladığınız talepleri görebilirsiniz.\n"
                          "Reddedilen talepler butonu ile arşivde tutlan reddettiğiniz talepleri görebilirsiniz.\n\n"
                          "Talepler ekranı: seçtiğiniz kategoriye göre sıralanmış talepleri görüp detayına inebilirsiniz.\n\n"
                          "Spesifik talep ekranında açılmış talebin detaylarını görebilirsiniz ve onay bekleyen talepleri değerlendirebilirsiniz."),
                      ),
                    );
                    setState(() {});
                  }
                }
              )
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: Container(

              decoration: const BoxDecoration(
              image: DecorationImage(
                image:AssetImage("assets/tci.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loader(true,serviceAddress)));
                  },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[200],
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(8),
                      ),
                    ),
                    icon:const Icon(
                      FontAwesomeIcons.paperclip,
                      color: Colors.brown,
                      size: 24,
                    ),
                    label:const Text("Bekleyen Talepler",
                    style: TextStyle(
                        color:Colors.brown,
                        fontSize: 20,
                      ),
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loader(false,serviceAddress)));
                      },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(10,50,10,50),
                            backgroundColor: Colors.green[400],
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(8),
                            ),
                          ),
                          icon:const Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white70,
                          ),
                          label:const Text("Kabul Edilen Talepler",
                          style: TextStyle(
                            color:Colors.white70,
                            fontSize: 16,
                            ),
                          )
                      ),

                      ElevatedButton.icon(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loader(false,serviceAddress)));
                      },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(10, 50,10, 50),
                            backgroundColor: Colors.red[400],
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(8),
                            ),
                          ),
                          icon:const Icon(
                            FontAwesomeIcons.xmark,
                            color: Colors.white,
                          ),
                          label:const Text("Reddedilen Talepler",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 16,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
