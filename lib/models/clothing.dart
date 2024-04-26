class Clothing {
  bool sleeveless;
  bool shortSleeves;
  bool longSleeves;
  bool sweater;
  bool jacketCoat;
  bool raincoat;
  bool shorts;
  bool pants;
  bool skirt;
  bool dress;
  bool sneakers;
  bool sandals;
  bool boots;
  bool hat;
  bool sunglasses;
  bool scarf;
  bool gloves;

  Clothing({
    this.sleeveless = false,
    this.shortSleeves = false,
    this.longSleeves = false,
    this.sweater = false,
    this.jacketCoat = false,
    this.raincoat = false,
    this.shorts = false,
    this.pants = false,
    this.skirt = false,
    this.dress = false,
    this.sneakers = false,
    this.sandals = false,
    this.boots = false,
    this.hat = false,
    this.sunglasses = false,
    this.scarf = false,
    this.gloves = false,
  });

  Clothing copyWith({
    bool? sleeveless,
    bool? shortSleeves,
    bool? longSleeves,
    bool? sweater,
    bool? jacketCoat,
    bool? raincoat,
    bool? shorts,
    bool? pants,
    bool? skirt,
    bool? dress,
    bool? sneakers,
    bool? sandals,
    bool? boots,
    bool? hat,
    bool? sunglasses,
    bool? scarf,
    bool? gloves,
  }) {
    return Clothing(
      sleeveless: sleeveless ?? this.sleeveless,
      shortSleeves: shortSleeves ?? this.shortSleeves,
      longSleeves: longSleeves ?? this.longSleeves,
      sweater: sweater ?? this.sweater,
      jacketCoat: jacketCoat ?? this.jacketCoat,
      raincoat: raincoat ?? this.raincoat,
      shorts: shorts ?? this.shorts,
      pants: pants ?? this.pants,
      skirt: skirt ?? this.skirt,
      dress: dress ?? this.dress,
      sneakers: sneakers ?? this.sneakers,
      sandals: sandals ?? this.sandals,
      boots: boots ?? this.boots,
      hat: hat ?? this.hat,
      sunglasses: sunglasses ?? this.sunglasses,
      scarf: scarf ?? this.scarf,
      gloves: gloves ?? this.gloves,
    );
  }
}