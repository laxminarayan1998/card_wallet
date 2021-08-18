class SportModel {
  String? updatedAt;
  String? id;
  int? globalRank;
  double? rankScore;
  int? sportRank;
  int? playerId;
  String? playerName;
  int? setId;
  String? setName;
  String? setYear;
  String? variation;
  int? variationId;
  String? sport;
  String? imageUrl;
  String? priceScore;
  Trend? trend;

  SportModel(
      {this.updatedAt,
      this.id,
      this.globalRank,
      this.rankScore,
      this.sportRank,
      this.playerId,
      this.playerName,
      this.setId,
      this.setName,
      this.setYear,
      this.variation,
      this.variationId,
      this.sport,
      this.imageUrl,
      this.priceScore,
      this.trend});

  SportModel.fromJson(Map<String, dynamic> json) {
    this.updatedAt = json["updatedAt"] == null ? '' : json["updatedAt"];
    this.id = json["id"] == null ? '' : json["id"];
    this.globalRank = json["global_rank"] == null ? 0 : json["global_rank"];
    this.rankScore = double.parse(json["rank_score"].toString());
    this.sportRank = json["sport_rank"] == null ? 0 : json["sport_rank"];
    this.playerId = json["player_id"] == null ? 0 : json["player_id"];
    this.playerName = json["player_name"] == null ? '' : json["player_name"];
    this.setId = json["set_id"] == null ? 0 : json["set_id"];
    this.setName = json["set_name"] == null ? '' : json["set_name"];
    this.setYear = json["set_year"] == null ? '' : json["set_year"];
    this.variation = json["variation"] == null ? '' : json["variation"];
    this.variationId = json["variation_id"] == null ? 0 : json["variation_id"];
    this.sport = json["sport"] == null ? '' : json["sport"];
    this.imageUrl = json["image_url"] == null ? '' : json["image_url"];
    this.priceScore = json["price_score"] == null ? '' : json["price_score"];
    this.trend = json["trend"] == null ? null : Trend.fromJson(json["trend"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["updatedAt"] = this.updatedAt;
    data["id"] = this.id;
    data["global_rank"] = this.globalRank;
    data["rank_score"] = this.rankScore;
    data["sport_rank"] = this.sportRank;
    data["player_id"] = this.playerId;
    data["player_name"] = this.playerName;
    data["set_id"] = this.setId;
    data["set_name"] = this.setName;
    data["set_year"] = this.setYear;
    data["variation"] = this.variation;
    data["variation_id"] = this.variationId;
    data["sport"] = this.sport;
    data["image_url"] = this.imageUrl;
    data["price_score"] = this.priceScore;
    if (this.trend != null) data["trend"] = this.trend?.toJson();
    return data;
  }
}

class Trend {
  double? sevenDay;
  double? thirtyDay;

  Trend({this.sevenDay, this.thirtyDay});

  Trend.fromJson(Map<String, dynamic> json) {
    this.sevenDay = double.parse(json["seven_day"].toString());
    this.thirtyDay = double.parse(json["thirty_day"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["seven_day"] = this.sevenDay;
    data["thirty_day"] = this.thirtyDay;
    return data;
  }
}
