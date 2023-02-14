class DhikrModel {
  final int? id;
  final String? dhikrName;
  final String? dhikrCount;
  final String? dhikrImame;
  final String? dhikrPronunication;
  final String? dhikrMeaning;
  final String? dateAndTime;

  DhikrModel({
    this.id,
    this.dhikrName,
    this.dhikrCount,
    this.dhikrImame,
    this.dhikrPronunication,
    this.dhikrMeaning,
    this.dateAndTime,
  });

  DhikrModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        dhikrName = res['dhikrName'],
        dhikrCount = res['dhikrCount'],
        dhikrImame = res['dhikrImame'],
        dhikrPronunication = res['dhikrPronunication'],
        dhikrMeaning = res['dhikrMeaning'],
        dateAndTime = res['dateAndTime'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "dhikrName": dhikrName,
      "dhikrCount": dhikrCount,
      "dhikrImame": dhikrImame,
      "dhikrPronunication": dhikrPronunication,
      "dhikrMeaning": dhikrMeaning,
      "dateAndTime": dateAndTime,
    };
  }
}
