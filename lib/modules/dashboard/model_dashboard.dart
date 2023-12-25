part of "./dashboard.dart";

class BannerModel {
  String bannerName;
  String bannerImage;
  bool isActive;

  BannerModel({
    required this.bannerName,
    required this.bannerImage,
    required this.isActive,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "is_active": isActive,
      };
  String toStringJson() => json.encode(toJson());
}
