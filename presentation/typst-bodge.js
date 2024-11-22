// ==UserScript==
// @name         New Userscript
// @namespace    http://tampermonkey.net/
// @version      2024-11-12
// @description  try to take over the world!
// @author       You
// @match        https://typst.app/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    let rightClickRunning = false;

    window.keyToArrow = true;

     function isMouseOverButton(event) {
         let elementUnderMouse = document.elementFromPoint(event.clientX, event.clientY);

         // Traverse up the DOM tree to check if the element or any of its parents is a button
         while (elementUnderMouse) {
             if (elementUnderMouse.tagName.toLowerCase() === 'button') {
                 return true;
             }
             elementUnderMouse = elementUnderMouse.parentElement;
         }

         return false;
     }

    function changeSlide(next) {
        document.getElementsByClassName("_group_7bhjp_1").item(0).children.item(next ? 3 : 0).click()
        console.log("changeSlide", next)
    }

    window.addEventListener("click", (event) => {
        console.log("button", event.button)
        if (window.keyToArrow && event.button == 0 && !rightClickRunning && !isMouseOverButton(event) && document.getElementsByClassName("_clocks_18ycw_62").length != 0) {
            changeSlide(true);
        }
    })

    window.addEventListener('contextmenu', function(ev) {
        rightClickRunning = true;
        ev.preventDefault();
        if (window.keyToArrow && !isMouseOverButton(event) && document.getElementsByClassName("_clocks_18ycw_62").length != 0) {
            changeSlide(false);
        }
        rightClickRunning = false;
        return false;
    }, false);



})();