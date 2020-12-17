class Paciente {
  int id;
  String name;
  String sexo;
  int dni;
  int edad;
  String scivil;
  String sintomas;
  String pais;

  Paciente(this.name, this.sexo, this.dni, this.edad, this.scivil,
      this.sintomas, this.pais);
  Paciente.withId(this.id, this.name, this.sexo, this.dni, this.edad,
      this.scivil, this.sintomas, this.pais);
}
