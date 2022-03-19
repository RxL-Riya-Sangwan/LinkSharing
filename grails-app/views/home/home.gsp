<!Doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="initial-scale=1, width=device-width">
        <title>
            Home
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
    <nav class="mb-4 bg-light navbar navbar-expand-lg navbar-light">
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
                        <g:link class="nav-link active linkC" id="loginForm" url="[controller: 'home', action: 'register']" method="GET">
                            Don't have an account? Register
                        </g:link>
                    </li>
                </ul>
                <g:form class="d-flex" url="[controller: 'Topic', action: 'search']">
                    <input class="form-control me-2" type="search" placeholder="SEARCH" aria-label="Search">
                    <button class="btn btn-outline-dark" type="submit">SEARCH</button>
                </g:form>
            </div>
        </div>
    </nav>
    <g:if test="${flash.message}">
        <div class="alert alert-success text-center flash" role="alert" style="font-family: monospace">
            ${flash.message}
        </div>
    </g:if>
    <div class="container mt-2">
            <div class="row">
                <div class="col-sm-7">
                    <div class="shadowC mb-3 border-dark card text-dark bg-light" >
                        <div class="row g-0">
                            <div class="card-header">
                                Recent Shares
                            </div>
                            <div class="col-md-3">
                                <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title mb-2 me-1">Uday Pratap Singh <small class="text-muted">@Uday 5min</small><a href="#" class="linkC rightF">Grails</a></h5>
                                    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                                    nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                                </div>
                            </div>
                            <div class="hstack card-footer d-flex justify-content-evenly">
                                <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                                <a href="#" class="linkC">View Full Post</a>
                            </div>
                            <hr>
                            <div class="col-md-3">
                                <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title mb-2 me-1">Uday Pratap Singh <small class="text-muted">@Uday 5min</small><a href="#" class="linkC rightF">Grails</a></h5>
                                    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                                    nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                                </div>
                            </div>
                            <div class="hstack card-footer d-flex justify-content-evenly">
                                <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                                <a href="#" class="linkC">View Full Post</a>
                            </div>
                        </div>
                    </div>
                    <div class="shadowC mt-2 border-dark card text-dark bg-light" >
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
                            <div class="col-md-3">
                                <img src="https://static.vecteezy.com/system/resources/thumbnails/004/154/520/small/user-account-profile-icon-man-human-person-head-sign-icon-free-free-vector.jpg" class="img-fluid rounded-start" alt="User Image">
                            </div>
                            <div class="col-md-9">
                                <div class="card-body">
                                    <h5 class="card-title mb-2 me-1">Uday Pratap Singh <small class="text-muted">@Uday 5min</small><a href="#" class="linkC rightF">Grails</a></h5>
                                    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                    incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
                                    nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </p>
                                </div>
                            </div>
                            <div class="hstack card-footer d-flex justify-content-evenly">
                                <a href="#" class="linkC"><i class="bi bi-google"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-twitter"></i></a>
                                <a href="#" class="linkC"><i class="bi bi-meta"></i></a>
                                <a href="#" class="linkC">View Full Post</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-1"></div>
                <div class="col-sm-4">
                    <div class="shadowC border border-dark card registerForm">
                        <div class="card-header">
                            Login
                        </div>
                        <div class="card-body">
                            <g:form class="m-2 p-4" url="[controller: 'home', action: 'login']" method="post">
                                <div class="mb-4">
                                    <label for="UserName">Username/Email</label>
                                    <g:textField autocomplete="off" class="form-control" name="username" id="UserName" required="true"/>
                                    <a href="${createLink(action: 'forgotPassword')}" class="small rightF linkC">
                                        Forgot Password?
                                    </a>
                                </div>
                                <div class="mb-4">
                                    <label for="Password">Password</label>
                                    <g:passwordField placeholder="Must be of 8 to 20 characters" class="form-control" name="password" id="Password" required="true"/>
                                </div>
                                <g:submitButton class="btn btn-outline-dark" name="Login"/>
                            </g:form>
                        </div>
                </div>
            </div>
            </div>
    </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <asset:javascript src="app.js" />
</html>


