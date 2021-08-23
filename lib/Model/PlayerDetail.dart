class PlayerDetailModel {
  bool? active;
  bool? deleted;
  String? updatedAt;
  String? createdAt;
  String? id;
  String? playerListId;
  int? playerId;
  String? playerName;
  int? setId;
  String? setName;
  String? setYear;
  String? variation;
  String? sport;
  Trend? trend;
  List<String>? grades;
  List<BuyNow>? buyNow;
  List<dynamic>? auctions;
  List<RecentSales>? recentSales;
  List<Charts>? charts;

  PlayerDetailModel({
    this.active,
    this.deleted,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.playerListId,
    this.playerId,
    this.playerName,
    this.setId,
    this.setName,
    this.setYear,
    this.variation,
    this.sport,
    this.trend,
    this.grades,
    this.buyNow,
    this.auctions,
    this.recentSales,
    this.charts,
  });

  PlayerDetailModel.fromJson(Map<String, dynamic> json) {
    this.active = json["active"] ?? '';
    this.deleted = json["deleted"] ?? '';
    this.updatedAt = json["updatedAt"] ?? '';
    this.createdAt = json["createdAt"] ?? '';
    this.id = json["id"] ?? '';
    this.playerListId = json["playerListId"] ?? '';
    this.playerId = json["player_id"] ?? '';
    this.playerName = json["player_name"] ?? '';
    this.setId = json["set_id"] ?? '';
    this.setName = json["set_name"] ?? '';
    this.setYear = json["set_year"] ?? '';
    this.variation = json["variation"] ?? '';
    this.sport = json["sport"] ?? '';
    this.trend = json["trend"] == null ? null : Trend.fromJson(json["trend"]);
    this.grades =
        json["grades"] == null ? null : List<String>.from(json["grades"]);
    this.buyNow = json["buy_now"] == null
        ? null
        : (json["buy_now"] as List).map((e) => BuyNow.fromJson(e)).toList();
    this.auctions = json["auctions"] ?? [];
    this.recentSales = json["recent_sales"] == null
        ? null
        : (json["recent_sales"] as List)
            .map((e) => RecentSales.fromJson(e))
            .toList();
    this.charts = json["charts"] == null
        ? null
        : (json["charts"] as List).map((e) => Charts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["active"] = this.active;
    data["deleted"] = this.deleted;
    data["updatedAt"] = this.updatedAt;
    data["createdAt"] = this.createdAt;
    data["id"] = this.id;
    data["playerListId"] = this.playerListId;
    data["player_id"] = this.playerId;
    data["player_name"] = this.playerName;
    data["set_id"] = this.setId;
    data["set_name"] = this.setName;
    data["set_year"] = this.setYear;
    data["variation"] = this.variation;
    data["sport"] = this.sport;
    if (this.trend != null) data["trend"] = this.trend?.toJson();
    if (this.grades != null) data["grades"] = this.grades;
    if (this.buyNow != null)
      data["buy_now"] = this.buyNow?.map((e) => e.toJson()).toList();
    if (this.auctions != null) data["auctions"] = this.auctions;
    if (this.recentSales != null)
      data["recent_sales"] = this.recentSales?.map((e) => e.toJson()).toList();
    if (this.charts != null)
      data["charts"] = this.charts?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Charts {
  String? title;
  String? grade;
  List<Series>? series;

  Charts({this.title, this.grade, this.series});

  Charts.fromJson(Map<String, dynamic> json) {
    this.title = json["title"] ?? '';
    this.grade = json["grade"] ?? '';
    this.series = json["series"] == null
        ? null
        : (json["series"] as List).map((e) => Series.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = this.title;
    data["grade"] = this.grade;
    if (this.series != null)
      data["series"] = this.series?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Series {
  double? price;
  String? day;

  Series({this.price, this.day});

  Series.fromJson(Map<String, dynamic> json) {
    this.price = double.parse(json["price"].toString());
    this.day = json["day"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["price"] = this.price;
    data["day"] = this.day;
    return data;
  }
}

class RecentSales {
  String? grade;
  String? thumbnail;
  String? title;
  String? platform;
  double? listPrice;
  String? endTime;
  String? auctionUrl;
  String? listingType;

  RecentSales(
      {this.grade,
      this.thumbnail,
      this.title,
      this.platform,
      this.listPrice,
      this.endTime,
      this.auctionUrl,
      this.listingType});

  RecentSales.fromJson(Map<String, dynamic> json) {
    this.grade = json["grade"] ?? '';
    this.thumbnail = json["thumbnail"] ?? '';
    this.title = json["title"] ?? '';
    this.platform = json["platform"] ?? '';
    this.listPrice = double.parse(json["list_price"].toString());
    this.endTime = json["end_time"].toString();
    this.auctionUrl = json["auction_url"] ?? '';
    this.listingType = json["listing_type"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["grade"] = this.grade;
    data["thumbnail"] = this.thumbnail;
    data["title"] = this.title;
    data["platform"] = this.platform;
    data["list_price"] = this.listPrice;
    data["end_time"] = this.endTime;
    data["auction_url"] = this.auctionUrl;
    data["listing_type"] = this.listingType;
    return data;
  }
}

class BuyNow {
  String? grade;
  String? thumbnail;
  String? title;
  String? platform;
  double? listPrice;
  String? endTime;
  String? auctionUrl;
  String? listingType;
  String? recommendation;

  BuyNow({
    this.grade,
    this.thumbnail,
    this.title,
    this.platform,
    this.listPrice,
    this.endTime,
    this.auctionUrl,
    this.listingType,
    this.recommendation,
  });

  BuyNow.fromJson(Map<String, dynamic> json) {
    this.grade = json["grade"] ?? '';
    this.thumbnail = json["thumbnail"] ?? '';
    this.title = json["title"] ?? '';
    this.platform = json["platform"] ?? '';
    this.listPrice = double.parse(json["list_price"].toString());
    this.endTime = json["end_time"].toString();
    this.auctionUrl = json["auction_url"] == null ? '' : json["auction_url"];
    this.listingType = json["listing_type"] == null ? '' : json["listing_type"];
    this.recommendation =
        json["recommendation"] == null ? '' : json["recommendation"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["grade"] = this.grade;
    data["thumbnail"] = this.thumbnail;
    data["title"] = this.title;
    data["platform"] = this.platform;
    data["list_price"] = this.listPrice;
    data["end_time"] = this.endTime;
    data["auction_url"] = this.auctionUrl;
    data["listing_type"] = this.listingType;
    data["recommendation"] = this.recommendation;
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
