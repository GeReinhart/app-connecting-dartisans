// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_common;

class Dartisan extends User{
  
  @Field() num level;
  @Field() bool readyForTraining;
  @Field() bool readyToBeHired;
  @Field() bool readyForTalks;
  @Field() String dartisanBio;

  Dartisan([String id, String openId, String email, String displayName, String givenName, String familyName, String avatarUrl,
            String bio]): super(id, openId, email, displayName, givenName, familyName, avatarUrl, bio) ;
  
  Dartisan.fromFields({String id, String openId, String email, String displayName, String givenName, String familyName, String avatarUrl,
      String bio, num this.level,bool this.readyForTraining,bool this.readyToBeHired,bool this.readyForTalks,String this.dartisanBio}) : super.fromFields(id:id,openId:openId, email:email,  displayName:displayName,  givenName:givenName,  familyName:familyName,  avatarUrl:avatarUrl,
           bio:bio ) {
  }

  Dartisan.fromUser(User user, { num this.level,bool this.readyForTraining,bool this.readyToBeHired,bool this.readyForTalks,String this.dartisanBio}) : super.fromFields(id:user.id,openId:user.openId, email:user.email,  displayName:user.displayName,  givenName:user.givenName,  familyName:user.familyName,  avatarUrl:user.avatarUrl,
           bio:user.bio ) {
  }
  
  Dartisan.loadJSON(Map json) {
    fromJSON(json);
  }


  @override
  String toString() =>
      "Dartisan: openId:${openId}, email:${email}, displayName:${displayName}, givenName:${givenName}, familyName:${familyName}, imageUrl:${avatarUrl}, level:${level}";

  Dartisan clone() {
    return new Dartisan.fromFields(
        id:id,
        openId: openId,
        email: email,
        displayName: displayName,
        familyName: familyName,
        givenName: givenName,
        avatarUrl: avatarUrl,
        bio: bio,
        level: level,
        readyToBeHired: readyToBeHired,
        readyForTalks: readyForTalks,
        readyForTraining: readyForTraining,
        dartisanBio: dartisanBio
    );
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
      "bio": bio,
      "level": level,
      "readyToBeHired": readyToBeHired,
      "readyForTalks": readyForTalks,
      "readyForTraining": readyForTraining,
      "dartisanBio": dartisanBio      
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
    bio = json["bio"];
    level = json["level"];
    readyToBeHired = json["readyToBeHired"];
    readyForTalks = json["readyForTalks"];
    readyForTraining = json["readyForTraining"];
    dartisanBio = json["dartisanBio"];     
  }
  
}