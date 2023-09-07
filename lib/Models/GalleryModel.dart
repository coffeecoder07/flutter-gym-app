class GalleryModel {
  int? id;
  String? uid;
  String? gymId;
  String? categoryId;
  String? images;
  String? status;
  String? dateAdded;
  String? lastUpdated;
  String? type;

  GalleryModel(
      {this.id,
      this.uid,
      this.gymId,
      this.categoryId,
      this.images,
      this.status,
      this.dateAdded,
      this.lastUpdated,
      this.type});

  Map<String, dynamic> toMap() {
    return {
    'id':id,
    'uid':uid,
    'gym_id':gymId,
    'category_id':categoryId,
    'images':images,
    'status':status,
    'date_added':dateAdded,
    'last_updated':lastUpdated,
    'type':type
    };
  }

  factory GalleryModel.fromMap(Map<dynamic, dynamic> map) {
    return GalleryModel(
        id: map['id'],
        uid: map['uid'],
        gymId: map['gym_id'],
        categoryId: map['category_id'],
        images: map['images'],
        status: map['status'],
        dateAdded: map['date_added'],
        lastUpdated: map['last_updated'],
        type: map['type']);
  }
}
