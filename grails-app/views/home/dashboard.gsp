<%@ page import="link_sharing.ResourceData; link_sharing.Subscription; link_sharing.Seriousness; link_sharing.Visibility" %>
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
                        <li><a class="dropdown-item" href="${createLink(controller: 'userData', action: 'edit')}">Profile</a></li>
                        %{--                                If user is admin show them following 3 items as well--}%
                        <g:if test="${session['role'] == 'admin'}">
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${createLink(controller: 'home', action: 'admin')}">Users</a></li>
                            <li><a class="dropdown-item" href="${createLink(controller: 'topic', action: 'show')}">Topics</a></li>
                            <li><a class="dropdown-item" href="${createLink(controller: 'resourceData', action: 'show')}">Posts</a></li>
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
<g:if test="${flash.warning}">
    <div class="alert alert-danger text-center flash" role="alert" style="font-family: monospace">
        ${flash.warning}
    </div>
</g:if>
<div class="container mt-2">
    <div class="row">
        <div class="col-sm-5">
            <div class="shadowC border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title mb-0">${newUser.firstName} ${newUser.lastName}</h5>
                            <p class="mb-4">
                                <g:link class="linkC" controller="userData" action="profile" params="[username: newUser.username]"><small class="text-muted profile">@${newUser.username}</small></g:link>
                            </p>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <p>
                                        <g:link class="linkC" controller="subscription" action="show">Subscriptions</g:link>
                                        </p>
                                        <small>${countSub}</small>
                                    </div>
                                    <div class="col">
                                        <p>
                                            <g:link class="linkC" controller="topic" action="list">Topics</g:link>
                                        </p>
                                        <g:if test="${countTopic}">
                                            <small>${countTopic}</small>
                                        </g:if>
                                        <g:else>
                                            <small>0</small>
                                        </g:else>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="shadowC border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Trending Topics
                        <g:link class="linkC rightF" controller="topic" action="show">View All</g:link>
                    </div>
                    <g:each var="topic" in="${trendingList.take(5)}">
                        <hr>
                        <div class="col-md-3">
                            <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <g:link class="topicLink" controller="topic" action="topicShow" params="[topicName: topic.name]">
                                        ${topic.name}</g:link>
                                </h5>
                                <div class="container">
                                    <div class="row">
                                        <div class="col">
                                            <p class="mb-4">
                                                <g:link class="topicLink" controller="userData" action="profile" params="[username: topic.createdBy.username]"><small class="text-muted profile">@${topic.createdBy.username}</small></g:link>
                                            </p>
                                            <p>
                                                <g:if test="${Subscription.findByTopicAndUserdata(topic, newUser)}">
                                                    <g:link class="linkC" controller="Subscription" action="unsubscribe" params="[topic: topic.name, username: newUser.username, subscription: Subscription.findByTopicAndUserdata(topic, newUser).id]">
                                                        Unsubscribe
                                                    </g:link>
                                                </g:if>
                                                <g:else>
                                                    <g:link class="linkC" controller="Subscription" action="subscribe" params="[topic: topic.name, username: newUser.username]">
                                                        Subscribe
                                                    </g:link>
                                                </g:else>
                                            </p>
                                        </div>
                                        <div class="col">
                                            <p class="linkC">Subscriptions</p>
                                            <small>${Subscription.countByTopic(topic)}</small>
                                        </div>
                                        <div class="col">
                                            <p class="linkC">Posts</p>
                                                <small>${ResourceData.countByTopic(topic)}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer hstack">
                            <g:select class="form-select m-1" aria-label="Select Seriousness" id="seriousness" from="${Seriousness}" name="seriousness" />
                            <g:select class="form-select m-1" aria-label="Select Topic" id="visibility" from="${Visibility}" name="visibility"/>

                            <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                            <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                            <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                        </div>
                    </g:each>
                </div>
            </div>
            <div class="shadowC border-dark card text-dark bg-light mb-3">
                <div class="row g-0">
                    <div class="card-header">
                        Subscriptions
                       <g:link controller="subscription" action="show" class="rightF linkC">View All</g:link>
                    </div>
                    <g:each var="sub" in="${subList.take(5).sort{it.topic.lastUpdated}}">
                        <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h5 class="card-title">${sub.topic.name.capitalize()}</h5>
                            <div class="container">
                                <div class="row">
                                    <div class="col">
                                        <g:link class="linkC" controller="userData" action="profile" params="[username: sub.topic.createdBy.username]"><small class="text-muted profile">@${sub.topic.createdBy.username}</small></g:link>
                                        <p>
                                            <g:if test="${Subscription.findByTopicAndUserdata(sub.topic, newUser)}">
                                                <g:link class="linkC" controller="Subscription" action="unsubscribe" params="[topic: sub.topic.name, username: newUser.username]">
                                                    Unsubscribe
                                                </g:link>
                                            </g:if>
                                            <g:else>
                                                <g:link class="linkC" controller="Subscription" action="subscribe" params="[topic: sub.topic.name, username: newUser.username]">
                                                    Subscribe
                                                </g:link>
                                            </g:else>
                                        </p>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Subscriptions</p>
                                        <small>${Subscription.countByTopic(sub.getTopic())}</small>
                                    </div>
                                    <div class="col">
                                        <p class="linkC">Posts</p>
                                        <small>${ResourceData.countByTopic(sub.getTopic())}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer hstack">
                        <g:select class="form-select m-1" aria-label="Select Seriousness" id="seriousness" name="seriousness" from="${Seriousness}">
