<%@ page import="link_sharing.ResourceData; link_sharing.Visibility; link_sharing.Seriousness; link_sharing.UserData; link_sharing.Subscription" %>
<!Doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
    Search
    </title>
    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <asset:stylesheet src="app.css" />

    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oxygen&display=swap" rel="stylesheet">
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
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
                        <li><a class="dropdown-item" href=${createLink(controller: 'home', action: 'logout')}>Logout</a></li>
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
                                            <small>${Subscription.countByUserdataAndTopic(newUser, topic)}</small>
                                        </div>
                                        <div class="col">
                                            <p class="linkC">Posts</p>
                                            <small>${ResourceData.countByCreatedByAndTopic(newUser, topic)}</small>
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
            <div class="shadowC border-dark card text-dark bg-light" >
                <div class="row g-0">
                    <div class="card-header">
                        <div class="container">
                            <div class="row">
                                <div class="col-7">
                                    Top Posts
                                </div>
                                <div class="col-5">
                                    <select class="form-select-sm rightF" aria-label="Time" id="topic">
                                        <option value="today" selected>Today</option>
                                        <option value="week">One Week</option>
                                        <option value="month">One Month</option>
                                        <option value="year">One year</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <g:each var="post" in="${topPosts}">
                        <hr>
                        <div class="col-md-3">
                            <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                        </div>
                        <div class="col-md-9">
                            <div class="card-body">
                                <h6 class="card-title">${post.createdBy.firstName} ${post.createdBy.lastName}
                                    <g:link class="linkC small" controller="userData" action="profile" params="[username: post.createdBy.username]">
                                        <small class="text-muted profile">@${post.createdBy.username}</small>
                                    </g:link>
                                    <small class="text-muted small">${(new Date() - post.lastUpdated) * 24} hrs</small>
                                    <g:link class="m-2 linkC rightF small px-2" controller="topic" action="topicShow" params="[topicName: post.topic.name]">
                                        ${post.topic.name}</g:link></h6>
                                <p class="card-text small pt-2">${post.description}</p>
                            </div>
                        </div>
                        <div class="hstack small card-footer d-flex justify-content-evenly">
                            <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                            <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                            <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                            <g:link class=" linkC" controller="ResourceData" action="showPost">
                                View Full Post </g:link>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
        <div class="col-sm-1"></div>
%{--        <div class="border-dark card text-dark bg-light" >--}%
%{--            <div class="row g-0">--}%
%{--                <div class="card-header">--}%
%{--                    <div class="container">--}%
%{--                        <div class="row">--}%
%{--                            <div class="col-7">--}%
%{--                                Posts: ${topic.name.capitalize()}--}%
%{--                            </div>--}%
%{--                            <div class="col-5">--}%
%{--                                <select class="form-select-sm rightF" aria-label="Search" id="topic">--}%
%{--                                    <option value="today" selected>Search</option>--}%
%{--                                    <option value="week">One Week</option>--}%
%{--                                    <option value="month">One Month</option>--}%
%{--                                    <option value="year">One year</option>--}%
%{--                                </select>--}%
%{--                            </div>--}%
%{--                        </div>--}%
%{--                    </div>--}%
%{--                </div>--}%
%{--                <g:each var="post" in="${resourceDataList.take(5)}">--}%
%{--                    <hr>--}%
%{--                    <div class="col-md-3">--}%
%{--                        <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">--}%
%{--                    </div>--}%
%{--                    <div class="col-md-9">--}%
%{--                        <div class="card-body">--}%
%{--                            <h5 class="card-title mb-4 me-1 ">${post.getCreatedBy().firstName} ${post.getCreatedBy().lastName}--}%
%{--                                <g:link class="linkC" controller="userData" action="profile" params="[username: post.getCreatedBy().username]"><small class="text-muted profile">@${post.getCreatedBy().username}</small></g:link>--}%
%{--                            </h5>--}%
%{--                            <p class="card-text">${post.description}</p>--}%
%{--                        </div>--}%
%{--                    </div>--}%
%{--                    <div class="hstack card-footer d-flex justify-content-evenly">--}%
%{--                        <a href="#" class="linkC"><i class="bi bi-google"></i></a>--}%
%{--                        <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>--}%
%{--                        <a href="#" class="linkC"><i class="bi bi-meta"></i></a>--}%
%{--                        <a href="#" class="linkC">Download</a>--}%
%{--                        <a href="#" class="linkC">View Full Site</a>--}%
%{--                        <a href="#" class="linkC">Mark as Read</a>--}%
%{--                        <g:link class=" linkC" controller="ResourceData" action="showPost" params="[postId: post.id]">--}%
%{--                            View Post </g:link>--}%
%{--                    </div>--}%
%{--                </g:each>--}%
%{--            </div>--}%
%{--        </div>--}%
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<asset:javascript src="app.js" />
</html>
