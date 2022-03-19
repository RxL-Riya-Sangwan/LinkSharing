<!DOCTYPE html>
<html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>
        Forgot Password
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
    </div>
</nav>
<g:if test="${flash.message}">
    <div class="alert alert-success text-center font-monospace flash" role="alert">
        ${flash.message}
    </div>
</g:if>
    <div class="container mt-2">
    <div class="row">
        <div class="col-3"></div>
        <div class="col-6">
            <div class="shadowC border border-dark card">
                <div class="card-header">
                    Forgot Password
                </div>
                <div class="card-body">
                    <g:form url="[controller: 'home', action: 'forgot']" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="email" aria-describedby="emailHelp" name="email">
                        </div>
                        <button type="submit" class="btn btn-outline-dark">Send Link for Password Reset</button>
                    </g:form>
                </div>
                <div class="card-footer">
                    <a href="${createLink(action: 'register')}" class="linkC m-2">Register</a>
                    <a href="${createLink(action: 'login')}" class="linkC rightF m-2">Login</a>
                </div>
            </div>
        </div>
        <div class="col-3"></div>
    </div>
</div>
</body>
</html>
