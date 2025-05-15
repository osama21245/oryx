import '../models/pagination_model.dart';

class SubscriptionPlanResponse {
  Pagination? pagination;
  List<SubscriptionPlan>? data;

  SubscriptionPlanResponse({this.pagination, this.data});

  SubscriptionPlanResponse.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <SubscriptionPlan>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionPlan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class SubscriptionPlan {
  int? id;
  int? userId;
  String? userName;
  int? packageId;
  String? packageName;
  num? totalAmount;
  String? paymentType;
  String? txnId;
  String? transactionDetail;
  String? paymentStatus;
  String? status;
  PackageData? packageData;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  String? cancelDate;
  String? createdAt;
  String? updatedAt;

  SubscriptionPlan(
      {this.id,
        this.userId,
        this.userName,
        this.packageId,
        this.packageName,
        this.totalAmount,
        this.paymentType,
        this.txnId,
        this.transactionDetail,
        this.paymentStatus,
        this.status,
        this.packageData,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.cancelDate,
        this.createdAt,
        this.updatedAt});

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    packageId = json['package_id'];
    packageName = json['package_name'];
    totalAmount = json['total_amount'];
    paymentType = json['payment_type'];
    txnId = json['txn_id'];
    transactionDetail = json['transaction_detail'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    packageData = json['package_data'] != null ? new PackageData.fromJson(json['package_data']) : null;
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionEndDate = json['subscription_end_date'];
    cancelDate = json['cancel_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['package_id'] = this.packageId;
    data['package_name'] = this.packageName;
    data['total_amount'] = this.totalAmount;
    data['payment_type'] = this.paymentType;
    data['txn_id'] = this.txnId;
    data['transaction_detail'] = this.transactionDetail;
    data['payment_status'] = this.paymentStatus;
    data['status'] = this.status;
    if (this.packageData != null) {
      data['package_data'] = this.packageData!.toJson();
    }
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_end_date'] = this.subscriptionEndDate;
    data['cancel_date'] = this.cancelDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PackageData {
  int? id;
  String? name;
  num? price;
  int? status;
  int? duration;
  int? property;
  String? createdAt;
  String? updatedAt;
  String? description;
  int? advertisement;
  String? durationUnit;
  int? propertyLimit;
  int? advertisementLimit;

  PackageData(
      {this.id,
        this.name,
        this.price,
        this.status,
        this.duration,
        this.property,
        this.createdAt,
        this.updatedAt,
        this.description,
        this.advertisement,
        this.durationUnit,
        this.propertyLimit,
        this.advertisementLimit});

  PackageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    duration = json['duration'];
    property = json['property'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    description = json['description'];
    advertisement = json['advertisement'];
    durationUnit = json['duration_unit'];
    propertyLimit = json['property_limit'];
    advertisementLimit = json['advertisement_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['property'] = this.property;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['description'] = this.description;
    data['advertisement'] = this.advertisement;
    data['duration_unit'] = this.durationUnit;
    data['property_limit'] = this.propertyLimit;
    data['advertisement_limit'] = this.advertisementLimit;
    return data;
  }
}
