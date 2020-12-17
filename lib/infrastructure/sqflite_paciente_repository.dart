import 'package:flutter_sqlite/assemblers/paciente_assembler.dart';
import 'package:flutter_sqlite/infrastructure/paciente_repository.dart';
import 'package:flutter_sqlite/infrastructure/database_migration.dart';
import 'package:flutter_sqlite/model/paciente.dart';
import 'package:sqflite/sqflite.dart';

class SqflitePacienteRepository implements PacienteRepository {
  final assembler = PacienteAssembler();

  @override
  DatabaseMigration databaseMigration;

  SqflitePacienteRepository(this.databaseMigration);

  @override
  Future<int> insert(Paciente paciente) async {
    final db = await databaseMigration.db();
    var id = await db.insert(assembler.tableName, assembler.toMap(paciente));
    return id;
  }

  @override
  Future<int> delete(Paciente paciente) async {
    final db = await databaseMigration.db();
    int result = await db.delete(assembler.tableName,
        where: assembler.columnId + " = ?", whereArgs: [paciente.id]);
    return result;
  }

  @override
  Future<int> update(Paciente paciente) async {
    final db = await databaseMigration.db();
    int result = await db.update(assembler.tableName, assembler.toMap(paciente),
        where: assembler.columnId + " = ?", whereArgs: [paciente.id]);
    return result;
  }

  @override
  Future<List<Paciente>> getList() async {
    final db = await databaseMigration.db();
    var result = await db.rawQuery("SELECT * FROM pacientes");
    List<Paciente> pacientes = assembler.fromList(result);
    return pacientes;
  }

  Future<int> getCount() async {
    final db = await databaseMigration.db();
    var result = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM pacientes'));
    return result;
  }
}
