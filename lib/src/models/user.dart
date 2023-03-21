import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id;
  String? correo;
  String? nombre;
  String? apellidos;
  String? fechaNacimiento;
  String? telefono;
  String? password;
  String? foto;
  String? sessionToken;
  String? idRol;

  User({
    this.id,
    this.correo,
    this.nombre,
    this.apellidos,
    this.fechaNacimiento,
    this.telefono,
    this.password,
    this.foto,
    this.sessionToken,
    this.idRol,
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    correo: json["correo"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    fechaNacimiento: json["fecha_nacimiento"],
    telefono: json["telefono"],
    password: json["password"],
    foto: json["foto"],
    sessionToken: json["session_token"],
    idRol: json["id_rol"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "correo": correo,
    "nombre": nombre,
    "apellidos": apellidos,
    "fecha_nacimiento": fechaNacimiento,
    "telefono": telefono,
    "password": password,
    "foto": foto,
    "session_token": sessionToken,
    "id_rol": idRol,
  };
}