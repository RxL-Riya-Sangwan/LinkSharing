<%@ page import="link_sharing.Seriousness; link_sharing.Visibility" %>
<!Doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
    Dashboard
    </title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <asset:stylesheet src="app.css" />
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
</head>
<body>
<nav class="mb-4 navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-ui-radios"></i>
            LINK SHARING
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="Navbar for Link Sharing" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a href="#" class="nav-link active" aria-current="page" data-bs-toggle="modal" data-bs-target="#shareDocument"><i class="bi bi-file-earmark-plus-fill" title="Share Document"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="bi bi-link-45deg" title="Share Link" data-bs-toggle="modal" data-bs-target="#shareLink"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="#"><i class="bi bi-chat-text-fill" title="Create Topic" data-bs-toggle="modal" data-bs-target="#createTopic"></i></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        ${session['username'].toString().capitalize()}
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        %{--                                If user is admin show them following 3 items as well--}%
                        <g:if test="${session['role'] == 'admin'}">
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#">Users</a></li>
                            <li><a class="dropdown-item" href="#">Topics</a></li>
                            <li><a class="dropdown-item" href="#">Posts</a></li>
                            <li><hr class="dropdown-divider"></li>
                        </g:if>
                        <li><a class="dropdown-item" href="${createLink(controller: 'home', action: 'logout')}">Logout</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex">
                <input class="form-control me-2" type="search" placeholder="SEARCH" aria-label="Search">
                <button class="btn btn-outline-dark" type="submit">SEARCH</button>
            </form>
        </div>
    </div>
</nav>
%{--${flash.message}--}%
<div class="container mt-2">
    <div class="row">
        <div class="col-sm-5">
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title mb-0">${newUser.firstName} ${newUser.lastName}</h5>
                            <p class="mb-4"> <small class="text-muted">@${newUser.username}</small></p>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>34</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>5</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Trending Topics
                        <a href="" class="rightF linkC">View All</a>
                    </div>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">Grails</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <small class="text-muted">@${newUser.username}</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>${subCount}</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>${topicCount}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer hstack">
                        <select class="form-select m-1" aria-label="Select Seriousness" id="seriousness">
                            <option selected disabled hidden>Seriousness</option>
                            <option value="Very Serious">Very Serious</option>
                            <option value="Serious">Serious</option>
                            <option value="Casual">Casual</option>
                        </select>
                        <select class="form-select m-1" aria-label="Select Topic" id="visiblity">
                            <option selected disabled hidden>Visibility</option>
                            <option value="Private">Private</option>
                            <option value="Public">Public</option>
                        </select>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                    </div>
                    <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">Grails</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <small class="text-muted">@${newUser.username}</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>32</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>5</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer hstack">
                    <select class="form-select m-1" aria-label="Select Seriousness" id="seriousness">
                        <option selected disabled hidden>Seriousness</option>
                        <option value="Very Serious">Very Serious</option>
                        <option value="Serious">Serious</option>
                        <option value="Casual">Casual</option>
                    </select>
                    <select class="form-select m-1" aria-label="Select Topic" id="visiblity">
                        <option selected disabled hidden>Visibility</option>
                        <option value="Private">Private</option>
                        <option value="Public">Public</option>
                    </select>
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                </div>
            </div>
            <div class="border-dark card text-dark bg-liodal" data-id="my_id_value">Open Modal</a>ght mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Subscriptions
                        <a href="" class="rightF linkC">View All</a>
                    </div>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">Grails</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <small class="text-muted">@${newUser.username}</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>32</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>5</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer hstack">
                        <select class="form-select m-1" aria-label="Select Seriousness" id="seriousness">
                            <option selected disabled hidden>Seriousness</option>
                            <option value="Very Serious">Very Serious</option>
                            <option value="Serious">Serious</option>
                            <option value="Casual">Casual</option>
                        </select>
                        <select class="form-select m-1" aria-label="Select Topic" id="visiblity">
                            <option selected disabled hidden>Visibility</option>
                            <option value="Private">Private</option>
                            <option value="Public">Public</option>
                        </select>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                    </div>
                    <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">Grails</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <small class="text-muted">@${newUser.username}</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>32</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>5</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer hstack">
                    <g:select class="form-select m-1" aria-label="Select Seriousness" id="seriousness" from="${Seriousness}" name="seriousness"/>
