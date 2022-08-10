class NoteModel {
  final int? id;
  final String title;
  final String content;
  final String image;
  final String color;
  final String date;
  final bool isFav;

  const NoteModel({
    this.id,
    required this.title,
    required this.content,
    this.image = '',
    required this.color,
    required this.date,
    this.isFav = false,
  });

  static NoteModel fromJson(Map<String, dynamic> json) => NoteModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        image: json['image'] == null ? null : json['image'],
        color: json['color'],
        date: json['date'],
        isFav: json['is_favourite'] == 1 ? true : false,
      );

  static Map<String, dynamic> toJson(NoteModel model) => {
        'id': model.id,
        'title': model.title,
        'content': model.content,
        'image': model.image,
        'color': model.color,
        'date': model.date,
        'is_favourite': model.isFav ? 1 : 0,
      };
}
