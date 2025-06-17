class FilterCategoryModel {
  String? name;
  List<Option>? options;

  FilterCategoryModel({this.name, this.options});

  FilterCategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options!.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  String? value;
  int? id;

  Option({this.value, this.id});

  Option.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['id'] = id;
    return data;
  }
}
