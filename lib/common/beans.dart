// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_common;

class Dartisan extends User{
  
  @Field() num level;
  @Field() bool readyForTraining;
  @Field() bool readyForHire;
  @Field() bool readyForTalks;
  @Field() String dartisansBio;

  Dartisan([String id, String openId, String email, String displayName, String givenName, String familyName, String avatarUrl,
            String bio]): super(id, openId, email, displayName, givenName, familyName, avatarUrl, bio) ;
  
  Dartisan.fromFields({String id, String openId, String email, String displayName, String givenName, String familyName, String avatarUrl,
      String bio, num this.level,bool this.readyForTraining,bool this.readyForHire,bool this.readyForTalks,String this.dartisansBio}) : super.fromFields(id:id,openId:openId, email:email,  displayName:displayName,  givenName:givenName,  familyName:familyName,  avatarUrl:avatarUrl,
           bio:bio ) {
  }

  Dartisan.loadJSON(Map json) {
    fromJSON(json);
  }


  @override
  String toString() =>
      "Dartisan: openId:${openId}, email:${email}, displayName:${displayName}, givenName:${givenName}, familyName:${familyName}, imageUrl:${avatarUrl}, level:${level}";

  User clone() {
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
        readyForHire: readyForHire,
        readyForTalks: readyForTalks,
        readyForTraining: readyForTraining,
        dartisansBio: dartisansBio
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
      "readyForHire": readyForHire,
      "readyForTalks": readyForTalks,
      "readyForTraining": readyForTraining,
      "dartisansBio": dartisansBio      
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
    readyForHire = json["readyForHire"];
    readyForTalks = json["readyForTalks"];
    readyForTraining = json["readyForTraining"];
    dartisansBio = json["dartisansBio"];     
  }
  
}