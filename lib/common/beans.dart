// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
part of connecting_dartisans_common;

class Dartisan extends User {
  @Field() String bio;
  @Field() String dartisanBio;
  @Field() num level;
  @Field() num atWork;
  @Field() bool readyForTraining;
  @Field() bool readyToBeHired;
  @Field() bool readyForTalks;
  @Field() String gitHubAccount;
  @Field() String twitterAccount;

  Dartisan([String id, String openId, String email, bool emailVisible, String displayName, String givenName,
      String familyName, String avatarUrl, String googlePlusUrl, num locationLat, num locationLng,
      String locationAddress])
      : super(id, openId, email, emailVisible, displayName, avatarUrl, googlePlusUrl, locationLat, locationLng,
          locationAddress);

  Dartisan.fromFields({String id, String openId, String email, bool emailVisible, String displayName, String avatarUrl,
      String googlePlusUrl, num locationLat, num locationLng, String locationAddress, String this.bio,
      String this.dartisanBio, num this.level, num this.atWork, bool this.readyForTraining, bool this.readyToBeHired,
      bool this.readyForTalks, String this.gitHubAccount, String this.twitterAccount})
      : super.fromFields(
          id: id,
          openId: openId,
          email: email,
          emailVisible: emailVisible,
          displayName: displayName,
          avatarUrl: avatarUrl,
          googlePlusUrl: googlePlusUrl,
          locationLat: locationLat,
          locationLng: locationLng,
          locationAddress: locationAddress) {}

  Dartisan.fromUser(User user, {String this.bio, String this.dartisanBio, num this.level, num this.atWork,
      bool this.readyForTraining, bool this.readyToBeHired, bool this.readyForTalks, String this.gitHubAccount,
      String this.twitterAccount})
      : super.fromFields(
          id: user.id,
          openId: user.openId,
          email: user.email,
          emailVisible: user.emailVisible,
          displayName: user.displayName,
          avatarUrl: user.avatarUrl,
          googlePlusUrl: user.googlePlusUrl,
          locationLat: user.locationLat,
          locationLng: user.locationLng,
          locationAddress: user.locationAddress) {}

  Dartisan.loadJSON(Map json) {
    fromJson(json);
  }

