<!Doctype html>
<html>
    <head>
        <meta name="layout" content="main" />
        <title>Dashboard</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-7">
                    <div class="card border-dark mb-3">
                        <div class="card-header">Recent Shares
                        </div>
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="https://svgsilh.com/svg/659651.svg" class="img-fluid rounded-start" alt="...">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">Grails</h5>
                                    <p class="card-text">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quo perspiciatis eius, rem dolore saepe ipsam voluptates? Nihil, temporibus deleniti. Veniam illo maxime at neque quasi ducimus nam corporis possimus ad.</p>
                                    <p class="card-text"><small class="text-muted">View Post</small></p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="https://svgsilh.com/svg/659651.svg" class="img-fluid rounded-start" alt="...">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">Grails</h5>
                                    <p class="card-text">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quo perspiciatis eius, rem dolore saepe ipsam voluptates? Nihil, temporibus deleniti. Veniam illo maxime at neque quasi ducimus nam corporis possimus ad.</p>
                                    <p class="card-text"><small class="text-muted">View Post</small></p>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="card border-dark mt-3">
                        <div class="card-header">Top Posts
                        </div>
                        <div class="row g-0">
                            <div class="col-md-4">
                                <img src="https://svgsilh.com/svg/659651.svg" class="img-fluid rounded-start" alt="...">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">Grails</h5>
                                    <p class="card-text">Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quo perspiciatis eius, rem dolore saepe ipsam voluptates? Nihil, temporibus deleniti. Veniam illo maxime at neque quasi ducimus nam corporis possimus ad.</p>
                                    <p class="card-text"><small class="text-muted">View Post</small></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <div class="col-5">
                        <g:form class="border border-dark p-4 mb-3">
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Email Address/Username</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Password</label>
                                <input type="password" class="form-control" id="exampleInputPassword1">
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Remember Me</label>
                            </div>
                            <div class="mb-3">
                                <a href="/forgotPassword">Forgot Password?</a>
                            </div>
                            <button type="submit" class="btn btn-primary">Login</button>
                        </g:form>

                        <form class="border border-dark p-4 mt-3">
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">First Name</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Last Name</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" >Password</label>
                                <input type="password" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="exampleInputPassword1">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Picture</label>
                                <input type="file" class="form-control" id="exampleInputPassword1">
                            </div>
                            <button type="submit" class="btn btn-primary">Register</button>
                        </form>
                    </div>

            </div>

        </div>
    </body>
</html>
