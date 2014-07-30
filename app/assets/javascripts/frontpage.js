$(document).ready(function(){
  var frontpageView = new View();
  frontpageView.init();

})




var View = function(){
  this.video_count = 1
  this.videoPlayer = document.getElementById('videoPlayer')
  // this.videoControls = $('[data-ui="videoControls"]')[0]
  this.playButton = $('[data-ui="playButton"]')[0]
  this.pauseButton = $('[data-ui="pauseButton"]')[0]
}


View.prototype = {
  init: function(){
    this.bindEventListeners();
    $(this.playButton).hide();
  },

  bindEventListeners: function(){
    this.bindLoginButton();
    console.log('binding..');
    console.log(this.videoPlayer)
    // debugger
    this.videoPlayer.onended = this.playNextVideo.bind(this);


    this.pauseButton.addEventListener('click', this.pauseVideo.bind(this));
    this.playButton.addEventListener('click', this.playVideo.bind(this));
  },

  bindLoginButton: function(){
    $('[data-ui="signin_button"]').click(function(){
      $('[data-ui="preclick"]').addClass('disp-none');
      $('[data-ui="postclick"]').fadeIn();
    })
  },
  playNextVideo: function(){

    console.log('playNExt video')
    this.video_count++;
    debugger
    if (this.video_count == 4){ this.video_count = 1};
    var nextVideo = "/assets/video"+this.video_count+".mp4";
    this.videoPlayer.src = nextVideo;
    this.videoPlayer.play();


  },
  pauseVideo: function(e){
    // debugger
    this.videoPlayer.pause();
    $(this.pauseButton).hide()
    $(this.playButton).show()
    //background dim
  },
  playVideo: function(e){
    this.videoPlayer.play();
    $(this.playButton).hide()
    $(this.pauseButton).show()
  }

}







