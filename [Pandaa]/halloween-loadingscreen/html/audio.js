var audio = document.querySelector('audio');
audio.volume = 0.2;
audio.currentTime = 0;
if (audio) {
  
  audio.play();
  window.addEventListener('keydown', function (event) {

    var key = event.which || event.keyCode;

    if (key === 32) { // spacebar

      event.preventDefault();

      audio.paused ? audio.play() : audio.pause();
      
    }


    if (key === 38) { 

        
        event.preventDefault();
  
        audio.volume += 0.025;
        
      }

    if (key === 40) { 

    
        event.preventDefault();
  
        audio.volume -= 0.025;
        
      }

  });
}