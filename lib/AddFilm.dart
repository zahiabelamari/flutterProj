import 'package:flutter/material.dart';
import 'package:untitledfilms/Home.dart';
import 'package:untitledfilms/SQLDB.dart';

class AddFilm extends StatefulWidget {
  const AddFilm({Key? key}) : super(key: key);

  @override
  State<AddFilm> createState() => _AddFilmState();
}

class _AddFilmState extends State<AddFilm> {
TextEditingController titre = TextEditingController();
TextEditingController duree = TextEditingController();
SQLdb sqLdb = SQLdb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajout"),),
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
              int rep = await sqLdb.insertData("INSERT INTO 'films'(titre,duree) VALUES('${titre.text}',${int.parse(duree.text)})");
              if(rep>0){
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context)=>Home()), (route) => false);
              }
            }
                , child: Container(child:Icon(Icons.add, size: 30,), width: double.infinity,))

          ],
        )
      ),
    );
  }
}
