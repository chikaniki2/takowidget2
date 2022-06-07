// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
//import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "bootstrap";
import "../stylesheets/application.scss";

import axios from "axios"
import "trix"

Rails.start()
//Turbolinks.start()
ActiveStorage.start()

require("@rails/activestorage").start()
require("@rails/actiontext")


// viewから呼び出す用にtrigger設定
document.addEventListener('DOMContentLoaded', function(){
  if(document.getElementById('modal-editor')){
    const toolbarSetting = require("./toolbar_setting")
    const embedSetting = require("./embed_setting")
    const selectChange = require("./select_change")
    const ioSetting = require("./io_setting")

    $(document).on("setting:editor", "#modal-editor", function () {
      toolbarSetting();
      embedSetting();
      selectChange();
      ioSetting();
    });
    
    $(document).on("setting:viewer", "#modal-editor", function () {
      selectChange();
      ioSetting();
    });
  }
});
