import 'package:capi_json/views/home.dart';
import 'package:flutter/material.dart';

//Página main dedicada a la configuración y arranque de la app

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Capitales del mundo',
        theme: ThemeData(
          //Configuración del tema
          primarySwatch: buildMaterialColor(const Color(0xff9381ff)),
          //color primario
          textTheme: TextTheme(
            headline1: TextStyle(
              //declaración de diferentes estilos de fuente
              color: Color(0xfff8f7ff),
              fontSize: 30,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.purple.shade50.withOpacity(.3),
                  offset: const Offset(3, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            headline2: TextStyle(
              color: Colors.purple.shade50,
              fontSize: 20,
            ),
            bodyText1: const TextStyle(
              color: Color(0xff000000),
              fontSize: 18,
            ),
          ),
          cardTheme: CardTheme(
            // configuración de la tarjeta de preguntas
            elevation: 6,
            color: Color(0xffb8b8ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
        });
  }
}

MaterialColor buildMaterialColor(Color color) {
  // Creación de color principal personalizado
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
