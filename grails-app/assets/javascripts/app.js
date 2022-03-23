
// For password matching -- client Side

$("#confirmPassword").on("change keyup",
    function(){
        if($("#password").val() == $("#confirmPassword").val()){
            console.log('matching')
            console.log($("#password").val(), $("#confirmPassword").val())
            $("#msg").text("Matching").css('color', 'green');
        }
        else{
            console.log('not matching')
            console.log($("#password").val(), $("#confirmPassword").val())
            $("#msg").text("Not Matching").css('color', 'red');
        }
});


// For flashing messages and warning

function flashFade(){
    $(".flash").fadeOut('normal', 'swing');
}


$(document).ready(function (){
        setTimeout(flashFade, 1500);
});


// For not allowing user to access posts or any other data before login

$(".homeLink").click(function(){
    alert("You are not logged In");
});


// For rating the post

function rating(count, username, postId){
    data.username = username
    data.count = count
    data.postId = postId
    $.ajax({
        type: "GET",
        url: url,
        data: data,
        success: function(){
           console.log("success")
            $(".rating").each(function(){
                if($(this).attr("data-count") <= data.count){
                    $(this).removeClass("bi-heart").addClass("bi-heart-fill");
                }

                if($(this).attr("data-count") > data.count){
                    $(this).removeClass("bi-heart-fill").addClass("bi-heart");
                }
            });
        },
        error: function (){
            console.log('error')
        }
    });
}




