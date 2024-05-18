import 'package:event_digital/app/data/database/cart_table.dart';
import 'package:event_digital/app/data/model/model_product.dart';

class ModelDetail {
  Data? data;
  int? checked;
  ModelDetail({this.data, this.checked});

  ModelDetail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }

  Map<String, dynamic> toSqlite() {
    // String? userId = UserService.find.user?.id;
    final map = <String, dynamic>{};
    map[CartTable.COL_ID] = data?.id;
    map[CartTable.COL_TITLE] = data?.attributes?.name;

    // map[CartTable.COL_IMAGE_URL] = data?.attributes?.images?.data?[0].attributes?.formats?.thumbnail?.url;
    map[CartTable.COL_PRICE] = data?.attributes?.price ?? 0;

    map[CartTable.COL_CHECKED] = 0;
    return map;
  }

  factory ModelDetail.fromSqlite(Map<String, dynamic> data) => ModelDetail(
        data: Data(
          id: data[CartTable.COL_ID],
          attributes: Attributes(
            name: data[CartTable.COL_TITLE],
            price: data[CartTable.COL_PRICE],
            // images: data[CartTable.COL_IMAGE_URL],
          ),
        ),
        checked: data[CartTable.COL_CHECKED],
      );
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

  Attributes({this.name, this.description, this.price, this.createdAt, this.updatedAt, this.publishedAt, this.images, this.category, this.orders});

  Attributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    images = json['images'] != null ? ImageProduct.fromJson(json['images']) : null;
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    orders = json['orders'] != null;
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
      data['images'] = images!.toJson();
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

class Category {
  Data? data;

  Category({this.data});

  Category.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
