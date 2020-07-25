class CommonModel {
  final String icon;
  final String title;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel({ this.icon, this.title, this.statusBarColor, this.hideAppBar });
  // 工厂方法
  factory CommonModel.fromJson(Map<String, dynamic>json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'statusBarColor': statusBarColor,
      'hideAppBar': hideAppBar,
    };
  }
}