import 'package:flutter/material.dart';
import 'package:untitledfilms/SQLDB.dart';
import 'package:untitledfilms/UpdateFilm.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SQLdb sqLdb = SQLdb();
  //-----------------------------------
  Future<List<Map>> getAllFilms() async {
    List<Map> films = await sqLdb.getData("SELECT * FROM 'films'");
    return films;
  }

  //-----------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("addfilm");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Home"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(flex:11,
                child: Container(
                  child: FutureBuilder(
                    future: getAllFilms(),
                    builder: (ctx,snp){
                      if(snp.hasData){
                        List<Map> listFilms = snp.data!;
                        return ListView.builder(itemCount:listFilms.length,
                            itemBuilder: (ctx,index){
                              return Card(
                                child: ListTile(
                                  leading: Icon(Icons.movie,color: Colors.pinkAccent,size:30,),
                                  title: Text("${listFilms[index]['titre']}", style: TextStyle(fontSize: 25, color: Colors.pink),),
                                  subtitle: Text("${listFilms[index]['duree']}min", style: TextStyle(fontSize: 18, color: Colors.pink),),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>UpdateFilm(id:listFilms[index]['id'],titre: listFilms[index]['titre'],duree: listFilms[index]['duree'],))
                                        );
                                      },
                                          child: Icon(Icons.edit, color: Colors.green,size: 25 ,)),
                                      TextButton(onPressed: (){
                                        showDialog(context: context, builder: (context)=>AlertDialog(
                                          title: Text("Voulez vous vraiment supprimer ${listFilms[index]['titre']}"),
                                          actions: [
                                            ElevatedButton(onPressed: () async{
                                              int rep = await sqLdb.deleteData("DELETE FROM 'films' WHERE id = ${listFilms[index]['id']}");
                                              if(rep>0){
                                                Navigator.of(context).pop();
                                                setState(() {

                                                });
                                              }
                                            }, child: Text("Oui")),
                                            ElevatedButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, child: Text("Annuler")),

                                          ],
                                        ));
                                      }, child: Icon(Icons.delete, color: Colors.red,size: 25 ,))

                                    ],
                                  ),
                                ),

                              );
                            });

                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                )),
            Expanded(flex:1,
                child: Container(
                  color: Colors.black,
                ))

          ],
        ),
      )
    );
  }
}
