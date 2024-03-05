import { Elm } from "./src/Main.elm";

// key codes can be checked using this 
// website: https://www.toptal.com/developers/keycode
const keyCodeForLetterK = 75;
const keyCodeForEscape = 27;

let app = Elm.Main.init({ node: document.getElementById("app") });

document.addEventListener("keydown", function(e){
    if(e.ctrlKey && e.keyCode === keyCodeForLetterK) {
      e.preventDefault();

      app.ports.showCommandCentre.send(null);
    }

    if (e.keyCode === 27) {
      e.preventDefault();

      app.ports.hideCommandCentre.send(null);
    }
});