%{--                        <option selected disabled hidden>Seriousness</option>--}%
%{--                        <option value="Very Serious">Very Serious</option>--}%
%{--                        <option value="Serious">Serious</option>--}%
%{--                        <option value="Casual">Casual</option>--}%
%{--                    </g:select>--}%
                    <g:select class="form-select m-1" aria-label="Select Topic" id="visibility" name="visibility" from="${Visibility}" />
%{--                        <option selected disabled hidden>Visibility</option>--}%
%{--                        <option value="Private">Private</option>--}%
%{--                        <option value="Public">Public</option>--}%
%{--                    </g:select>--}%
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                    <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                </div>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="border-dark card text-dark bg-light" >
                <div class="row g-0">
                    <div class="card-header">
                        Inbox
                        <a href="" class="rightF linkC">View All</a>
                    </div>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title mb-2 me-1">${newUser.firstName} ${newUser.lastName} <small class="text-muted">@${newUser.username} 5min</small><a href="#" class="linkC rightF">Grails</a></h5>
                            <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                            incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                            nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                        </div>
                    </div>
                    <div class="hstack card-footer d-flex justify-content-evenly">
                        <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                        <a href="#" class="linkC">Download</a>
                        <a href="#" class="linkC">View Full Site</a>
                        <a href="#" class="linkC">Mark as Read</a>
                        <a href="#" class="linkC">View Post</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="shareDocument" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Share Document</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <label for="doc" class="col-sm-2 col-form-label">Document</label>
                        <div class="col-sm-10">
                            %{--                                Make file browse functionality: enctype="multipart/form-data"--}%
                            <input type="file" class="form-control" id="doc" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="des" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="des" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="topic" class="col-sm-2 col-form-label">Topic</label>
                        <div class="col-sm-10">
                            <select class="form-select" aria-label="Select Topic" id="topic">
                                <option selected disabled hidden>Select topic for this resource</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-outline-primary">Share</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="sendInvitation" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Send Invitation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <label for="email" class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="email" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="topic" class="col-sm-2 col-form-label">Topic</label>
                        <div class="col-sm-10">
                            <select class="form-select" aria-label="Select Topic" id="topic">
                                <option selected disabled hidden>Select topic for this resource</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-outline-primary">Invite</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="shareLink" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Share Link</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="row mb-3">
                        <label for="linkUrl" class="col-sm-2 col-form-label">Link</label>
                        <div class="col-sm-10">
                            <input type="url" class="form-control" id="linkUrl" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="des" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="des" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="topic" class="col-sm-2 col-form-label">Topic</label>
                        <div class="col-sm-10">
                            <select class="form-select" aria-label="Select Topic" id="topic">
                                <option selected disabled hidden>Select topic for this resource</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-outline-primary">Share</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="createTopic" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Create Topic</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <g:form controller="topic" action="create" method="post">
                    <div class="row mb-3">
                        <label for="topicName" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                            <g:textField class="form-control" id="topicName" name="topicName" required="true" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="visibility" class="col-sm-2 col-form-label">Visibility</label>
                        <div class="col-sm-10">
                            <g:select class="form-select" aria-label="Select Topic" id="visibility" from="${Visibility}"  name="visibility"/>
%{--                                <option selected disabled hidden>Select Visibility</option>--}%
%{--                                <option value="1">Public</option>--}%
%{--                                <option value="2">Private</option>--}%
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <g:submitButton type="button" class="btn btn-outline-primary" name="Create" data-bs-dismiss="modal">Create</g:submitButton>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>

</body>
</html>