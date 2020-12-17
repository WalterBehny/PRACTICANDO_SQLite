//import 'package:flutter_sqlite_Clinica/assemblers/assembler.dart';
//import 'package:flutter_sqlite_Clinica/model/paciente.dart';

import '../model/paciente.dart';
import 'assembler.dart';

class PacienteAssembler implements Assembler<Paciente> {
  final tableName = 'pacientes';
  final columnId = 'id';
  final columnName = 'name';
  final columnSexo = 'sexo';
  final columnDni = 'dni';
  final columnEdad = 'edad';
  final columnScivil = 'scivil';
  final columnSintomas = 'sintomas';
  final columnPais = 'pais';

  @override
  Paciente fromMap(Map<String, dynamic> query) {
    Paciente paciente = Paciente(
        query[columnId],
        query[columnSexo],
        query[columnDni],
        query[columnEdad],
        query[columnScivil],
        query[columnSintomas],
        query[columnPais]);
    return paciente;
  }

  @override
  Map<String, dynamic> toMap(Paciente paciente) {
    return <String, dynamic>{
      columnName: paciente.name,
      columnSexo: paciente.sexo,
      columnDni: paciente.dni,
      columnEdad: paciente.edad,
      columnScivil: paciente.scivil,
      columnSintomas: paciente.sintomas,
      columnPais: paciente.pais
    };
  }

  Paciente fromDbRow(dynamic row) {
    return Paciente.withId(
        row[columnId],
        row[columnName],
        row[columnSexo],
        row[columnDni],
        row[columnEdad],
        row[columnScivil],
        row[columnSintomas],
        row[columnPais]);
  }

  @override
  List<Paciente> fromList(result) {
    List<Paciente> pacientes = List<Paciente>();
    var count = result.length;
    for (int i = 0; i < count; i++) {
      pacientes.add(fromDbRow(result[i]));
    }
    return pacientes;
  }
}
