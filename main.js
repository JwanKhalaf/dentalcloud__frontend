import { Elm } from "./src/Main.elm";

// key codes can be checked using this 
// website: https://www.toptal.com/developers/keycode
const keyCodeForLetterK = 75;

Elm.Main.init({ node: document.getElementById("app") });

document.addEventListener("keydown", function(e){
    if(e.ctrlKey && e.keyCode == keyCodeForLetterK) {
      e.preventDefault();

      app.ports.showSearch.send(null);
    }
});
