class EramSpirtualVideoModel {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? video;

  EramSpirtualVideoModel({
    this.title,
    this.description,
    this.thumbnail,
    this.video,
  });

  factory EramSpirtualVideoModel.fromJson(Map<String, dynamic> json) =>
      EramSpirtualVideoModel(
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"] ?? '',
        video: json["video"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "video": video,
      };
}
