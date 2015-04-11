// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_edit;

import 'package:logging/logging.dart';
import 'package:gex_webapp_kit/webapp_kit_client.dart';
import 'package:gex_webapp_kit/webapp_kit_common.dart';
import 'package:gex_webapp_kit/client/elements/user_edit.dart';
import 'package:gex_webapp_kit/client/elements/formated_textarea.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:connecting_dartisans/client/elements/dartisan_checkbox.dart';
import 'package:connecting_dartisans/client/elements/dartisan_level.dart';
import 'package:connecting_dartisans/client/elements/dartisan_at_work.dart';

@CustomTag('dartisan-edit')
class DartisanEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanEdit');

  @observable String gitHubAccount;
  @observable String twitterAccount;

  DartisanEdit.created() : super.created();

  @override
  void ready() {
    userEdit.map.editionMode = false;
    userEdit.map.lock.checked = true;
  }

  @override
  void show() {
    super.show();
    userEdit.show();
  }

  @override
  void hide() {
    super.hide();
    userEdit.hide();
  }

  set dartisan(Dartisan dartisan) {
    userEdit.user = dartisan;
    bioTextArea.value = dartisan.bio;
    dartisanBioTextArea.value = dartisan.dartisanBio;
    levelSlider.level = dartisan.level;
    atWorkSlider.atWork = dartisan.atWork;
    readyForTrainingCheckBox.checked = dartisan.readyForTraining;
    readyForTalksCheckBox.checked = dartisan.readyForTalks;
    readyToBeHiredCheckBox.checked = dartisan.readyToBeHired;
    gitHubAccount = dartisan.gitHubAccount;
    twitterAccount = dartisan.twitterAccount;
  }

  set user(User user) {
    userEdit.user = user;
  }

  set userFromAuthentication(User user) {
    userEdit.userFromAuthentication = user;
  }

  Dartisan get dartisan => new Dartisan.fromUser(userEdit.user,
      bio: bioTextArea.value,
      dartisanBio: dartisanBioTextArea.value,
      level: levelSlider.level,
      atWork: atWorkSlider.atWork,
      readyForTraining: readyForTrainingCheckBox.checked,
      readyForTalks: readyForTalksCheckBox.checked,
      readyToBeHired: readyToBeHiredCheckBox.checked,
      gitHubAccount: gitHubAccount,
      twitterAccount: twitterAccount);

  UserEdit get userEdit => $["userEdit"] as UserEdit;
  FormatedTextArea get bioTextArea => $["bioTextArea"] as FormatedTextArea;
  FormatedTextArea get dartisanBioTextArea => $["dartisanBioTextArea"] as FormatedTextArea;
  DartisanLevel get levelSlider => $["level"] as DartisanLevel;
  DartisanAtWork get atWorkSlider => $["atWork"] as DartisanAtWork;
  DartisanCheckBox get readyForTrainingCheckBox => $["readyForTraining"] as DartisanCheckBox;
  DartisanCheckBox get readyForTalksCheckBox => $["readyForTalks"] as DartisanCheckBox;
  DartisanCheckBox get readyToBeHiredCheckBox => $["readyToBeHired"] as DartisanCheckBox;
}
