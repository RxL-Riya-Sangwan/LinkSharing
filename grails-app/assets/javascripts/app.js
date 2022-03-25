
// For password matching -- client Side

$("#confirmPassword").on("keyup change",
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


// For updating the status of user

$(".updateStatus").click(function(){

    data.userId = $(this).attr("data-userId");
    let that = $(this)

    $.ajax({
        type: 'GET',
        url: url,
        data: data,
        success: function (){
            console.log('success');
            let id = $(that).attr("data-userId");
            let element = $(`.activeStatus[data-userId=${id}]`);

            if ($(that).html() === "Deactivate"){
                $(that).html("Activate");
                element.html('False');
            }
            else{
                $(that).html("Deactivate");
                element.html('True');
            }

        },
        failure: function (){
            console.log('failure')
        }
    })

});


// For updating the admin status
$(".makeAdmin").click(function(){

    data.userId = $(this).attr("data-userId");
    let that = $(this)

    $.ajax({
        type: 'GET',
        url: urlAdmin,
        data: data,
        success: function (){

            console.log('success');

                if ($(that).html() === "True"){
                    $(that).html("False");
                }
                else{
                    $(that).html("True");
                }


        },
        failure: function (status){
            console.log('failure')
        }
    })

});


//  For inline editing topic name
// $(".editTopic").click(function(){
//     console.log('clicked')
//     data.topicId = $(".topicName").attr("data-topicId");
//     let id = data.topicId
//     // $(`.topicName[data-topicId=${id}]`).attr("contentEditable", "true");
//     let element = $(`.topicName[data-topicId=${id}]`)
//     let value = 'Ajax'
//     // console.log(value);
//     let form = "<input class='form-control' name='name' type='text' value='" + value +"'> <button class='btn btn-outline-success' onclick='changeTopicName(this)'>Submit</button> <button class='btn btn-outline-danger'>Cancel</button>"
//     element.replaceWith(form)
// });
//
// function changeTopicName(){
//         console.log("submit");
//         $.ajax({
//             type: "GET",
//             url: url,
//             data: data,
//             success: function(){
//                 alert('success');
//             },
//             failure: function (){
//                 alert('failure');
//             }
//         })
//
// }
//
//
// function cancelEditing(prev, element){
//     console.log("cancel");
//     prev.replaceWith(element)
// }

var temp;
$(".visibility").change(function(){
        temp = this
        data.topicId = $(this).attr("data-topicId")
        data.visibility = temp.value
        console.log(data.topicId)

        $.ajax({
            type: "GET",
            data: data,
            url: urlV,
            success: function (){
                    console.log("success")
            },
            failure: function (){
                    console.log("failed")
            }
        })
});


var temp2
$(".seriousness").change(function(){
    temp2 = this
    data.topicId = $(this).attr("data-topicId")
    data.seriousness = temp2.value
    console.log(data.topicId)

    $.ajax({
        type: "GET",
        data: data,
        url: urlS,
        success: function (){
            console.log("success")
        },
        failure: function (){
            console.log("failed")
        }
    })
});




