import 'dart:convert';

Archivo imageFromJson(String str) => Archivo.fromJson(json.decode(str));

String imageToJson(Archivo data) => json.encode(data.toJson());

class Archivo {

  String? id;
  String? idUsuario;
  String? imagen1;
  String? imagen2;
  String? imagen3;

  Archivo({
    this.id,
    this.idUsuario,
    this.imagen1,
    this.imagen2,
    this.imagen3,
  });

  factory Archivo.fromJson(Map<String, dynamic> json) => Archivo(
    id: json["id"],
    idUsuario: json["id_usuario"],
    imagen1: json["imagen_1"],
    imagen2: json["imagen_2"],
    imagen3: json["imagen_3"],
  );

  static List<Archivo> fromJsonList(List<dynamic> jsonList) {
    List<Archivo> toList = [];

    jsonList.forEach((item) {
      Archivo archivo = Archivo.fromJson(item);
      toList.add(archivo);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_usuario": idUsuario,
    "imagen_1": imagen1,
    "imagen_2": imagen2,
    "imagen_3": imagen3,
  };
}