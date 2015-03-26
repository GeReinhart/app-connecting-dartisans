// Copyright (c) 2015, Gérald Reinhart. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library connecting_dartisans.elements.dartisan_edit;

import "dart:html";
import 'dart:js' as js;
import 'package:logging/logging.dart';
import 'dart:async';
import 'package:gex_webapp_kit_client/webapp_kit_client.dart';
import 'package:gex_webapp_kit_client/webapp_kit_common.dart';
import 'package:gex_webapp_kit_client/elements/user_edit.dart';
import 'package:polymer/polymer.dart';
import 'package:connecting_dartisans/connecting_dartisans_common.dart';
import 'package:paper_elements/paper_checkbox.dart';
import 'package:connecting_dartisans/client/elements/dartisan_checkbox.dart';
import 'package:connecting_dartisans/client/elements/dartisan_level.dart';

@CustomTag('dartisan-edit')
class DartisanEdit extends Positionable with Showable, ApplicationEventPassenger {
  final Logger log = new Logger('DartisanEdit');

  @observable String bio;
  @observable String dartisanBio;
  @observable String gitHubAccount;
  @observable String twitterAccount;

  DartisanEdit.created() : super.created();

  @override
  void ready() {
    bioTextArea.rows = 10;
    bioTextArea.maxLength = 5000;
    dartisanBioTextArea.rows = 10;
    dartisanBioTextArea.maxLength = 5000;
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
    bio = dartisan.bio;
    dartisanBio = dartisan.dartisanBio;
    levelSlider.level = dartisan.level;
    readyForTrainingCheckBox.checked = dartisan.readyForTraining;
    readyForTalksCheckBox.checked = dartisan.readyForTalks;
    readyToBeHiredCheckBox.checked = dartisan.readyToBeHired;
    gitHubAccount = dartisan.gitHubAccount;
    twitterAccount = dartisan.twitterAccount;
  }

  set user(User user) {
    userEdit.user = user;
  }

  Dartisan get dartisan => new Dartisan.fromUser(userEdit.user,
      bio: bioTextArea.value,
      dartisanBio: dartisanBioTextArea.value,
      level: levelSlider.level,
      readyForTraining: readyForTrainingCheckBox.checked,
      readyForTalks: readyForTalksCheckBox.checked,
      readyToBeHired: readyToBeHiredCheckBox.checked,
      gitHubAccount: gitHubAccount,
      twitterAccount: twitterAccount);

  UserEdit get userEdit => $["userEdit"] as UserEdit;
  TextAreaElement get bioTextArea => $["bioTextArea"] as TextAreaElement;
  TextAreaElement get dartisanBioTextArea => $["dartisanBioTextArea"] as TextAreaElement;
  DartisanLevel get levelSlider => $["level"] as DartisanLevel;
  DartisanCheckBox get readyForTrainingCheckBox => $["readyForTraining"] as DartisanCheckBox;
  DartisanCheckBox get readyForTalksCheckBox => $["readyForTalks"] as DartisanCheckBox;
  DartisanCheckBox get readyToBeHiredCheckBox => $["readyToBeHired"] as DartisanCheckBox;
}
