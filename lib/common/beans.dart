// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_common;

class Dartisan extends User {
  @Field() String bio;
  @Field() String dartisanBio;
  @Field() num level;
  @Field() bool readyForTraining;
  @Field() bool readyToBeHired;
  @Field() bool readyForTalks;

  Dartisan([String id, String openId, String email, String displayName, String givenName, String familyName,
      String avatarUrl, num locationLat, num locationLng])
      : super(id, openId, email, displayName, givenName, familyName, avatarUrl, locationLat, locationLng);

  Dartisan.fromFields({String id, String openId, String email, String displayName, String givenName, String familyName,
      String avatarUrl, num locationLat, num locationLng, String this.bio, String this.dartisanBio, num this.level,
      bool this.readyForTraining, bool this.readyToBeHired, bool this.readyForTalks})
      : super.fromFields(
          id: id,
          openId: openId,
          email: email,
          displayName: displayName,
          givenName: givenName,
          familyName: familyName,
          avatarUrl: avatarUrl,
          locationLat: locationLat,
          locationLng: locationLng) {}

  Dartisan.fromUser(User user, {String this.bio, String this.dartisanBio, num this.level, bool this.readyForTraining,
      bool this.readyToBeHired, bool this.readyForTalks})
      : super.fromFields(
          id: user.id,
          openId: user.openId,
          email: user.email,
          displayName: user.displayName,
          givenName: user.givenName,
          familyName: user.familyName,
          avatarUrl: user.avatarUrl,
          locationLat: user.locationLat,
          locationLng: user.locationLng) {}

  Dartisan.loadJSON(Map json) {
    fromJSON(json);
  }

  @override
  String toString() =>
      "Dartisan: openId:${openId}, email:${email}, displayName:${displayName}, givenName:${givenName}, familyName:${familyName}, imageUrl:${avatarUrl}, level:${level}";

  Dartisan clone() {
    return new Dartisan.fromFields(
        id: id,
        openId: openId,
        email: email,
        displayName: displayName,
        familyName: familyName,
        givenName: givenName,
        avatarUrl: avatarUrl,
        locationLat: locationLat,
        locationLng: locationLng,
        bio: bio,
        level: level,
        dartisanBio: dartisanBio,
        readyToBeHired: readyToBeHired,
        readyForTalks: readyForTalks,
        readyForTraining: readyForTraining);
  }

  @override
  Map toJSON() {
    return {
      "id": id,
      "openId": openId,
      "email": email,
      "displayName": displayName,
      "givenName": givenName,
      "familyName": familyName,
      "avatarUrl": avatarUrl,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "bio": bio,
      "dartisanBio": dartisanBio,
      "level": level,
      "readyToBeHired": readyToBeHired,
      "readyForTalks": readyForTalks,
      "readyForTraining": readyForTraining,
    };
  }

  @override
  void fromJSON(Map json) {
    id = json["id"];
    openId = json["openId"];
    email = json["email"];
    displayName = json["displayName"];
    givenName = json["givenName"];
    familyName = json["familyName"];
    avatarUrl = json["avatarUrl"];
    locationLat = json["locationLat"];
    locationLng = json["locationLng"];
    bio = json["bio"];
    dartisanBio = json["dartisanBio"];
    level = json["level"];
    readyToBeHired = json["readyToBeHired"];
    readyForTalks = json["readyForTalks"];
    readyForTraining = json["readyForTraining"];
  }
}
