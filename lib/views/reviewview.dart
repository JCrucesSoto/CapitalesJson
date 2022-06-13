import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capi_json/models/question.dart';
import 'package:capi_json/models/quiz.dart';

// Esta es la página de revisión, donde se pueden comprobar y repasar todas lass capitales, de forma muy parecida a la página de resultados

class ReviewView extends StatefulWidget {
  const ReviewView({Key? key}) : super(key: key);

  @override
  State<ReviewView> createState() => _ReviewView();
}

class _ReviewView extends State<ReviewView> {
  Quiz quiz = Quiz(name: 'Quiz de Capitales', questions: []);

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/mundo.json');
    final List<dynamic> data = await json.decode(response);
    for (var item in data) {
      Question question = Question.fromJson(item);
      question.question += question.country;
      quiz.questions.add(question);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
        ),
        body: quiz.questions.isNotEmpty
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 10),
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: const Color(0xffb8b8ff),
                      border:
                          Border.all(color: Colors.indigo.shade50, width: 1),
                    ),
                    child: Center(
                      child: Text(
                        "Paises: ${quiz.questions.length}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: quiz.questions.length,
                        itemBuilder: (_, index) {
                          return Card(
                            color: const Color(0xffffd8be) ,
                            child: ListTile(
                              leading: Text("${index + 1}"),
                              title: Text(quiz.questions[index].question),
                              trailing: Text(quiz.questions[index].answer),
                            ),
                          );
                        }),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ));
  }
}
