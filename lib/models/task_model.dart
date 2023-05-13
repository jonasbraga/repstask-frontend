class TaskModel {
  int? id;
  String titulo;
  int pontos;
  String? descricao;
  DateTime prazo;
  String responsavel;

  TaskModel({
    required this.titulo,
    required this.pontos,
    required this.responsavel,
    required this.prazo,
    this.id,
    this.descricao,
  });

  // JsonMethods
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final titulo = json['title'];
    final pontos = json['value'];
    final descricao = json['description'];
    final responsavel = json['responsable_user'];
    final prazo = json['deadline'];

    return TaskModel(
        titulo: titulo,
        pontos: pontos,
        descricao: descricao,
        prazo: prazo,
        responsavel: responsavel);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['title'] = titulo;
    json['value'] = pontos;
    json['description'] = descricao;
    json['responsable_user'] = responsavel;

    return json;
  }
}
