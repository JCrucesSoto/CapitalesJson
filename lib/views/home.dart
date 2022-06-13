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
            Container(
              //nombre aplicación
              decoration: BoxDecoration(
                  color: const Color(0x00ff5d57),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: FittedBox(
                    child: RichText(
                                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'CAPITALES',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                              color: Colors.black54)),
                      TextSpan(
                          text: ' DEL MUNDO',
                          style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.w600, color: Color(
                              0xFFEC5B54))),
                    ],
                                  ),
                                ),
                  )),
            ), //aquí comienza la lista de opciones

            Expanded(
              //Esta es la imagen de cabecera
              child: Image.asset('assets/images/World.png'),
            ),
            Card(
              //aquí el menu principal en formato de tarjeta
              margin: const EdgeInsets.only(top: 10.0),
              color: const Color(0xff9381ff),
              elevation: 0,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          button(context, 'europa', 'EUROPA'),
                          button(context, 'asia', 'ASIA'),
                          button(context, 'america', 'AMÉRICA'),
                        ],
                      ),
                      Column(
                        children: [
                          button(context, 'africa', 'ÁFRICA'),
                          button(context, 'oceania', 'OCEANÍA'),
                          button(context, 'mundo', 'EL MUNDO'),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        primary: Colors.black,
                        backgroundColor: const Color(0xffffd8be),
                        elevation: 4,
                        side: const BorderSide(width: 0),
                      ),
                      child: const Text('REPASAR'),
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

  ElevatedButton button(BuildContext context, String cont, String nom) {
    return ElevatedButton(
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
      style: ElevatedButton.styleFrom(
        primary: const Color(0xffffeedd),
        onPrimary: const Color(0xff000000),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          letterSpacing: 2.0,
        ),
        shadowColor: const Color(-15727247),
        elevation: 4,
        minimumSize: const Size(150, 44),
        alignment: FractionalOffset.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(nom),
    );
  }
}
