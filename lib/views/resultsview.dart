import 'package:flutter/material.dart';
import 'package:capi_json/models/quiz.dart';

// en esta página mostramos detalladamente las respuestas seleccionadas y mostramos los errores

class ResultsView extends StatelessWidget {
  const ResultsView({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // color de fondo
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin:
                  const EdgeInsets.only(left: 3, right: 3, top: 2, bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xffb8b8ff),
                border: Border.all(
                  color: Colors.indigo.shade50,
                  width: 1,
                ),
              ),
              child: Row( // aqui mostramos el cuadro resumen con el porcentaje
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Preguntas: ${quiz.questions.length}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'Correctas: ${quiz.percent}%',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder( //En este listview mostramos todas las respuestas
                  shrinkWrap: true,
                  itemCount: quiz.questions.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: quiz.questions[index].correct
                          ? Color(0xffcef6c3) // si son correctas con fondo verde
                          : Color(0xfffccdcd), // si no con fondo rojo
                      child: ListTile(
                        leading: quiz.questions[index].correct
                            ? Icon(Icons.check, color: Color(0xff00ba0d)) // añadimos iconos para facilitar la comprensión
                            : Icon(Icons.close, color: Color(0xffff0000)),
                        title: Text(quiz.questions[index].question),
                        subtitle: Text(quiz.questions[index].selected),
                        trailing: Text(quiz.questions[index].answer),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}