import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiAppInterractiva(), // Llamamos a nuestro widget con estado
    ),
  );
}

// 1. CAMBIO: Ahora usamos "StatefulWidget" porque la pantalla va a CAMBIAR
class MiAppInterractiva extends StatefulWidget {
  const MiAppInterractiva({super.key});

  @override
  State<MiAppInterractiva> createState() => _MiAppInterractivaState();
}

class _MiAppInterractivaState extends State<MiAppInterractiva> {
  // 2. CAMBIO: Una variable para saber qué menú está seleccionado (0, 1, 2...)
  int _indiceSeleccionado = 0;

  @override
  Widget build(BuildContext context) {
    // Definimos las distintas pantallas que se mostrarán a la derecha
    // Usamos una lista de Widgets.
    final List<Widget> _paginas = [
      // Página 0: Tu GridView de siempre (Dashboard)
      GridView.extent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.1,
        children: [
          _miTarjeta("Ventas", Icons.attach_money, Colors.purple),
          _miTarjeta("Usuarios", Icons.people, Colors.orange),
          _miTarjeta("Mensajes", Icons.mail, Colors.pink),
          _miTarjeta("Alertas", Icons.warning, Colors.redAccent),
          _miTarjeta("Nube", Icons.cloud, Colors.blue),
        ],
      ),
      // Página 1: Una pantalla simple para probar
      Center(
        child: Text("Gestión de Usuarios", style: TextStyle(fontSize: 30)),
      ),
      // Página 2: Otra pantalla
      Center(
        child: Text(
          "Configuración del Sistema",
          style: TextStyle(fontSize: 30),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ENCABEZADO
          Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Panel de Control',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Row(
              children: [
                // --- SIDEBAR INTERACTIVO ---
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 3. CAMBIO: Convertimos los iconos en Botones
                        _botonMenu(Icons.dashboard, "Inicio", 0),
                        _botonMenu(Icons.people, "Usuarios", 1),
                        _botonMenu(Icons.settings, "Ajustes", 2),
                      ],
                    ),
                  ),
                ),

                // --- ZONA DE CONTENIDO CAMBIANTE ---
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    // AQUÍ ESTÁ LA MAGIA:
                    // Mostramos la página que coincida con el índice seleccionado
                    child: _paginas[_indiceSeleccionado],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper para las tarjetas del Grid (Igual que antes)
  Widget _miTarjeta(String titulo, IconData icono, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 35, color: Colors.white),
          SizedBox(height: 8),
          Text(
            titulo,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // NUEVO HELPER: Crea botones para el menú lateral
  Widget _botonMenu(IconData icono, String texto, int indice) {
    return GestureDetector(
      // Cuando tocamos el botón...
      onTap: () {
        setState(() {
          _indiceSeleccionado = indice; // Actualizamos la variable
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          // Si este botón está seleccionado, le cambiamos el color para que se note
          color: _indiceSeleccionado == indice
              ? Colors.white
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              icono,
              color: _indiceSeleccionado == indice
                  ? Colors.blueAccent
                  : Colors.white,
            ),
            SizedBox(width: 10),
            // Ocultamos el texto si la pantalla es muy pequeña (opcional)
            Text(
              texto,
              style: TextStyle(
                color: _indiceSeleccionado == indice
                    ? Colors.blueAccent
                    : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
