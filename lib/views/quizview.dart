import 'dart:convert';
import 'package:capi_json/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capi_json/models/question.dart';
import 'package:capi_json/models/quiz.dart';
import 'package:capi_json/views/resultsview.dart';

// en esta página se generan las diferentes preguntas del cuestionario

class QuizView extends StatefulWidget {
  final String
      continente; //Declaramos el continente, que dependerá de la opción que pulse el usuario

  const QuizView({Key? key, required this.continente}) : super(key: key);

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  // declaramos las variables que se usarán a lo largo del cuestionario
  int totalQuestions = 10;
  int totalOptions = 4;
  int questionIndex = 0;
  int progressIndex = 0;
  Quiz quiz = Quiz(name: 'Capitales del mundo', questions: []);

  Future<void> readJson() async {
    // esta función se dedica a leer los ficheros json almacenados de manera local de manera asíncrona
    final String response =
        await rootBundle.loadString('assets/json/${widget.continente}.json');
    final List<dynamic> data = await json.decode(response);
    List<int> optionList = List<int>.generate(data.length, (i) => i);
    List<int> questionsAdded = [];

    while (true) {
      //con la lista generada, trabajamos las preguntas hasta que se acaben
      optionList.shuffle(); //usando la función shuffle mezclamos las preguntas
      int answer = optionList[0]; // primero asignaremos la respuesta correcta
      if (questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);

      List<String> otherOptions =
          []; // para luego añadir el resto de respuestas incorrectas
      for (var option in optionList.sublist(1, totalOptions)) {
        otherOptions.add(data[option]['capital']);
      }

      Question question = Question.fromJson(data[
          answer]); //generamos el objeto pregunta, que contendrá tanto la respuesta correcta como la incorrecta
      question.addOptions(otherOptions);
      quiz.questions.add(question);

      if (quiz.questions.length >= totalQuestions) {
        break;
      } // cuando se terminan la lista de preguntas, salimos del bucle

    }

    setState(() {});
  }

  @override
  void initState() {
    // Al iniciar la pantalla, lo primero será leer del json
    super.initState();
    readJson();
  }

  void _optionSelected(String selected) {
    // este método almacena la respuesta seleccionada y actualiza el cuestionario
    quiz.questions[questionIndex].selected = selected;
    if (selected == quiz.questions[questionIndex].answer) {
      quiz.questions[questionIndex].correct = true;
      quiz.right += 1;
    }

    progressIndex += 1; //añadiendo una sección a la barra rellenable
    if (questionIndex < totalQuestions - 1) {
      questionIndex += 1;
    } else {
      showDialog(
          //y en el caso de que no haya más preguntas, lanza el cuadro de diálogo final

          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildResultDialog(context));
    }

    setState(() {});
  }

  Widget _buildResultDialog(BuildContext context) {
    // este método genera el cuadro de diálogo que nos informa del resultado, para luego mandarnos a la pantalla de detalle
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text('RESULTADO', style: Theme.of(context).textTheme.headline1),
      backgroundColor: const Color(0xffb8b8ff),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas totales: $totalQuestions',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Correctas: ${quiz.right}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Incorrectas: ${(totalQuestions - quiz.right)}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            'Porcentaje: ${quiz.percent}%',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => ResultsView(
                        quiz: quiz,
                      ))),
            );
          },
          child: const Text(
            'Ver Respuestas',

            style: TextStyle(color: Color(0xFFEC5B54)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Y aquí comienza la elaboración de la pantalla

    return Scaffold(
      backgroundColor: buildMaterialColor(const Color(0xff9381ff)),
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: buildMaterialColor(const Color(0xff9381ff)),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                // este widget nos muestra una barra rellenable

                color: const Color(0xFFFC8D88),
                value: progressIndex / totalQuestions,
                minHeight: 20,
              ),
            ),
          ),
          ConstrainedBox(
            // en la siguiente zona, tarjetas, añadimos las preguntas, siempre que las lista no esté vacia
            constraints: const BoxConstraints(maxHeight: 450),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: quiz.questions.isNotEmpty
                  ? Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: Text(
                              quiz.questions[questionIndex].question,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: totalOptions,
                              itemBuilder: (_, index) {
                                return Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffefd3d7),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                  child: ListTile(
                                    tileColor: const Color(0xffffd8be),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    leading: Text('${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    title: Text(
                                        quiz.questions[questionIndex]
                                            .options[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    onTap: () {
                                      _optionSelected(quiz
                                          .questions[questionIndex]
                                          .options[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
            ),
          ),
          TextButton(
            onPressed: () {
              _optionSelected('Skipped');
            },
            child: Text('Saltar', style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
