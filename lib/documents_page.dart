import 'package:flutter/material.dart';
import 'package:real_app/document_id.dart';


class DocumentsPage extends StatefulWidget {
  final Map jsonmap;
  final List categories;
  final bool isPending;

  //jsonmap önceki sayfadan gönderilen json dosyasındaki mapi veriyor categories ise jsonmapın keylerini tutuyor
  const DocumentsPage( this.isPending,this.jsonmap,this.categories, {super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class PostModal {
  List? categories;
  Map? map;

  //önceki sayfadan alınan bilgileri PostModal classında değişkenlere atıyor
  PostModal.fromMap({required Map jsonmap})
      : map = jsonmap,
        categories = jsonmap.keys.toList();
}

class _DocumentsPageState extends State<DocumentsPage> {
  PostModal? post;
  int? categorycount = 0;


  void load() async{

    //PostModal classından post değişkenine önceki sayfadan alınan bilgileri kaydediyor
    post = PostModal.fromMap(jsonmap: widget.jsonmap);

    if(post != null && post?.categories != null && post?.map != null){
      for(String category in post!.categories!){
        if(post!.map![category].runtimeType != List){
          post!.map![category] = [post!.map![category]];
        }
      }
    }


    setState(() {

    });
  }
  @override

  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title:  const Text("Talepler",
        ),
      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              for(int i = 0 ; i<widget.categories.length ; i++)//json dosyamızdaki keyleri listeliyor gesture detector ile ayrıntıları gösterecek sayfaya atacak şekilde cardlar üzerinden gösteriyor
                GestureDetector(
                  onTap:() =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DocumentId(widget.isPending,post?.map?[post?.categories?.elementAt(i)],post?.categories?.elementAt(i)))),
                  child: SizedBox(
                    height:70,
                    child: Card(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${post?.categories?.elementAt(i) ?? "unknown"}",
                            style:const TextStyle(
                                fontSize:18
                            ) ,
                          ),
                          const Icon(Icons.add,color: Colors.green,),

                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
