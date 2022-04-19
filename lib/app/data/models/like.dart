class Like {
  int id;
  int idUsuario;
  int idOpiniao;
  int isLike;
  Like(
      {required this.id,
      required this.idOpiniao,
      required this.idUsuario,
      required this.isLike});

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json['id'],
        idOpiniao: json['opiniao_id'],
        idUsuario: json['usuario_id'],
        isLike: json['is_like'],
      );

  static List<Like> listFromJson(list) {
    return List<Like>.from(list.map((like) => Like.fromJson(like)));
  }

  @override
  String toString() {
    return "id $id idUsuario: $idUsuario idOpiniao: $idOpiniao   isLike $isLike";
  }
}
