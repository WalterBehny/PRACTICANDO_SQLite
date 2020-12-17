import 'package:flutter/material.dart';
import 'package:flutter_sqlite/infrastructure/sqflite_paciente_repository.dart';
import 'package:flutter_sqlite/infrastructure/database_migration.dart';
import 'package:flutter_sqlite/model/paciente.dart';

SqflitePacienteRepository pacienteRepository =
    SqflitePacienteRepository(DatabaseMigration.get);
final List<String> choices = const <String>[
  'Save Registro de Paciente & Back',
  'Delete Registro de Paciente',
  'Back to List'
];

const mnuSave = 'Save Registro de Paciente & Back';
const mnuDelete = 'Delete Registro de Paciente';
const mnuBack = 'Back to List';

class PacienteDetailPage extends StatefulWidget {
  final Paciente paciente;
  PacienteDetailPage(this.paciente);

  @override
  State<StatefulWidget> createState() => PacienteDetailPageState(paciente);
}

class PacienteDetailPageState extends State<PacienteDetailPage> {
  Paciente paciente;
  PacienteDetailPageState(this.paciente);
  final semesterList = [1, 2, 3, 4];
  final creditList = [3, 4, 6, 8, 10];
  int semester = 1;
  int credits = 4;

  TextEditingController nameController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController scivilController = TextEditingController();
  TextEditingController sintomasController = TextEditingController();
  TextEditingController paisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = this.paciente.name;
    sexoController.text = paciente.sexo;
    dniController.text = paciente.dni.toString();
    edadController.text = paciente.edad.toString();
    scivilController.text = paciente.scivil;
    sintomasController.text = paciente.sintomas;
    paisController.text = paciente.pais;

    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(paciente.name),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      style: textStyle,
                      onChanged: (value) => this.updateName(),
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: sexoController,
                          style: textStyle,
                          onChanged: (value) => this.updatesexo(),
                          decoration: InputDecoration(
                              labelText: "Sexo",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: dniController,
                          style: textStyle,
                          onChanged: (value) => this.updatedni(),
                          decoration: InputDecoration(
                              labelText: "DNI",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: edadController,
                          style: textStyle,
                          onChanged: (value) => this.updateedad(),
                          decoration: InputDecoration(
                              labelText: "Edad",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: scivilController,
                          style: textStyle,
                          onChanged: (value) => this.updatescivil(),
                          decoration: InputDecoration(
                              labelText: "Estado Civil",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: sintomasController,
                          style: textStyle,
                          onChanged: (value) => this.updatesintomas(),
                          decoration: InputDecoration(
                              labelText: "Sintomas",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: paisController,
                          style: textStyle,
                          onChanged: (value) => this.updatepais(),
                          decoration: InputDecoration(
                              labelText: "Pais:",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    /* ListTile(
                        title: DropdownButton<String>(
                      items: semesterList.map((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      style: textStyle,
                      value: retrieveSemester(course.semester).toString(),
                      onChanged: (value) => updateSemester(value),
                    )) */
                  ],
                )
              ],
            )));
  }

  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (paciente.id == null) {
          return;
        }
        result = await pacienteRepository.delete(paciente);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Registro de paciente"),
            content: Text("The Registro de paciente"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {
    if (paciente.id != null) {
      debugPrint('update');
      pacienteRepository.update(paciente);
    } else {
      debugPrint('insert');
      pacienteRepository.insert(paciente);
    }
    Navigator.pop(context, true);
  }
/*
  void updateSemester(String value) {
    switch (value) {
      case "1":
        course.semester = 1;
        break;
      case "2":
        course.semester = 2;
        break;
      case "3":
        course.semester = 3;
        break;
      case "4":
        course.semester = 4;
        break;
    }
    setState(() {
      semester = int.parse(value);
    });
  }

  int retrieveSemester(int value) {
    return semesterList[value - 1];
  } */

  void updateName() {
    paciente.name = nameController.text;
  }

  void updatesexo() {
    paciente.sexo = sexoController.text; // as int
  }

  void updatedni() {
    paciente.dni = dniController.text as int;
  }

  void updateedad() {
    paciente.edad = edadController.text as int;
  }

  void updatescivil() {
    paciente.scivil = scivilController.text;
  }

  void updatesintomas() {
    paciente.sintomas = sintomasController.text;
  }

  void updatepais() {
    paciente.pais = paisController.text;
  }
}
