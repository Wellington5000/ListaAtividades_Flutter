import 'package:flutter/material.dart';
import 'TextFields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Tela2 extends StatefulWidget {
  var profileData;

  Tela2(var profile){
    this.profileData = profile;
  }
  @override
  _Tela2State createState() => _Tela2State(profileData);
}

class _Tela2State extends State<Tela2> {
  var profileData;
  var dataEntrega;
  var dataFormatada = DateFormat("dd/MM/yyyy");

  _Tela2State(var profile){
    this.profileData = profile;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seja bem vindo"),
        backgroundColor: Colors.tealAccent,
        flexibleSpace: Image.asset('images/postIt.jpg', fit: BoxFit.cover),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Atividades').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    dataEntrega = DateTime.fromMillisecondsSinceEpoch(document['DataEntrega'].millisecondsSinceEpoch);
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                          )
                        ]
                      ),
                      child: new ListTile(
                        leading: Icon(Icons.edit),
                        title: new Text(document['Titulo'], style: TextStyle(fontSize: 18),),
                        subtitle: new Text(document['Descrição'] + "\nData da Entrega: " + dataFormatada.format(dataEntrega)),
                        trailing: Icon(Icons.delete),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(profileData['name']),
              accountEmail: Text(profileData['email']),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(profileData['picture']['data']['url']),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Minhas atividades favoritas"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text("Adicionar atividade"),
              subtitle: Text("Adicione novas atividades"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => NewTask()))},
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text("Concluídas"),
              subtitle: Text("Atividades concluídas"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){},
            )
          ],
        )
      ),
    );
  }
}