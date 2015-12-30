var viewHeplers = {
  renderModal: function(thing){
    $("." + thing).css("display", "flex")
  },

  hideModal: function(){
    $(".modal-form-container").css("display", "none")
  },
};




var landingContoller  = {
};

// var controller = new ScrollMagic.Controller();

// create a scene
// new ScrollMagic.Scene({
        // duration: 100,    // the scene should last for a scroll distance of 100px
        // offset: 50        // start this scene after scrolling for 50px
    // })
    // .setPin("#my-sticky-element") // pins the element for the the scene's duration
    // .addTo(controller); // assign the scene to the controller

landingView = {
  startListeners: function(){
    $('.sign-up-button').click(function(event){
      event.preventDefault
      viewHeplers.renderModal("sign-up")
    });

    $('.sign-in-button').click(function(event){
      event.preventDefault
      viewHeplers.renderModal("sign-in")
    });

    $(".modal-exit").click(function(event){
      event.preventDefault
      viewHeplers.hideModal()
    });

    // $(".facebook-login").click(function(event){
      
    // });
  },

};

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

var profileController = {
  letterTemplate: function(){
    var letter_editor = new Quill('#editor');
    letter_editor.addModule('toolbar', { container: '#toolbar' });
    profileView.renderLetterEdit()
  },

  formatProofRead: function(){
    var html = letter_editor.getHTML();
    console.log(html)
  },
  updateHtmlText: function(){
    letter_editor = new Quill('#editor');
    formhtml = letter_editor.getHTML()
    $.ajax({
      url: '/users/letters/template',
      method: 'post',
    }).success(function(response){
      html = $(response)
      text = $(html).find('.text').first().html()
      sendData = {fileHTML: response, letterText: text }
      $.ajax({
        url:'/users/letters/new',
        method: 'post',
        dataType: 'json',
        data: sendData,
      }).done(function(){
        console.log("made it through")
      })
    })
  },

};


//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
profileView = {
  startListeners: function(){
    $(".new-letter-show").click(function(event){
      event.preventDefault()
      profileController.letterTemplate()
    });

    $(".new-letter-hide").click(function(event){
      event.preventDefault
      profileView.unrenderLetterEdit()
    });

    $(".details-shower-hider").click(function(event ){
      event.preventDefault
      if ($(".details").css("right") === "0px"){
        $(".details").stop().animate({right: "-390px"}, 800)
      }
      else {
        $(".details").stop().animate({right: "0px"}, 800)
      }
        // $(".details").stop().animate({left: r+'px'}, 800);
    });

    $('.configure-payment').click(function(event){
      event.preventDefault
      viewHeplers.renderModal("add-payment")
    });

    $('.confiure-address').click(function(event){
      event.preventDefault
      viewHeplers.renderModal("add-address")
    });

    $('.new-address-submit').click(function(event){
      event.preventDefault()
      formData = $(this).closest('form').serialize()
      $.ajax({
        method: 'post',
        url: "/users/address/add",
        data: formData,
      })
      .done(function(response){
        console.log(response)
      })
    });

    $(".send-letter").click(function(event){
      event.preventDefault()
      profileController.updateHtmlText()
    });

    $(".letter-display").click(function(event){
      event.preventDefault()
      console.log(this)
      console.log($(this))
    })
  },

  renderLetterEdit: function(){
    $(".letter-editor").fadeToggle(800);
  },

  unrenderLetterEdit: function(){
    $(".letter-editor").fadeToggle(800);
  },

};


var tweenStuff = function () {
  var animationsController = new ScrollMagic.Controller();

    // var shakeTween = TweenMax.to('.letter-machine', 1, {
    //   transform: 'rotate(15deg)'
    // });

  // var shakeRight = TweenMax.to(".letter-machine", 0.3, {transform:"rotate(25deg)", yoyo:true, repeat:-1});
  // var shakeLeft = TweenMax.to(".letter-machine", 0.3, {transform:"rotate(-15deg)", yoyo:true, repeat:-1});
  var shaketween =  TweenLite.fromTo('.letter-machine', 0.4, {transform:"rotate(10deg)"}, {transform: "rotate(-10deg)", clearProps: 'x', repeat: 10 });
  // var shaketween = (".letter-machine", 0.3, {x:-1}, {x:1, ease:RoughEase.ease.config({strength:8, points:20, template:Linear.easeNone, randomize:false}) , clearProps:"x"})

  var scene = new ScrollMagic.Scene({
    triggerElement: ".letter-machine", 
    duration: 300
  })
  .setTween(shaketween)
  .addTo(animationsController)
}

$(document).ready(function() {
startListeners = function(){
  landingView.startListeners()
  profileView.startListeners()
  tweenStuff()
}

startListeners()
});