  String get levelLabel {
    if (level == null) {
      return "";
    }
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

  String get atWorkLabel {
    if (atWork == null) {
      return "";
    }
    switch (atWork.toInt()) {
      case 1:
        return "Only at home";
      case 2:
        return "A small part of my time";
      case 3:
        return "Half of my time";
      case 4:
        return "Most of my time";
      case 5:
        return "Full time on Dart";
      default:
        return "";
    }
  }

  String get country {
    if (locationAddress == null) {
      return null;
    }
    int lastComma = locationAddress.lastIndexOf(",");
    if (lastComma == -1 || lastComma == locationAddress.length - 1) {
      return locationAddress;
    } else {
      return locationAddress.substring(lastComma + 1, locationAddress.length).toString();
    }
  }

  bool accept(DartisansSearchForm search, Bounds bounds) {
    bool accepted = false;
    if (search == null && bounds == null) {
      return true;
    }
    if (search != null) {
      if (search.fullTextSearch != null && search.fullTextSearch.isNotEmpty) {
        accepted = _fullSearch(this.bio, search.fullTextSearch) ||
            _fullSearch(this.dartisanBio, search.fullTextSearch) ||
            _fullSearch(this.displayName, search.fullTextSearch) ||
            _fullSearch(this.gitHubAccount, search.fullTextSearch) ||
            _fullSearch(this.twitterAccount, search.fullTextSearch) ||
            _fullSearch(this.locationAddress, search.fullTextSearch);
        if (!accepted) {
          return false;
        }
      }
      if (search.readyForTalks != null) {
        if (search.readyForTalks != this.readyForTalks) {
          return false;
        }
      }
      if (search.readyForTraining != null) {
        if (search.readyForTraining != this.readyForTraining) {
          return false;
        }
      }
      if (search.readyToBeHired != null) {
        if (search.readyToBeHired != this.readyToBeHired) {
          return false;
        }
      }
    }

    if (search.selectedLevels != null && search.selectedLevels.isNotEmpty && search.selectedLevels.length != 5) {
      if (!search.selectedLevels.contains(this.level)) {
        return false;
      }
    }

    if (search.selectedAtWork != null && search.selectedAtWork.isNotEmpty && search.selectedAtWork.length != 5) {
      if (!search.selectedAtWork.contains(this.atWork)) {
        return false;
      }
    }

    if (bounds != null) {
      if (bounds.neLng < bounds.swLng) {
        if (!(this.locationLat <= bounds.neLat && this.locationLat >= bounds.swLat)) {
          return false;
        }
      } else {
        if (!(this.locationLat <= bounds.neLat &&
            this.locationLng <= bounds.neLng &&
            this.locationLat >= bounds.swLat &&
            this.locationLng >= bounds.swLng)) {
          return false;
        }
      }
    }

    return true;
  }

  bool _fullSearch(String text, String searched) {
    return text != null && text.toLowerCase().contains(searched.toLowerCase());
  }

  @override
  String toString() =>
      "Dartisan: openId:${openId}, email:${email}, displayName:${displayName}, imageUrl:${avatarUrl}, locationLat:${locationLat}, locationLng:${locationLng}, locationAddress:${locationAddress}, level:${level}";

  Dartisan clone() {
    return new Dartisan.fromFields(
        id: id,
        openId: openId,
        email: email,
        emailVisible: emailVisible,
        displayName: displayName,
        avatarUrl: avatarUrl,
        googlePlusUrl: googlePlusUrl,
        locationLat: locationLat,
        locationLng: locationLng,
        locationAddress: locationAddress,
        bio: bio,
        level: level,
        atWork: atWork,
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
      "emailVisible": emailVisible,
      "displayName": displayName,
      "avatarUrl": avatarUrl,
      "googlePlusUrl": googlePlusUrl,
      "locationLat": locationLat,
      "locationLng": locationLng,
      "locationAddress": locationAddress,
      "bio": bio,
      "dartisanBio": dartisanBio,
      "level": level,
      "atWork": atWork,
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
    emailVisible = json["emailVisible"];
    displayName = json["displayName"];
    avatarUrl = json["avatarUrl"];
    googlePlusUrl = json["googlePlusUrl"];
    locationLat = json["locationLat"];
    locationLng = json["locationLng"];
    locationAddress = json["locationAddress"];
    bio = json["bio"];
    dartisanBio = json["dartisanBio"];
    level = json["level"];
    atWork = json["atWork"];
    readyToBeHired = json["readyToBeHired"];
    readyForTalks = json["readyForTalks"];
    readyForTraining = json["readyForTraining"];
    gitHubAccount = json["gitHubAccount"];
    twitterAccount = json["twitterAccount"];
  }
}

class Dartisans implements Bean {
  @Field() Map<String, Dartisan> dartisans;

  Dartisans(this.dartisans) {
    if (dartisans == null) {
      dartisans = new Map<String, Dartisan>();
    }
  }

  List<Dartisan> get dartisanList => new List<Dartisan>()..addAll(dartisans.values);

  Dartisans newFilteredDartisans(DartisansSearchForm search, Bounds bounds) {
    return new Dartisans.fromList(
        new List<Dartisan>()..addAll(dartisans.values.where((d) => d.accept(search, bounds))));
  }

  Dartisans.empty() {
    this.dartisans = new Map<String, Dartisan>();
  }

  Dartisans.fromList(List<Dartisan> dartisans) {
    this.dartisans = new Map<String, Dartisan>();
    dartisans.forEach((d) => put(d));
  }

  Dartisans.loadJSON(Map json) {
    fromJson(json);
  }

  bool hasDartisanByOpenId(String openId) {
    return dartisans[openId] != null;
  }

  Dartisan getDartisanByOpenId(String openId) {
    return dartisans[openId];
  }

  void put(Dartisan dartisan) {
    dartisans[dartisan.openId] = dartisan;
  }

  num get number => dartisans.keys.length;

  @override
  void fromJson(Map json) {
    Map<String, Map> dartisansAsMap = json['dartisans'];
    dartisans = new Map<String, Dartisan>();
    if (dartisansAsMap != null) {
      dartisansAsMap.forEach((o, d) {
        Dartisan dartisan = new Dartisan()..fromJson(d);
        dartisans[o] = dartisan;
      });
    }
  }

  @override
  Map toJson() {
    return {'dartisans': JSON.encode(dartisans)};
  }
}

class DartisansSearchForm implements Bean {
  @Field() String fullTextSearch;
  @Field() bool readyForTraining;
  @Field() bool readyForTalks;
  @Field() bool readyToBeHired;
  @Field() Set<num> selectedLevels;
  @Field() Set<num> selectedAtWork;

  DartisansSearchForm([String fullTextSearch, String readyForTraining, String readyForTalks, String readyToBeHired,
      Set<num> selectedLevels, Set<num> selectedAtWork]);

  DartisansSearchForm.fromFields({String this.fullTextSearch, bool this.readyForTraining, bool this.readyForTalks,
      bool this.readyToBeHired, Set<num> this.selectedLevels, Set<num> this.selectedAtWork});

  @override
  Map toJson() {
    return {
      "fullTextSearch": fullTextSearch,
      "readyForTraining": readyForTraining,
      "readyForTalks": readyForTalks,
      "readyToBeHired": readyToBeHired
    };
  }

  bool get isEmpty => (fullTextSearch == null || fullTextSearch == "")
                 && readyForTraining == null 
                 && readyForTalks == null
                 && readyToBeHired == null
                 && (selectedLevels== null ||   selectedLevels.isEmpty)
                 && (selectedAtWork== null ||   selectedAtWork.isEmpty) ;
  
  DartisansSearchForm clone() {
    return new DartisansSearchForm.fromFields(
        fullTextSearch: fullTextSearch,
        readyForTraining: readyForTraining,
        readyForTalks: readyForTalks,
        readyToBeHired: readyToBeHired,
        selectedLevels: new Set<num>()..addAll(selectedLevels),
        selectedAtWork: new Set<num>()..addAll(selectedAtWork));
  }

  @override
  void fromJson(Map json) {
    fullTextSearch = json["fullTextSearch"];
    readyForTraining = json["readyForTraining"];
    readyForTalks = json["readyForTalks"];
    readyToBeHired = json["readyToBeHired"];
  }

  int get hashCode {
    int result = 17;
    result = 37 * result + fullTextSearch.hashCode;
    result = 37 * result + readyForTraining.hashCode;
    result = 37 * result + readyForTalks.hashCode;
    result = 37 * result + readyToBeHired.hashCode;
    result = 37 * result + selectedLevels.hashCode;
    result = 37 * result + selectedAtWork.hashCode;
    return result;
  }

  bool operator ==(other) {
    if (other is! DartisansSearchForm) return false;
    DartisansSearchForm s = other;

    Set<num> s_selectedLevels = s.selectedLevels == null ? new Set<num>() : s.selectedLevels;
    Set<num> this_selectedLevels = selectedLevels == null ? new Set<num>() : selectedLevels;
    Set<num> s_selectedAtWork = s.selectedAtWork == null ? new Set<num>() : s.selectedAtWork;
    Set<num> this_selectedAtWork = selectedAtWork == null ? new Set<num>() : selectedAtWork;

    return (s.fullTextSearch == fullTextSearch &&
        s.readyForTraining == readyForTraining &&
        s.readyForTalks == readyForTalks &&
        s.readyToBeHired == readyToBeHired &&
        s_selectedLevels.containsAll(this_selectedLevels) &&
        s_selectedLevels.length == this_selectedLevels.length &&
        s_selectedAtWork.containsAll(this_selectedAtWork) &&
        s_selectedAtWork.length == this_selectedAtWork.length);
  }
}

class Bounds {
  num neLat;
  num neLng;
  num swLat;
  num swLng;

  Bounds(this.neLat, this.neLng, this.swLat, this.swLng);

  int get hashCode {
    int result = 17;
    result = 37 * result + neLat.hashCode;
    result = 37 * result + neLng.hashCode;
    result = 37 * result + swLat.hashCode;
    result = 37 * result + swLng.hashCode;
    return result;
  }

  bool operator ==(other) {
    if (other is! Bounds) return false;
    Bounds s = other;
    return (s.neLat == neLat && s.neLng == neLng && s.swLat == swLat && s.swLng == swLng);
  }

  bool get isEmpty => neLat == swLat || neLng == swLng;

  @override
  String toString() {
    return "Bounds ${neLat}, ${neLng} : ${swLat}, ${swLng}";
  }
}
