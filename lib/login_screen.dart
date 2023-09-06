
import 'package:flutter/material.dart';
//import 'package:crypto/crypto.dart' ; gerçekten username password alındığında bunlar gönerilirken şifreleyip göndermek için
import 'package:real_app/main_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {
  bool obscureText = true;
  String email = "" ;
  String password = "" ;
  bool warningmessage = false; //girişle ilgili bir problem olduğunda trueya döner
  List<String> registeredMail = ["as","ds","x"];// kullanıcı adı şifre olmadığı için placeholder olarak bunlar yazılı
  List<String> registeredPassword = ["as","ds","x"];


  void setObscureText(bool command){
    obscureText = command;
  }

  final emailCont =  TextEditingController();
  final passwordCont =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return false; },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,100,0,25),
                  child: SizedBox(
                    height:60,
                    width: 320,
                    child: TextField(
                      controller: emailCont,
                      decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(),
                      labelText: "email",
                    ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                SizedBox(
                    height:60,
                    width: 320,
                    child: TextField(
                      obscureText: obscureText,
                      controller: passwordCont,
                      decoration: (const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderSide:BorderSide(
                                color: Colors.lightBlueAccent
                            )
                        ),
                        labelText: "şifre"
                        )
                      ),

                    )
                ),
                if(warningmessage) //warningmessage true kaldığı sürece bu text gözükür false olduğunda kaybolur
                  const Text("Hatalı şifre veya email",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18
                  ),),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(onPressed: (){

                    setState(() {

                      if(emailCont.text =="" || passwordCont.text == "" || registeredMail.contains(emailCont.text) == false || registeredPassword.contains(passwordCont.text) == false ){
                        warningmessage = true;
                        return;
                      }
                      warningmessage = false;
                      email = emailCont.text;
                      password = passwordCont.text;
                      email = emailCont.text;
                      password = passwordCont.text;

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const MainPage( )));
                    });
                  },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
                      child: const Text("Giriş Yap"),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
