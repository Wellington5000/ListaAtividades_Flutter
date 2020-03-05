import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String nome, email, senha, confSenha;

  verificaSenha(){
    if(senha != confSenha){
      print("São diferentes");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.tealAccent,
        flexibleSpace: Image.asset('images/postIt.jpg', fit: BoxFit.cover),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {Navigator.pop(context); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (text){nome = text;},
                decoration: InputDecoration(
                  hintText: "Nome",
                  icon: Icon(Icons.face)
                ),
              ),
              TextField(
                onChanged: (text){email = text;},
                decoration: InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.email)
                )
              ),
              TextField(
                onChanged: (text){senha = text;},
                decoration: InputDecoration(
                  hintText: "Senha",
                  icon: Icon(Icons.vpn_key)
                ),
              ),
              TextField(
                onChanged: (text){confSenha = text;},
                decoration: InputDecoration(
                  hintText: "Confirmar Senha",
                  icon: Icon(Icons.vpn_key)
                )
              )
            ]
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Salvar', style: TextStyle(color: Colors.black),),
        icon: Icon(Icons.save, color: Colors.black,),
        backgroundColor: Colors.tealAccent,
        onPressed: (){},
      ),
    );
  }
}