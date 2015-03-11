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
};

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

    // $(".send-letter").click(function(event){
    //   event.preventDefault()
    //   $.ajax({
    //     url: 'user/letter/send',
    //     method: 'post'
    //   }).done(function(response){
    //     p response
    //   })
    // };
  },

  renderLetterEdit: function(){
    $(".letter-editor").fadeToggle(800);
  },

  unrenderLetterEdit: function(){
    $(".letter-editor").fadeToggle(800);
  },

};




$(document).ready(function() {
startListeners = function(){
  landingView.startListeners()
  profileView.startListeners()
}
startListeners()
});
