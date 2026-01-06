import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start, // Ya no es necesario
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. ENCABEZADO
            Container(
              height: 50,
              color: Colors.amber,
              child: Center(child: Text('Encabezado Banner')),
            ),

            // 2. EL CUERPO (SIDEBAR + GRID)
            // <--- AQUÍ ESTABA EL PROBLEMA:
            // Necesitamos envolver la Row en un Expanded para que ocupe
            // todo el alto restante de la pantalla.
            Expanded(
              child: Row(
                children: [
                  // --- SIDEBAR (IZQUIERDA) ---
                  Expanded(
                    flex: 1,
                    child: Container(
                      // Simplifiqué quitando la Column extra que tenías aquí
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 3,
                            offset: Offset(4, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 50, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Usuario',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- ZONA DE CONTENIDO (DERECHA - GRIDVIEW) ---
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      // El GridView ahora sabe que tiene límites gracias al primer Expanded
                      child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.1,
                        children: [
                          _miTarjeta(
                            "Ventas",
                            Icons.attach_money,
                            Colors.purple,
                          ),
                          _miTarjeta("Usuarios", Icons.people, Colors.orange),
                          _miTarjeta("Mensajes", Icons.mail, Colors.pink),
                          _miTarjeta(
                            "Alerta",
                            Icons.notification_important,
                            Colors.red,
                          ),
                          _miTarjeta("Nube", Icons.cloud, Colors.blue),
                          _miTarjeta("Ajustes", Icons.settings, Colors.grey),
                          _miTarjeta(
                            "Inventario",
                            Icons.inventory,
                            Colors.teal,
                          ), // Agregué uno más
                          _miTarjeta(
                            "Salir",
                            Icons.exit_to_app,
                            Colors.black,
                          ), // Agregué uno más
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, // Aún sin lógica
          backgroundColor: Colors.blueAccent,
          icon: Icon(Icons.add, color: Colors.white),
          label: Text(
            "Nuevo Registro",
            style: TextStyle(color: Colors.white),
          ), // .extended permite poner texto + icono
        ),
      ),
    );
  }

  // Helper Widget
  Widget _miTarjeta(String titulo, IconData icono, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 40, color: Colors.white),
          SizedBox(height: 10),
          Text(
            titulo,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
