import 'package:capi_json/views/quizview.dart';
import 'package:capi_json/views/reviewview.dart';
import 'package:flutter/material.dart';

//Página home, que incluye el menú principal

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColor, // configuración del fondo del menu principal
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              //Esta es la imagen de cabecera
              child: Image.asset('assets/images/World.png'),
            ),
            Card(
              //aquí el menu principal en formato de tarjeta
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Theme.of(context).primaryColorLight,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  Container(
                    //nombre aplicación
                    height: 50,
                    margin: const EdgeInsets.only(top: 10, bottom: 25),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: const Color(0xFFFF5D57),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text(
                        'CAPITALES DEL MUNDO',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ), //aquí comienza la lista de opciones

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          button(context, 'europa', 'Europa'),
                          button(context, 'asia', 'Asia'),
                          button(context, 'america', 'América'),

                        ],
                      ),
                      Column(
                        children: [
                          button(context, 'africa', 'África'),
                          button(context, 'oceania', 'Oceanía'),
                          button(context, 'mundo', 'El mundo'),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReviewView(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Theme.of(context).primaryColorLight,
                        elevation: 4,
                        side: const BorderSide(width: 1),
                      ),
                      child: const Text('Repasar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlinedButton button(BuildContext context, String cont, String nom) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizView(
              continente: cont,
            ),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150, 50),
        primary: Colors.black,
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 4,
        side: const BorderSide(width: 1),
      ),
      child: Text(nom),
    );
  }
}
