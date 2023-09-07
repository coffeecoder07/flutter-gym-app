import 'package:gymapp/Models/GalleryModel.dart';

class GymModel {
  List? seoContent;
  String? pocName;
  String? pocMobile;
  String? userId;
  String? gymName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  double? latitude;
  double? longitude;
  String? pin;
  String? country;
  String? name;
  String? distance;
  String? addonCategory;
  String? addonCatId;
  String? offerType;
  String? offerValue;
  String? distanceText;
  String? durationText;
  String? duration;
  int? rating;
  String? text1;
  String? text2;
  String? planName;
  String? planDuration;
  String? planPrice;
  String? planDescription;
  String? coverImage;
  List<GalleryModel> gallery;
  List? benefits;
  String? type;
  String? description;
  String? status;
  String? slug;
  String? categoryId;
  int? totalRating;
  String? isPartial;
  int? isCash;
  String? categoryName;
  List? offerDetails;
  int? wtfShare;
  int? isDiscount;

  GymModel(
      {this.seoContent,
      this.pocName,
      this.pocMobile,
      this.userId,
      this.gymName,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.latitude,
      this.longitude,
      this.pin,
      this.country,
      this.name,
      this.distance,
      this.addonCategory,
      this.addonCatId,
      this.offerType,
      this.offerValue,
      this.distanceText,
      this.durationText,
      this.duration,
      this.rating,
      this.text1,
      this.text2,
      this.planName,
      this.planDuration,
      this.planPrice,
      this.planDescription,
      this.coverImage,
      required this.gallery,
      this.benefits,
      this.type,
      this.description,
      this.status,
      this.slug,
      this.categoryId,
      this.totalRating,
      this.isPartial,
      this.isCash,
      this.categoryName,
      this.offerDetails,
      this.wtfShare,
      this.isDiscount});

  Map<String, dynamic> toMap() {
    return {
      'seo_content': seoContent,
      'poc_name': pocName,
      'poc_mobile': pocMobile,
      'user_id': userId,
      'gym_name': gymName,
      'address1': address1,
      'address2': address2,
      'city': city,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
      'pin': pin,
      'country': country,
      'name': name,
      'distance': distance,
      'addon_category': addonCategory,
      'addon_cat_id': addonCatId,
      'offer_type': offerType,
      'offer_value': offerValue,
      'distance_text': distanceText,
      'duration_text': durationText,
      'duration': duration,
      'rating': rating,
      'text1': text1,
      'text2': text2,
      'plan_name': planName,
      'plan_duration': planDuration,
      'plan_price': planPrice,
      'plan_description': planDescription,
      'cover_image': coverImage,
      'gallery': gallery.map((e) => e.toMap()).toList(),
      'benefits': benefits,
      'type': type,
      'description': description,
      'status': status,
      'slug': slug,
      'category_id': categoryId,
      'total_rating': totalRating,
      'is_partial': isPartial,
      'is_cash': isCash,
      'category_name': categoryName,
      'offer_details': offerDetails,
      'wtf_share': wtfShare,
      'is_discount': isDiscount
    };
  }

  factory GymModel.fromMap(Map<dynamic, dynamic> map) {
    return GymModel(
      seoContent: map['seo_content'],
      pocName: map['poc_name'],
      pocMobile: map['poc_mobile'],
      userId: map['user_id'],
      gymName: map['gym_name'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      state: map['state'],
      latitude: double.tryParse(map['latitude']),
      longitude: double.tryParse(map['longitude']),
      pin: map['pin'],
      country: map['country'],
      name: map['name'],
      distance: map['distance'],
      addonCategory: map['addon_category'],
      addonCatId: map['addon_cat_id'],
      offerType: map['offer_type'],
      offerValue: map['offer_value'],
      distanceText: map['distance_text'],
      durationText: map['duration_text'],
      duration: map['duration'],
      rating: int.tryParse('${map['rating']}'),
      text1: map['text1'],
      text2: map['text2'],
      planName: map['plan_name'],
      planDuration: map['plan_duration'],
      planPrice: map['plan_price'],
      planDescription: map['plan_description'],
      coverImage: map['cover_image'],
      gallery: ((map['gallery']??[]) as List).map((e) => GalleryModel.fromMap(e)).toList(),
      benefits: map['benefits']??[],
      type: map['type'],
      description: map['description'],
      status: map['status'],
      slug: map['slug'],
      categoryId: map['category_id'],
      totalRating: int.tryParse('${map['total_rating']}'),
      isPartial: map['is_partial'],
      isCash: int.tryParse('${map['is_cash']}'),
      categoryName: map['category_name'],
      offerDetails: map['offer_details']??[],
      wtfShare: int.tryParse('${map['wtf_share']}'),
      isDiscount: int.tryParse('${map['is_discount']}'),
    );
  }
}
