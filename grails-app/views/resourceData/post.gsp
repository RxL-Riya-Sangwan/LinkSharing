<!Doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
        ${post.topic.toString().capitalize()}'s Post
%{--        Post--}%
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
        <a class="navbar-brand" href="${createLink(controller: 'home', action: 'index')}">
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
                    <a class="nav-link active" href="#"><i class="bi bi-link-45deg" title="Share Link" data-bs-toggle="modal" data-bs-target="#shareLink"></i></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link active dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <g:if test="${session['username']}">
                            ${session['username'].toString().capitalize()}
                        </g:if>
                        <g:else>
                            User
                        </g:else>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${createLink(controller: 'userData', action: 'profile')}">Profile</a></li>
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
<g:if test="${flash.message}">
    <div class="alert alert-success text-center flash" role="alert" style="font-family: monospace">
        ${flash.message}
    </div>
</g:if>
<g:elseif test="${flash.warning}">
    <div class="alert alert-danger text-center flash" role="alert" style="font-family: monospace">
        ${flash.warning}
    </div>
</g:elseif>
<div class="container mt-2">
    <div class="row">
        <div class="col-sm-6">
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title mb-2 me-1">${post.getCreatedBy().firstName} ${post.getCreatedBy().lastName} <small class="text-muted"> @${post.getCreatedBy().username} ${new Date() - post.lastUpdated}hrs</small><a href="#" class="linkC rightF">${post.topic.name.capitalize()}</a></h5>
                            <small class="text-muted small">
                                <g:formatDate date="${post.getDateCreated()}" type="datetime" style="MEDIUM"/>
                                </small>
                            <h5 class="card-title mb-2 d-flex justify-content-end m-2">
                                <g:each var="count" in="${1..5}">
                                    <i class="bi bi-heart m-1 rating" data-count="${count}" onclick="rating(${count}, '${session["username"]}', ${post.id})"></i>
                                </g:each>
                            </h5>
                            <p class="card-text pt-2">${post.description}</p>
                        </div>
                    </div>
                    <div class="hstack pt-2 card-footer d-flex justify-content-evenly">
                        <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                        <g:link class="linkC" controller="resourceData" action="delete" params="[postId: post.getId()]">
                        Delete</g:link>
%{--                        <g:if test="${post.get}"--}%
                        <a href="#" class="linkC">Edit</a>
                        <a href="#" class="linkC">Download</a>
                        <a href="#" class="linkC">View Post</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Users Rated this Post
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
                                        <small class="text-muted">@Uday</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>32</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Post</p>
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
                                        <small class="text-muted">@Uday</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>32</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Post</p>
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
                <g:form controller="resourceData" action="createDocument" enctype="multipart/form-data">
                    <div class="row mb-3">
                        <label for="doc" class="col-sm-2 col-form-label">Document</label>
                        <div class="col-sm-10">
                            %{--                            accept="application/pdf"--}%
                            <input type="file" class="custom-file-input form-control" id="doc" name="file" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="des" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="des" rows="3" required name="description"></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="topic" class="col-sm-2 col-form-label">Topic</label>
                        <div class="col-sm-10">
                            <g:select class="form-select"  id="topic" name="topic" from="${subList.topic.name}">
                            %{--                                <option selected disabled hidden>Select topic for this resource</option>--}%
                            %{--                                <option value="1">One</option>--}%
                            %{--                                <option value="2">Two</option>--}%
                            %{--                                <option value="3">Three</option>--}%
                            </g:select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-outline-primary" data-bs-dismiss="modal">Share</button>
                    </div>
                </g:form>
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
                <g:form controller="resourceData" action="createLink">
                    <div class="row mb-3">
                        <label for="linkUrl" class="col-sm-2 col-form-label">Link</label>
                        <div class="col-sm-10">
                            <input type="url" class="form-control" id="linkUrl" name="url" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="des" class="col-sm-2 col-form-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="des" rows="3" name="description" required></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="topic" class="col-sm-2 col-form-label">Topic</label>
                        <div class="col-sm-10">
                            <g:select class="form-select" aria-label="Select Topic" id="topic" from="${subList.topic.name}" name="topic">
                            %{--                                <option selected disabled hidden>Select topic for this resource</option>--}%
                            %{--                                <option value="1">One</option>--}%
                            %{--                                <option value="2">Two</option>--}%
                            %{--                                <option value="3">Three</option>--}%
                            </g:select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-outline-primary" data-bs-dismiss="modal">Share</button>
                    </div>
                </g:form>
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
                <form>
                    <div class="row mb-3">
                        <label for="topicName" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="topicName" required>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="visibility" class="col-sm-2 col-form-label">Visibility</label>
                        <div class="col-sm-10">
                            <select class="form-select" aria-label="Select Topic" id="visibility">
                                <option selected disabled hidden>Select Visibility</option>
                                <option value="1">Public</option>
                                <option value="2">Private</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-outline-primary">Create</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
    let url = '<g:createLink controller="resourceRating" action="rate" />'
    let data = {};
</script>
<asset:javascript src="app.js" />
</body>
</html>