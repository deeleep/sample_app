// Menu manipulation 

// Add a toggle listener to listen for clicks 
document.addEventListener( "turbo:load" ,  function ()  { 

    let hamburger = document.querySelector("#hamburger");
    if (hamburger){
      hamburger.addEventListener("click", function(event) {
        event.preventDefault();
        let menu = document.querySelector("#navbar-menu");
        menu.classList.toggle("collapse");
      });
    }
    let  account  =  document . querySelector ( "#account" ); 
    if  (account)  { 
      account.addEventListener ( "click" , function (event )  { 
        event.preventDefault (); 
        let  menu  =  document.querySelector ( "#dropdown-menu" ); 
        menu.classList.toggle( "active" ); 
      }); 
    } 
  });
  