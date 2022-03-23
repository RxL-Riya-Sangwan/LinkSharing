<%@ page import="link_sharing.Topic; link_sharing.Subscription; link_sharing.Seriousness" %>
<!Doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
        ${topic.name.toString().capitalize()}
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
                    <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
    <div class="container mt-2">
        <div class="row">
        <div class="col-sm-5">
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                       Topic: ${topic.name.capitalize()}
                    </div>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">${topic.name.capitalize()} <small class="text-muted"> ${topic.visibility}</small> </h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <small class="text-muted">@${topic.createdBy.username}</small>
                                        <p><a class="linkC" href="#">Unsubscribe</a></p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>${usersList.size()}</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Posts</p>
                                        <small>${resourceDataList.size()}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer hstack">
                        <g:select class="form-select m-1" aria-label="Select Seriousness" id="seriousness" from="${Seriousness}" name="seriousness" />
                        <a class="nav-link bg-light text-dark me-4" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                    </div>
                </div>
            </div>
            <div class="border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Users: ${topic.name.capitalize()}
                    </div>
                    <g:each var="sub" in="${usersList.take(5)}">
                        <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">${sub.userdata.firstName} ${sub.userdata.lastName}</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <g:link class="linkC" controller="userData" action="profile" params="[username: sub.userdata.username]"><small class="text-muted profile">@${sub.userdata.username}</small></g:link>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>${Subscription.countByUserdata(sub.userdata)}</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Topics</p>
                                        <small>${Topic.countByCreatedBy(sub.userdata)}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </g:each>
                </div>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="border-dark card text-dark bg-light" >
                <div class="row g-0">
                    <div class="card-header">
                        <div class="container">
                            <div class="row">
                                <div class="col-7">
                                    Posts: ${topic.name.capitalize()}
                                </div>
                                <div class="col-5">
                                    <select class="form-select-sm rightF" aria-label="Search" id="topic">
                                        <option value="today" selected>Search</option>
                                        <option value="week">One Week</option>
                                        <option value="month">One Month</option>
                                        <option value="year">One year</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                <g:each var="post" in="${resourceDataList.take(5)}">
                    <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title mb-4 me-1 ">${post.getCreatedBy().firstName} ${post.getCreatedBy().lastName}
                                <g:link class="linkC" controller="userData" action="profile" params="[username: post.getCreatedBy().username]"><small class="text-muted profile">@${post.getCreatedBy().username}</small></g:link>
                               </h5>
                            <p class="card-text">${post.description}</p>
                        </div>
                    </div>
                    <div class="hstack card-footer d-flex justify-content-evenly">
                        <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                        <a href="#" class="linkC">Download</a>
                        <a href="#" class="linkC">View Full Site</a>
                        <a href="#" class="linkC">Mark as Read</a>
                        <g:link class=" linkC" controller="ResourceData" action="showPost" params="[postId: post.id]">
                            View Post </g:link>
                    </div>
                </g:each>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
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

</body>
</html>