%{--                            <option selected disabled hidden>Seriousness</option>--}%
%{--                            <option value="Very Serious">Very Serious</option>--}%
%{--                            <option value="Serious">Serious</option>--}%
%{--                            <option value="Casual">Casual</option>--}%
                        </g:select>
                        <g:select class="form-select m-1" aria-label="Select Topic" id="visiblity" name="visibility" from="${Visibility}">
%{--                            <option selected disabled hidden>Visibility</option>--}%
%{--                            <option value="Private">Private</option>--}%
%{--                            <option value="Public">Public</option>--}%
                        </g:select>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-envelope-dash-fill" title="Send Invitation" data-bs-toggle="modal" data-bs-target="#sendInvitation"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-pencil-square" title="Edit Topic"></i></a>
                        <a class="nav-link bg-light text-dark" href="#"><i class="bi bi-trash-fill" title="Unsubscribe"></i></a>
                    </div>
                    </g:each>
                </div>
            </div>
        </div>
        <div class="col-sm-1"></div>
        <div class="col-sm-6">
            <div class="shadowC border-dark card text-dark bg-light" >
                <div class="row g-0">
                    <div class="card-header">
                        Inbox
                        <g:link controller="readingItem" action="show" class="rightF linkC">View All</g:link>
                    </div>
                    <g:each var="post" in="${readingList.take(5)}">
                        <hr>
                    <div class="col-md-3">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                    </div>
                    <div class="col-md-9">
                        <div class="card-body">
                            <h6 class="card-title px-2">${post.createdBy.firstName} ${post.createdBy.lastName} <small class="text-muted small">@${post.createdBy.username} ${(new Date() - post.dateCreated)*24} hrs</small>
                                <g:link controller="topic" action="topicShow" params="[topicName: post.topic.name]" class="linkC rightF small">${post.topic.name.capitalize()}</g:link>
                            </h6>
                            <p class="card-text small pt-2 px-2">${post.description.capitalize()}</p>
                        </div>
                    </div>
                    <div class="hstack card-footer d-flex justify-content-evenly small">
                        <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                        <a href="#" class="linkC">Download</a>
                        <a href="#" class="linkC">View Full Site</a>
                        <g:link controller="readingItem" action="remove" class="linkC" params="[postId: post.id]">Mark as Read</g:link>
                        <g:link class="linkC" controller="ResourceData" action="showPost" params="[postId: post.id]">
                            View Post </g:link>
                    </div>
                    </g:each>
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
                            <g:select class="form-select"  id="topic" name="topic" from="${topicList}">
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
                            <g:select class="form-select" aria-label="Select Topic" id="topic" from="${topicList}" name="topic">
%{--                                <option selected disabled hidden>Select topic for this resource</option>--}%
%{--                                <option value="1">One</option>--}%
%{--                                <option value="2">Two</option>--}
%{--                                <option value="3">Three</option>--}%
                            </g:select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-outline-primary" data-bs-dismiss="modal">Invite</button>
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
                            <g:select class="form-select" aria-label="Select Topic" id="topic" from="${topicList}" name="topic">
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
                <g:form controller="topic" action="create" method="post">
                    <div class="row mb-3">
                        <label for="name" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                            <g:textField class="form-control" id="name" name="name" required="true" />
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="visibility" class="col-sm-2 col-form-label">Visibility</label>
                        <div class="col-sm-10">
                            <g:select class="form-select" aria-label="Select Topic" value="${Visibility}" id="visibility" from="${Visibility}"  name="visibility"/>
%{--                                <option selected disabled hidden>Select Visibility</option>--}%
%{--                                <option value="1">Public</option>--}%
%{--                                <option value="2">Private</option>--}%
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-danger" data-bs-dismiss="modal">Cancel</button>
                        <Button type="submit" class="btn btn-outline-primary" name="Create" data-bs-dismiss="modal">Create</Button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <asset:javascript src="app.js" />
</body>
</html>