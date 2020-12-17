import 'package:flutter/material.dart';
import 'package:flutter_sqlite/infrastructure/sqflite_paciente_repository.dart';
import 'package:flutter_sqlite/infrastructure/database_migration.dart';
import 'package:flutter_sqlite/model/paciente.dart';
import 'package:flutter_sqlite/pages/paciente_detail_page.dart';

class PacienteListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PacienteListPageState();
}

class PacienteListPageState extends State<PacienteListPage> {
  SqflitePacienteRepository pacienteRepository =
      SqflitePacienteRepository(DatabaseMigration.get);
  List<Paciente> pacientes;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (pacientes == null) {
      pacientes = List<Paciente>();
      getData();
    }
    return Scaffold(
      body: pacienteListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Paciente('', '', 0, 0, '', '', ''));
        },
        tooltip: "Add new Registro de Paciente",
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView pacienteListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 5.0,
          child: ListTile(
            leading: CircleAvatar(child: Text('-')
                /*backgroundColor: getColor(this.courses[position].semester),
                      child: Text(this.courses[position].semester.toString()),*/
                ),
            title: Text(this.pacientes[position].name),
            subtitle: Text('Sexo: ' +
                this.pacientes[position].sexo.toString() +
                'DNI: ' +
                this.pacientes[position].dni.toString() +
                'Edad: ' +
                this.pacientes[position].edad.toString() +
                'Estado Civil: ' +
                this.pacientes[position].scivil.toString() +
                'Sintomas: ' +
                this.pacientes[position].sintomas.toString() +
                'Pais: ' +
                this.pacientes[position].pais.toString()),
            onTap: () {
              debugPrint("Tapped on " + this.pacientes[position].id.toString());
              navigateToDetail(this.pacientes[position]);
            },
          ),
        );
      },
    );
  }

  void getData() {
    final pacientesFuture = pacienteRepository.getList();
    pacientesFuture.then((pacienteList) {
      setState(() {
        pacientes = pacienteList;
        count = pacienteList.length;
      });
    });
  }

/*
  Color getColor(int semester) {
    switch (semester) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }
*/
  void navigateToDetail(Paciente paciente) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PacienteDetailPage(paciente)),
    );
    if (result == true) {
      getData();
    }
  }
}
