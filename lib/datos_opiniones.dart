class Datos_Opiniones{

  String? id;
  String? opinion_msg;

Datos_Opiniones(this.id, this.opinion_msg);

  Datos_Opiniones.fromJson(Map<String, dynamic> json){
  id = json['opinion_id'].toString();
  opinion_msg =json['opinion_msg'];
  }
}