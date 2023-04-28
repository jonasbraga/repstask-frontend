class TaskModel {
  final String titulo;
  final int pontos;
  final String? descricao;
  final String responsavel;

  TaskModel(
      {required this.titulo,
      required this.pontos,
      this.descricao,
      required this.responsavel});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final titulo = json['title'];
    final pontos = json['value'];
    final descricao = json['description'];
    final responsavel = json['responsable_user'];

    return TaskModel(
        titulo: titulo,
        pontos: pontos,
        descricao: descricao,
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
