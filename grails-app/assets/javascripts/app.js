// For Password checking at client side

$("#Confirm_Password").keyup(function (){
    if($("#Password").val == $("#Confirm_Password").val){
        $("#msg").text("Matching").css('color', 'green');
    } else{
        $("#msg").text("Not Matching").css('color', 'red');   // not coming here for checking
    }
});


// For making pop login form
// $("LOGIN_FORM").click(
// //     function(){
// //         $("REGISTER_FORM").remove();
// // }
//     $("register_form").display = none;
// );


// File Upload

// let loginForm = document.getElementById("loginForm");
// let registerForm = document.getElementById("registerForm");
//
// loginForm.onclick(function(){
//     console.log("clicked")
//     // registerForm.css.display = none;
// })


// For login form
let loginForm = document.getElementById("loginForm");
loginForm.addEventListener("onclick", function (){
    console.log("clicked");
});

