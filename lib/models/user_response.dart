class UserResponse {
  Data? data;
  SubscriptionDetail? subscriptionDetail;
  PlanLimitCount? planLimitCount;

  UserResponse({this.data, this.subscriptionDetail, this.planLimitCount});

  UserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    subscriptionDetail = json['subscription_detail'] != null ? new SubscriptionDetail.fromJson(json['subscription_detail']) : null;
    planLimitCount = json['plan_limit_count'] != null ? new PlanLimitCount.fromJson(json['plan_limit_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.subscriptionDetail != null) {
      data['subscription_detail'] = this.subscriptionDetail!.toJson();
    }
    if (this.planLimitCount != null) {
      data['plan_limit_count'] = this.planLimitCount!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? username;
  String? status;
  String? userType;
  String? address;
  String? contactNumber;
  String? profileImage;
  String? loginType;
  String? latitude;
  String? longitude;
  String? uid;
  String? playerId;
  String? timezone;
  String? isAgent;
  String? isBuilder;
  String? lastNotificationSeen;
  int? isSubscribe;
  int? viewLimitCount;
  int? addLimitCount;
  int? advertisementLimit;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.displayName,
      this.email,
      this.username,
      this.status,
      this.userType,
      this.address,
      this.contactNumber,
      this.profileImage,
      this.loginType,
      this.latitude,
      this.longitude,
      this.uid,
      this.playerId,
      this.timezone,
      this.isAgent,
      this.isBuilder,
      this.lastNotificationSeen,
      this.isSubscribe,
      this.viewLimitCount,
      this.addLimitCount,
      this.advertisementLimit,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    email = json['email'];
    username = json['username'];
    status = json['status'];
    userType = json['user_type'];
    address = json['address'];
    contactNumber = json['contact_number'];
    profileImage = json['profile_image'];
    loginType = json['login_type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    uid = json['uid'];
    playerId = json['player_id'];
    timezone = json['timezone'];
    isAgent = json['is_agent'];
    isBuilder = json['is_builder'];
    lastNotificationSeen = json['last_notification_seen'];
    isSubscribe = json['is_subscribe'];
    viewLimitCount = json['view_limit_count'];
    addLimitCount = json['add_limit_count'];
    advertisementLimit = json['advertisement_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['address'] = this.address;
    data['contact_number'] = this.contactNumber;
    data['profile_image'] = this.profileImage;
    data['login_type'] = this.loginType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['uid'] = this.uid;
    data['player_id'] = this.playerId;
    data['timezone'] = this.timezone;
    data['is_agent'] = this.isAgent;
    data['is_builder'] = this.isBuilder;
    data['last_notification_seen'] = this.lastNotificationSeen;
    data['is_subscribe'] = this.isSubscribe;
    data['view_limit_count'] = this.viewLimitCount;
    data['add_limit_count'] = this.addLimitCount;
    data['advertisement_limit'] = this.advertisementLimit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubscriptionDetail {
  int? isSubscribe;
  SubscriptionPlan? subscriptionPlan;

  SubscriptionDetail({this.isSubscribe, this.subscriptionPlan});

  SubscriptionDetail.fromJson(Map<String, dynamic> json) {
    isSubscribe = json['is_subscribe'];
    subscriptionPlan = json['subscription_plan'] != null ? new SubscriptionPlan.fromJson(json['subscription_plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_subscribe'] = this.isSubscribe;
    if (this.subscriptionPlan != null) {
      data['subscription_plan'] = this.subscriptionPlan!.toJson();
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
  int? addProperty;
  int? advertisement;
  String? durationUnit;
  int? propertyLimit;
  int? addPropertyLimit;
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
      this.addProperty,
      this.advertisement,
      this.durationUnit,
      this.propertyLimit,
      this.addPropertyLimit,
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
    addProperty = json['add_property'];
    advertisement = json['advertisement'];
    durationUnit = json['duration_unit'];
    propertyLimit = json['property_limit'];
    addPropertyLimit = json['add_property_limit'];
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
    data['add_property'] = this.addProperty;
    data['advertisement'] = this.advertisement;
    data['duration_unit'] = this.durationUnit;
    data['property_limit'] = this.propertyLimit;
    data['add_property_limit'] = this.addPropertyLimit;
    data['advertisement_limit'] = this.advertisementLimit;
    return data;
  }
}

class PlanLimitCount {
  int? totalProperty;
  int? totalContactView;
  int? totalAdvertisementProperty;
  int? extraForAll;
  int? withExtraAddPropertyLimit;
  int? remainingAddPropertyLimit;
  int? withExtraAdvertisementLimit;
  int? remainingAdvertisementPropertyLimit;
  int? withExtraPropertyLimit;
  int? remainingViewPropertyLimit;

  PlanLimitCount(
      {this.totalProperty,
        this.totalContactView,
        this.totalAdvertisementProperty,
        this.extraForAll,
        this.withExtraAddPropertyLimit,
        this.remainingAddPropertyLimit,
        this.withExtraAdvertisementLimit,
        this.remainingAdvertisementPropertyLimit,
        this.withExtraPropertyLimit,
        this.remainingViewPropertyLimit});

  PlanLimitCount.fromJson(Map<String, dynamic> json) {
    totalProperty = json['total_property'];
    totalContactView = json['total_contact_view'];
    totalAdvertisementProperty = json['total_advertisement_property'];
    extraForAll = json['extra_for_all'];
    withExtraAddPropertyLimit = json['with_extra_add_property_limit'];
    remainingAddPropertyLimit = json['remaining_add_property_limit'];
    withExtraAdvertisementLimit = json['with_extra_advertisement_limit'];
    remainingAdvertisementPropertyLimit =
    json['remaining_advertisement_property_limit'];
    withExtraPropertyLimit = json['with_extra_property_limit'];
    remainingViewPropertyLimit = json['remaining_view_property_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_property'] = this.totalProperty;
    data['total_contact_view'] = this.totalContactView;
    data['total_advertisement_property'] = this.totalAdvertisementProperty;
    data['extra_for_all'] = this.extraForAll;
    data['with_extra_add_property_limit'] = this.withExtraAddPropertyLimit;
    data['remaining_add_property_limit'] = this.remainingAddPropertyLimit;
    data['with_extra_advertisement_limit'] = this.withExtraAdvertisementLimit;
    data['remaining_advertisement_property_limit'] =
        this.remainingAdvertisementPropertyLimit;
    data['with_extra_property_limit'] = this.withExtraPropertyLimit;
    data['remaining_view_property_limit'] = this.remainingViewPropertyLimit;
    return data;
  }
}
