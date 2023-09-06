import 'package:flutter/material.dart';


class DocumentId extends StatefulWidget {
  final dynamic maplist;
  final String title;
  final bool isPending;


  //maplist önceki sayfadan istenen kategorinin bilgisini alıyor title da istenen kategorinin adı
  const DocumentId( this.isPending,this.maplist,this.title, {super.key} );


  @override
  State<DocumentId> createState() => _DocumentIdState();
}

class Pairs {
  List keys = [];
  List values = [];

  //keys gösterilecek özelliklerin adını , values ise o özelliklerin değerlerini tutuyor

  Pairs.fromMap({required dynamic maplist}){

    //if kısmı liste içine yerleştirilmiş mapler için(1den fazla map olunca liste içine yerleştiriliyor)
    if(maplist.runtimeType == List){
      keys = maplist.elementAt(0).keys.toList();
    }

    //else kısmı liste içine yerleştirilmemiş olan mapler için
    else {
      keys= maplist.keys.toList();
      values = maplist.values.toList();
      return;
    }
  }
}



class _DocumentIdState extends State<DocumentId> {
  Pairs post = Pairs.fromMap(maplist: {});

  //önceden oluşturduğumuz pairs türünde post değişkenine istenen bilgiler kaydediliyor

  void load() async{
    post = Pairs.fromMap(maplist: widget.maplist);

    for(int z = 0; z< widget.maplist.length; z++){
      post.values.add(widget.maplist.elementAt(z));
    }


    setState(() {});
  }


  @override

void initState() {
    load();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,

      ),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(0,8,0,0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  for(int j = 0 ; j<widget.maplist.length ; j++)//tüm maplerin yazılabilmesi için
                  for(int i = 0 ; i<post.keys.length; i++ )//maplerin her elemanının yazılabilmesi için
                  SizedBox(
                    height:40,
                    width:330,
                    child: Padding(
                      padding: const EdgeInsets.all(0.5),
                      child: Card(
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),
                          side: const BorderSide(
                            width: 0.5,
                            color:Colors.black
                          )
                        ),
                        margin:EdgeInsets.zero,

                        //??den sonraki kısım istenen bilgi hemen çekilemezse çekene kadar yükleniyor... yazması için
                        child: Text("  ${post.keys.elementAt(i) ?? "yükleniyor..."} : " "${post.values.elementAt(j)[post.keys.elementAt(i)]}",
                          style: const TextStyle(fontSize: 17),
                        )
                      ),
                    ),
                  ),
                      if(widget.isPending)
                        Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,4,0),
                          child: SizedBox(
                            width: 160,
                            height: 50,
                            child: ElevatedButton(onPressed:(){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Evet")),
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Hayır"))
                                  ],
                                  contentPadding: const EdgeInsets.all(20),
                                  content: const Text("Talebi kabul etmek istediğinize emin misiniz?"),
                                ),
                              );
                            },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.green[400],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),),
                                child: const Text("Kabul Et",
                                  style: TextStyle(fontSize: 19),
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4,0,0,0),
                          child: SizedBox(
                            width: 160,
                            height: 50,
                            child: ElevatedButton(onPressed:(){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Evet")),
                                    ElevatedButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Hayır"))
                                  ],
                                  contentPadding: const EdgeInsets.all(20),
                                  content: const Text("Talebi reddetmek istediğinize emin misiniz?"),
                                ),
                              );
                            },
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                child: const Text("Reddet",
                                  style: TextStyle(fontSize: 19),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  ]
                ),
            ],
          ),
        ),
      )
    );
  }
}
