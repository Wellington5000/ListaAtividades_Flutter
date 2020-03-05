import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  CalendarController _controller;
  String titulo = 'teste';
  String descricao = 'teste';
  DateTime dataEntrega = new DateTime.now();

  void insereDados(){
    Firestore.instance.collection('Atividades').document()
  .setData({ 'Titulo': titulo, 'Descrição': descricao, 'DataEntrega': dataEntrega});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Tarefa"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text){
                titulo = text;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.title),
                hintText: 'Título'
              ),
            ),
            TextField(
              onChanged: (text){
                descricao = text;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.description),
                hintText: 'Descrição'
              )
            ),
            Text(
              'Informe a data de entrega',
              style: TextStyle(fontSize: 20),
            ),
            TableCalendar(
              calendarStyle: CalendarStyle(
                todayColor: Colors.orange,
                selectedColor: Colors.blue
              ),
              calendarController: _controller,
              onDaySelected: (date, events){
                print(date.toIso8601String());
                dataEntrega = date;
              },
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: insereDados,
        label: Text('Salvar'),
        icon: Icon(Icons.save),
      ),
    );
  }
}
