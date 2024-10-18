import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Elimina el banner de debug
      home: AgendaScreen(),
    );
  }
}

class Agenda {
  String nombre;
  String control;

  Agenda({required this.nombre, required this.control});
}

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _controlController = TextEditingController();
  List<Agenda> _contactos = [];

  // Función para agregar un contacto
  void _agregarContacto() {
    if (_nombreController.text.isNotEmpty && _controlController.text.isNotEmpty) {
      setState(() {
        _contactos.add(Agenda(
          nombre: _nombreController.text,
          control: _controlController.text,
        ));
      });

      _nombreController.clear();
      _controlController.clear();
    } else {
      // Muestra una alerta si los campos están vacíos
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Los campos no pueden estar vacíos'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Función para navegar a la pantalla de la lista de contactos
  void _verAgenda() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactosScreen(contactos: _contactos),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App segunda parcial'),
        centerTitle: true, // Para centrar el título
        backgroundColor: Colors.blue, // Cambia el color de fondo del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Agenda',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre completo',
              ),
            ),
            TextField(
              controller: _controlController,
              decoration: InputDecoration(
                labelText: 'No control',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarContacto,
              child: Text('Agregar'),
            ),
            Divider(height: 40, color: Colors.green, thickness: 2),
            Text('Total contactos: ${_contactos.length}'),
            ElevatedButton(
              onPressed: _verAgenda,
              child: Text('Ver agenda'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactosScreen extends StatelessWidget {
  final List<Agenda> contactos;

  ContactosScreen({required this.contactos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de contactos'),
        centerTitle: true, // Para centrar el título
        backgroundColor: Colors.blue, // Cambia el color de fondo del AppBar
      ),
      body: contactos.isNotEmpty
          ? ListView.builder(
              itemCount: contactos.length,
              itemBuilder: (context, index) {
                String inicial = contactos[index].nombre[0].toUpperCase(); // Obtener la inicial del nombre
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(inicial),
                  ),
                  title: Text(contactos[index].nombre),
                  subtitle: Text('No. Control: ${contactos[index].control}'),
                );
              },
            )
          : Center(
              child: Text('No hay contactos en la agenda'),
            ),
    );
  }
}

