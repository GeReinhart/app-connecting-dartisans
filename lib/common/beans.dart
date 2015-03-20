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
      String avatarUrl, num locationLat, num locationLng, String locationAddress])
      : super(id, openId, email, displayName,  avatarUrl, locationLat, locationLng,locationAddress);

  Dartisan.fromFields({String id, String openId, String email, String displayName, 
      String avatarUrl, num locationLat, num locationLng, String locationAddress ,String this.bio, String this.dartisanBio, num this.level,
      bool this.readyForTraining, bool this.readyToBeHired, bool this.readyForTalks, String this.gitHubAccount,
      String this.twitterAccount})
      : super.fromFields(
          id: id,
          openId: openId,
          email: email,
          displayName: displayName,
          avatarUrl: avatarUrl,
          locationLat: locationLat,
          locationLng: locationLng,
          locationAddress:locationAddress) {}

  Dartisan.fromUser(User user, {String this.bio, String this.dartisanBio, num this.level, bool this.readyForTraining,
      bool this.readyToBeHired, bool this.readyForTalks, String this.gitHubAccount, String this.twitterAccount})
      : super.fromFields(
          id: user.id,
          openId: user.openId,
          email: user.email,
          displayName: user.displayName,
          avatarUrl: user.avatarUrl,
          locationLat: user.locationLat,
          locationLng: user.locationLng,
          locationAddress:user.locationAddress) {}

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
  
  String get country {
    if (locationAddress == null ){
      return null;
    }
    int lastComma = locationAddress.lastIndexOf(",");
    if (lastComma == -1  || lastComma == locationAddress.length-1){
      return locationAddress;
    }else{
      return locationAddress.substring(lastComma+1,locationAddress.length).toString();
    }
  }

  @override
  String toString() =>
      "Dartisan: openId:${openId}, email:${email}, displayName:${displayName}, imageUrl:${avatarUrl}, locationLat:${locationLat}, locationLng:${locationLng}, locationAddress:${locationAddress}, level:${level}";

  Dartisan clone() {
    return new Dartisan.fromFields(
        id: id,
        openId: openId,
        email: email,
        displayName: displayName,
        avatarUrl: avatarUrl,
        locationLat: locationLat,
        locationLng: locationLng,
        locationAddress:locationAddress,
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
      "avatarUrl": avatarUrl,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "locationAddress" : locationAddress,
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
    avatarUrl = json["avatarUrl"];
    locationLat = json["locationLat"];
    locationLng = json["locationLng"];
    locationAddress = json["locationAddress"];
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

class DartisansSearchForm implements Bean{
  
  @Field() String fullTextSearch;
  @Field() bool readyForTraining ;
  @Field() bool readyForTalks;
  @Field() bool readyToBeHired;
  
  DartisansSearchForm([String fullTextSearch, String readyForTraining, String readyForTalks, String readyToBeHired]);
  
  DartisansSearchForm.fromFields({String this.fullTextSearch, bool this.readyForTraining, bool this.readyForTalks, bool this.readyToBeHired});
  
  @override
  Map toJson() {
    return {
      "fullTextSearch": fullTextSearch,
      "readyForTraining": readyForTraining,
      "readyForTalks": readyForTalks,
      "readyToBeHired": readyToBeHired
    };
  }

  @override
  void fromJson(Map json) {
    fullTextSearch = json["fullTextSearch"];
    readyForTraining = json["readyForTraining"];
    readyForTalks = json["readyForTalks"];
    readyToBeHired = json["readyToBeHired"];
  }
  
}

