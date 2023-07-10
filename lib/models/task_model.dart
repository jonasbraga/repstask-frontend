class TaskModel {
  int? id;
  String titulo;
  int pontos;
  String? descricao;
  DateTime prazo;
  String responsavel;
  String? responsavelPhoto;
  String? responsavelName;
  int? responsavelId;

  TaskModel({
    required this.titulo,
    required this.pontos,
    required this.responsavel,
    required this.prazo,
    this.responsavelPhoto,
    this.responsavelName,
    this.responsavelId,
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
    final responsavelPhoto = json['photo'];
    final responsavelName = json['name'];
    final responsavelId = json['id'];

    return TaskModel(
        titulo: titulo,
        pontos: pontos,
        descricao: descricao,
        prazo: prazo,
        responsavelPhoto: responsavelPhoto,
        responsavelName: responsavelName,
        responsavelId: responsavelId,
        responsavel: responsavel);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['title'] = titulo;
    json['value'] = pontos;
    json['description'] = descricao;
    json['responsable_user'] = responsavel;
    json['photo'] = responsavelPhoto;
    json['name'] = responsavelName;
    json['id'] = responsavelId;

    return json;
  }
}
