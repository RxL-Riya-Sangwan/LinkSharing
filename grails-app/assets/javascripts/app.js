
// For password matching -- client Side
$("#confirmPassword").on("change keyup",
    function(){
        if($("#password").val() == $("#confirmPassword").val()){
            console.log('matching')
            $("#msg").text("Matching").css('color', 'green');
        }
        else{
            console.log('not matching')
            $("#msg").text("Not Matching").css('color', 'red');
        }
});


// $(".profile").onclick(function (e){
//     let username = $(this).attr("data-id")
//     let href = $(this).attr("href") + "?username=" + username
//     console.log(href)
// });


function flashFade(){
    $(".flash").fadeOut('normal', 'swing');
}


$(document).ready(function (){
        setTimeout(flashFade, 1500);
});


// $('.profile').click(function (){
//     let username = this.textContent.slice(1,);
//     let data = {};
//     let url = '<g:createLink controller="userData" action="profile" />';
//     data.username = username;
//     $.ajax({
//         type: "GET",
//         url: url,
//         data: data,
//         success: function (result){
//             alert('ok');
//         },
//         error: function (result){
//             alert('not okay');
//         }
//     });
// });


$(".homeLink").click(function(){
    alert("You are not logged In");
});

