class NoteModel {
  final int? id;

  final String title;
  final String description;

  NoteModel({this.id, required this.title, required this.description});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map["id"],

      title: map["title"],
      description: map["description"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "description": description};
  }
}
