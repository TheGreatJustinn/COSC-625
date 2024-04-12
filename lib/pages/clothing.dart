class Clothing {
  bool sleeveless;
  bool shortSleeves;
  bool longSleeves;
  bool sweater;
  bool jacketCoat;

  Clothing({
    this.sleeveless = false,
    this.shortSleeves = false,
    this.longSleeves = false,
    this.sweater = false,
    this.jacketCoat = false,
  });

  Clothing.fromJson(Map<String, dynamic> json)
      : sleeveless = json['sleeveless'],
        shortSleeves = json['shortSleeves'],
        longSleeves = json['longSleeves'],
        sweater = json['sweater'],
        jacketCoat = json['jacketCoat'];

  Map<String, dynamic> toJson() => {
        'sleeveless': sleeveless,
        'shortSleeves': shortSleeves,
        'longSleeves': longSleeves,
        'sweater': sweater,
        'jacketCoat': jacketCoat,
      };
}