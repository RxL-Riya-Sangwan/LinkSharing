<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
        Login
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
        <a class="navbar-brand" href="#">
            <i class="bi bi-ui-radios"></i>
            LINK SHARING
        </a>
    </div>
</nav>
    <div class="container mt-2">
        <div class="row">
            <div class="col-3"></div>
            <div class="col-6">
                <div class="shadowC border border-dark card">
                    <div class="card-header">
                        Login
                    </div>
                    <div class="card-body">
                        <g:form class="m-2 p-4" url="[controller: 'home', action: 'login']" method="post">
                            <div class="mb-3">
                                <label for="UserName">Username/Email</label>
                                <g:textField autocomplete="off" class="form-control" name="username" id="UserName" required="true"/>
                                <a href="${createLink(action: 'forgotPassword')}" class="small rightF linkC">
                                    Forgot Password?
                                </a>
                            </div>
                            <div class="mb-3">
                                <label for="Password">Password</label>
                                <g:passwordField placeholder="Must be of 8 to 20 characters" class="form-control" name="password" id="Password" required="true"/>
                            </div>
                            <g:submitButton class="btn btn-outline-dark" name="Login"/>
                        </g:form>
                    </div>
                    <div class="card-footer">
                        <a href="${createLink(action: 'register')}" class="linkC">
                            Don't have an Account? Register
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-3"></div>
        </div>
    </div>
    </body>
</html>