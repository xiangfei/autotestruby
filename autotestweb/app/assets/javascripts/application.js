// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
// turbolinks 和js 冲突, 导航冲突
// require turbolinks 
//= require cable



//= require jquery
//=require jquery_ujs
//=require jquery-ui

// IMPORTANT: APP CONFIG
//= require app.config
//
//JS TOUCH : include this plugin for mobile drag / drop touch events
//= require plugin/jquery-touch/jquery.ui.touch-punch
//

// BOOTSTRAP JS
//= require bootstrap/bootstrap

// CUSTOM NOTIFICATION  消息提示插件
//= require notification/SmartNotification

// JARVIS WIDGETS
//= require smartwidgets/jarvis.widget

// SPARKLINES
//= require plugin/sparkline/jquery.sparkline

// JQUERY VALIDATE
//= require plugin/jquery-validate/jquery.validate

// JQUERY MASKED INPUT
//= require plugin/masked-input/jquery.maskedinput

// JQUERY SELECT2 INPUT
//= require plugin/select2/select2

// JQUERY UI + Bootstrap Slider
//= require plugin/bootstrap-slider/bootstrap-slider

// browser msie issue fix
//= require plugin/msie-fix/jquery.mb.browser
//
// FastClick: For mobile devices
//= require plugin/fastclick/fastclick
// demo js ,用来显示例子
//=require demo
//=require app
// require_tree .

// 应用加载后执行
// require plugin/bootstraptree/bootstrap-tree.min
//= require plugin/jquery-nestable/jquery.nestable
//

// ENHANCEMENT PLUGINS : NOT A REQUIREMENT js 声音提示
// Voice command : plugin
//= require speech/voicecommand

// SmartChat UI : plugin smartchat 在线通信使用
//= require smart-chat-ui/smart.chat.ui.min
//= require smart-chat-ui/smart.chat.manager.min


// codemirror ruby测试用例format

//= require plugin/codemirror/lib/codemirror
//= require plugin/codemirror/mode/xml/xml
//= require plugin/codemirror/mode/css/css
//= require plugin/codemirror/mode/htmlmixed/htmlmixed
//= require plugin/codemirror/mode/javascript/javascript
//= require plugin/codemirror/mode/ruby/ruby
//= require plugin/codemirror/mode/htmlembedded/htmlembedded
//= require plugin/codemirror/addon/edit/matchbrackets
//= require plugin/codemirror/addon/hint/show-hint
//= require plugin/codemirror/addon/hint/sql-hint
//= require plugin/codemirror/addon/mode/multiplex


// echart 百度画图工具
//= require plugin/echart/echarts.min.js
//= require plugin/echart/walden.js
