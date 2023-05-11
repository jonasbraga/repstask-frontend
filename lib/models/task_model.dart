class TaskModel {
  final int? id;
  final String titulo;
  final int pontos;
  final String? descricao;
  final DateTime? prazo;
  final String responsavel;

  TaskModel(
      {this.id,
      required this.titulo,
      required this.pontos,
      this.descricao,
      this.prazo,
      required this.responsavel});

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
