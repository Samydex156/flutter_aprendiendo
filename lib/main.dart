import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialización de efectos y gestor de ventana
  await Window.initialize();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(900, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MiAppEstado());
}

class MiAppEstado extends StatefulWidget {
  const MiAppEstado({super.key});

  @override
  State<MiAppEstado> createState() => _MiAppEstadoState();
}

class _MiAppEstadoState extends State<MiAppEstado> {
  int numero = 0;
  double opacidad = 1.0;
  WindowEffect efectoActual = WindowEffect.disabled;

  // --- LÓGICA DE EFECTOS ---
  void setMicaEffect() async {
    await Window.setEffect(effect: WindowEffect.mica);
    setState(() => efectoActual = WindowEffect.mica);
  }

  void setAcrylicEffect() async {
    await Window.setEffect(
      effect: WindowEffect.acrylic,
      color: const Color(0x22FFFFFF),
    );
    setState(() => efectoActual = WindowEffect.acrylic);
  }

  void setBlurEffect() async {
    await Window.setEffect(effect: WindowEffect.aero);
    setState(() => efectoActual = WindowEffect.aero);
  }

  void desactivarEfecto() async {
    await Window.setEffect(effect: WindowEffect.disabled);
    setState(() => efectoActual = WindowEffect.disabled);
  }

  // --- LÓGICA DE TRANSPARENCIA ---
  void cambiarTransparencia(double nuevoValor) async {
    setState(() => opacidad = nuevoValor);
    await windowManager.setOpacity(nuevoValor);
  }

  // --- LÓGICA DE VENTANA ---
  void ventanaPequena() async =>
      await windowManager.setSize(const Size(450, 450));
  void ventanaGrande() async =>
      await windowManager.setSize(const Size(900, 700));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: Scaffold(
        // Si el efecto está desactivado, ponemos fondo blanco.
        // Si está activado, DEBE ser transparente para que el efecto se vea.
        backgroundColor: efectoActual == WindowEffect.disabled
            ? Colors.white
            : Colors.transparent,
        appBar: AppBar(
          title: const Text("Control Total: Cristal + Arrastre"),
          backgroundColor: efectoActual == WindowEffect.disabled
              ? Colors.blueAccent.withValues(
                  alpha: 0.1,
                ) // Un tono azulado suave si está en blanco
              : Colors.white.withValues(
                  alpha: 0.1,
                ), // Transparente si hay cristal
          elevation: 0,
        ),
        // --- ARRASTRE DESDE CUALQUIER PUNTO ---
        body: GestureDetector(
          onPanStart: (details) {
            windowManager.startDragging();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              // Si está en blanco, no ponemos tinte negro
              color: efectoActual == WindowEffect.disabled
                  ? Colors.white
                  : Colors.black.withValues(alpha: 0.05),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Efecto: ${efectoActual.name.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$numero',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => numero--),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      IconButton(
                        onPressed: () => setState(() => numero++),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),

                  const Divider(height: 40, indent: 100, endIndent: 100),

                  // SECCIÓN: TRANSPARENCIA RECUPERADA
                  const Text(
                    'Transparencia de Ventana:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: opacidad,
                    min: 0.1,
                    max: 1.0,
                    onChanged: cambiarTransparencia,
                  ),
                  Text('Nivel: ${(opacidad * 100).toInt()}%'),

                  const SizedBox(height: 20),

                  // SECCIÓN: EFECTOS DE VIDRIO
                  const Text(
                    'Efectos de Fondo:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: setMicaEffect,
                        child: const Text("Mica"),
                      ),
                      ElevatedButton(
                        onPressed: setAcrylicEffect,
                        child: const Text("Acrylic"),
                      ),
                      ElevatedButton(
                        onPressed: setBlurEffect,
                        child: const Text("Blur"),
                      ),
                      ElevatedButton(
                        onPressed: desactivarEfecto,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withValues(alpha: 0.3),
                        ),
                        child: const Text("Off"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // CONTROLES DE VENTANA
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: [
                          ActionChip(
                            label: const Text("Pequeña"),
                            onPressed: ventanaPequena,
                          ),
                          const SizedBox(width: 10),
                          ActionChip(
                            label: const Text("Grande"),
                            onPressed: ventanaGrande,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "(Arrastra desde cualquier fondo vacío)",
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
