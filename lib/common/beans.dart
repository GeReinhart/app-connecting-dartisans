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
  @Field() String gitHubAccount;
  @Field() String twitterAccount;

  Dartisan([String id, String openId, String email, String displayName, String givenName, String familyName,
      String avatarUrl, num locationLat, num locationLng])
      : super(id, openId, email, displayName, givenName, familyName, avatarUrl, locationLat, locationLng);

  Dartisan.fromFields({String id, String openId, String email, String displayName, String givenName, String familyName,
      String avatarUrl, num locationLat, num locationLng, String this.bio, String this.dartisanBio, num this.level,
      bool this.readyForTraining, bool this.readyToBeHired, bool this.readyForTalks, String this.gitHubAccount,
      String this.twitterAccount})
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
      bool this.readyToBeHired, bool this.readyForTalks, String this.gitHubAccount, String this.twitterAccount})
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
    fromJson(json);
  }

  String get levelLabel {
    switch (level.toInt()) {
      case 1:
        return "Beginner";
      case 2:
        return "Intermediate";
      case 3:
        return "Experienced";
      case 4:
        return "Advanced";
      case 5:
        return "Expert";
      default:
        return "";
    }
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
        readyForTraining: readyForTraining,
        gitHubAccount: gitHubAccount,
        twitterAccount: twitterAccount);
  }

  @override
  Map toJson() {
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
      "gitHubAccount": gitHubAccount,
      "twitterAccount": twitterAccount
    };
  }

  @override
  void fromJson(Map json) {
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
    gitHubAccount = json["gitHubAccount"];
    twitterAccount = json["twitterAccount"];
  }
}

class Dartisans implements Bean {
  @Field() List<Dartisan> dartisans;

  Dartisans(this.dartisans) {
    if (dartisans == null) {
      dartisans = new List<Dartisan>();
    }
  }

  Dartisans.loadJSON(Map json) {
    fromJson(json);
  }

  @override
  void fromJson(Map json) {
    List<Map> dartisansAsMap = json['dartisans'];
    dartisans = new List<Dartisan>();
    if (dartisansAsMap != null) {
      dartisansAsMap.forEach((d) {
        dartisans.add(new Dartisan()..fromJson(d));
      });
    }
  }

  @override
  Map toJson() {
    return {'dartisans': JSON.encode(dartisans)};
  }
}
