function loadLoginForm() {
    console.log(window.location.href);
        var loginHTML=`
            <H3>Profile</h3>
            <div>
			<form>
              <input type="text" id="username" placeholder="username"/>
              <input type="password" id="password"/>
				<input type="email" id="email"/>
              <br>
              <input type="submit" id="register_btn"/>
			</form>
          </div>
        `;
  }

var register = document.getElementById("register_btn");

var login = function() {
    var request = new XMLHttpRequest();
    register.value="Logging In...";
    register.disabled=true;
    //Capture the response and store it in a variable
     request.onreadystatechange = function () {
          if (request.readyState === XMLHttpRequest.DONE) {
              // Take some action
              if (request.status === 200) {
                  register.disabled=false;
                  register.value="Sign Up";
                  alert('Success!');
               } else if(request.status===403 || request.status===400 ) {
                   alert('Username/Password invalid');
                   register.disabled=false;
                  submit.value="Sign Up";
               } else if (request.status===500) {
                   alert('Something went wrong on the server.');
                   register.disabled=false;
                  register.value="Sign Up";
               } else{
                   alert('Something went wrong on the server.');
                   register.disabled=false;
                  register.value="Sign Up";
               }
               loadLogin();
            }
        };

        var username=document.getElementById('username').value;
        var password = document.getElementById('password').value;
        request.open('POST', '/login', true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.send(JSON.stringify({username: username, password: password}));

}
register.onclick = function () {
    //Create a request object
    var request = new XMLHttpRequest();
    register.value="Registering";
    register.disabled=true;
    //Capture the response and store it in a variable
             request.onreadystatechange = function () {
          if (request.readyState === XMLHttpRequest.DONE) {
              // Take some action
              if (request.status === 200) {
                  alert('We have created your account successfully!!!');
                  register.value = 'Sign Up';
                  register.disabled=false;
				  login();
                  
              } else {
                  alert('Oops... We couldn\'t register you...');
                  register.value = 'Sign Up';
                register.disabled=false;
              }
          }
        };
		
        var username=document.getElementById('username').value;
        var password = document.getElementById('password').value;
		var email = document.getElementById('email').value;
        request.open('POST', '/create-user', true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.send(JSON.stringify({username: username, password: password, email: email}));
        
    };

