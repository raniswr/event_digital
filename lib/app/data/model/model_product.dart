import 'package:event_digital/app/data/model/model_detail.dart';
import 'package:event_digital/config/api_client.dart';

class ModelProduct {
  List<Data>? data;
  Meta? meta;

  ModelProduct({this.data, this.meta});

  ModelProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Attributes? attributes;

  Data({this.id, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? name;
  String? description;
  int? price;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  ImageProduct? images;
  Category? category;
  dynamic orders;

  Attributes({
    this.name,
    this.description,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.images,
    this.category,
    this.orders,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    images = json['images'] != null ? ImageProduct.fromJson(json['images']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    if (images != null) {
      data['images'] = images;
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (orders != null) {
      data['orders'] = orders;
    }
    return data;
  }
}

class DataCategory {
  int? id;
  AttributesCategory? attributes;

  DataCategory({this.id, this.attributes});

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? AttributesCategory.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class Category {
  DataCategory? data;

  Category({this.data});

  Category.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataCategory.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AttributesCategory {
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  AttributesCategory({this.name, this.description, this.createdAt, this.updatedAt, this.publishedAt});

  AttributesCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    return data;
  }
}

class AttributesOrder {
  String? status;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? dueDate;
  String? endDate;

  AttributesOrder({this.status, this.createdAt, this.updatedAt, this.publishedAt, this.dueDate, this.endDate});

  AttributesOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    dueDate = json['due_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['publishedAt'] = publishedAt;
    data['due_date'] = dueDate;
    data['end_date'] = endDate;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['pageCount'] = pageCount;
    data['total'] = total;
    return data;
  }
}

class ModelImage {
  List<Data>? data;

  ModelImage({this.data});

  ModelImage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageProduct {
  List<DataImageProduct>? data;

  ImageProduct({this.data});

  ImageProduct.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataImageProduct>[];
      json['data'].forEach((v) {
        data!.add(DataImageProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataImageProduct {
  int? id;
  AttributesImage? attributes;

  DataImageProduct({this.id, this.attributes});

  DataImageProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null ? AttributesImage.fromJson(json['attributes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (attributes != null) {
      data['attributes'] = attributes!.toJson();
    }
    return data;
  }
}

class AttributesImage {
  String? url;

  AttributesImage({this.url});

  AttributesImage.fromJson(Map<String, dynamic> json) {
    url = AppClient.baseUrlImage + json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
