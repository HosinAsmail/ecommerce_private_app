class AdsModel {
  String? adsId;
  String? adsTitle;
  String? adsTitleAr;
  String? adsBody;
  String? adsBodyAr;
  String? adsDatatime;
  String? adsColor;
  String? adsColorCircle;

  AdsModel(
      {this.adsId,
      this.adsTitle,
      this.adsTitleAr,
      this.adsBody,
      this.adsBodyAr,
      this.adsDatatime,
      this.adsColor,
      this.adsColorCircle});

  AdsModel.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    adsTitle = json['ads_title'];
    adsTitleAr = json['ads_title_ar'];
    adsBody = json['ads_body'];
    adsBodyAr = json['ads_body_ar'];
    adsDatatime = json['ads_datatime'];
    adsColor = json['ads_color'];
    adsColorCircle = json['ads_color_circle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ads_id'] = adsId;
    data['ads_title'] = adsTitle;
    data['ads_title_ar'] = adsTitleAr;
    data['ads_body'] = adsBody;
    data['ads_body_ar'] = adsBodyAr;
    data['ads_datatime'] = adsDatatime;
    data['ads_color'] = adsColor;
    data['ads_color_circle'] = adsColorCircle;
    return data;
  }
}
