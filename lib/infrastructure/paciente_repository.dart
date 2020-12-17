import 'package:flutter_sqlite/infrastructure/database_migration.dart';
import 'package:flutter_sqlite/model/paciente.dart';

abstract class PacienteRepository {
  DatabaseMigration databaseMigration;
  Future<int> insert(Paciente paciente);
  Future<int> update(Paciente paciente);
  Future<int> delete(Paciente paciente);
  Future<List<Paciente>> getList();
}
