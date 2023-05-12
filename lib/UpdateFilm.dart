import 'package:flutter/material.dart';
import 'package:untitledfilms/Home.dart';

import 'SQLDB.dart';

class UpdateFilm extends StatefulWidget {
  final id;
  final titre;
  final duree;
  const UpdateFilm({Key? key, this.id, this.titre, this.duree}) : super(key: key);

  @override
  State<UpdateFilm> createState() => _UpdateFilmState();
}

class _UpdateFilmState extends State<UpdateFilm> {
  TextEditingController titre = TextEditingController();
  TextEditingController duree = TextEditingController();
  SQLdb sqLdb = SQLdb();
  @override
  void initState() {
    titre.text = widget.titre;
    duree.text = widget.duree.toString();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Film"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20,),

            TextField(
              controller: titre ,
              style: TextStyle(fontSize: 20,color: Colors.purple),
              decoration: InputDecoration(
                labelText: "Titre",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(height: 20,),

            TextField(
              controller: duree ,
              style: TextStyle(fontSize: 20,color: Colors.purple),
              decoration: InputDecoration(
                labelText: "Duree",
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              int rep = await sqLdb.updateData('''
              UPDATE "films" SET
              titre = "${titre.text}",
              duree = "${int.parse(duree.text)}",
              where id = "${widget.id}"
              
              ''');
              if(rep>0){
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context)=>Home()), (route) => false);
              }
            },
                child: Text("Modifier"))

          ],
        ),
      )

    );
  }
}
