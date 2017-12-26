var express = require('express');
var morgan = require('morgan');
var path = require('path');
var mysql=require('mysql');
var crypto = require('crypto');
var bodyParser = require('body-parser');
var session = require('express-session');
var nodemailer=require('nodemailer');
var generator = require('generate-password');
var config = require('./config');

var pool = mysql.createConnection({
    user: 'root',
    host: 'localhost',
    database: 'blog_app',
    port: '3306',
    password: process.env.DATABASE_PASSWORD
});

var transporter = nodemailer.createTransport({
  service: process.env.EMAIL_SERVICE,
  auth: {
    user: process.env.EMAIL_AUTH_USER,
    pass: process.env.EMAIL_AUTH_PASS
  }
});

var app = express();
app.use(morgan('combined'));
app.use(bodyParser.json());
app.use(session({
    secret: 'SomeRandomSecretValue',
    cookie: { maxAge: 1000*60*60*24*30 }
}));

var dir = {
	'dir-settings': {
		heading: 'Settings',
		content: `
		<center>
			<div>		
				<h4>Update credentials</h4>
			<div>
				<form>
				<input type="password" placeholder="Password" id="password"/>
				<br><br>
				<input value="Update Credentials" type="submit" id="updateCred_btn"/>
				</form>
			</div>
			</div>
		</center>
			<script src="/ui/update_cred.js"></script>
		`
	},
	'dir-forgot_password': {
		heading: '',
		content: `
			<center>
				<div id="login_area">
					<h3>Forgot Password</h3>
					<hr>
				<div>
					<br>
					<p>Forgot your password? Don't worry, type your username in and we'll send a new password to the Email associated with the account. Then you can login with the new password.</p>
					<form>
					<input type="text" id="username" placeholder="Username"/>
					<br><br>
					<input value="Submit" type="submit" id="resetPwd_btn"/>
					</form>
				</div>
				</div>
			</center>
			<script src='/ui/reset_pwd.js'></script>
		`
	},
  'dir-Sign-Up': {
    heading: '',
    content: `
<center>
    <div id="login_area">
        <h3>Sign Up</h3>
    <div>
        <form>
        <input type="text" id="username" placeholder="Username"/>
		<br><br>
        <input type="password" placeholder="Password" id="password"/>
        <br><br>
		<input type="email" placeholder="username@host.com" id="email"/>
        <br><br>
        <input value="Sign Up" type="submit" id="register_btn"/>
		</form>
    </div>
    </div>
</center>
    <script src="/ui/register.js"></script>
    <script src="ui/common.js"></script>

    `
    },
  'dir-Login': {
    heading:'',
    content:`
<center>
    <div id="login_area">
        <h3>Login</h3>
    <div>
		<form>
        <input type="text" id="username" placeholder="Username"/>
        <br><br>
		<input type="password" placeholder="Password" id="password"/>
		<br><br>
        <input value="Login" type="submit" id="login_btn"/>
		</form>
		<br>
		<a id="forgotPwd" href="/dir-forgot_password">Forgot password?</a>
    </div>
    </div>
</center>
    <script src="/ui/login.js"></script>
    <script src="ui/common.js"></script>
    `
  },
  'dir-Home': {
    heading:'Home',
    content:'Home'
  },
  'dir-About-Me': {
    heading:'About Me',
    content:'About-Me'
      
  },
  'dir-Web-Programs': {
    heading:'Programs',
    content:`
        <div id="programs"><center> Loading Programs... </center></div>
        <script src="/ui/get-articles.js"></script>
        <script src="/ui/comments.js"></script>
    `
  },
  'dir-Learn': {
    heading:'Learn',
    content:'Learn'
  },
  'dir-Help': {
    heading:'Help',
    content:'help'
  }
};

function createTemplate(data) {
var heading= data.heading;
var title= "Blog-Lightnin | " + heading;
var content= data.content;
var titleBar=
`
<html>
    <head>
		<link rel="icon" href="/ui/favicon.ico" type="image/png" /> 
        <title>${title}</title>
        <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
        <link href="/ui/style.css" rel="stylesheet"/>
        


    </head>
    <body>
    <body id='body'>
      <DIV id="titlebar">
        <br>
        <a href="/dir-Home"><img id="logo" src="/ui/LOGO.png" alt="Logo"></a>
        <div class="dropdown">
          <a href="/dir-Home"><button class="dropbtn" id="Home">Home</button></a>
          <a href="/dir-About-Me"><button class="dropbtn" id="About">About Me</button></a>
          <a href="/dir-Web-Programs"><button class="dropbtn" id="Programs">Web Programs</button></a>
          <a href="/dir-Learn"><button class="dropbtn" id="Learn">Learn</button></a>
          <a href="/dir-Help"><button class="dropbtn" id="Help">Help</button></a>
          <div id="login_buttons">
          <a href="/dir-Sign-Up"><button class="dropbtn specialB" id="SignUpB"">Sign Up</button></a>
          <a href="/dir-Login"><button class="dropbtn specialB" id="LoginB">Login</button></a>
          </div>
        <!--<p id="name">Janak Shah- <span id="username">LightninTh5426@EpicThunder</span></p>-->

      </DIV>

      <br><br>
`;
var body=`
<div class="container">
  <h3>
      <div id="heading">
        <center>${heading}<center>
        </div>
  </h3>
  <div id="content">
      ${content}
  </div>
  </div>
  </body>
    <script src="/ui/check-login.js"></script>
	
	<script>console.log(document.getElementById('body'));</script>
</html>
`;
var HTMLtemplate=titleBar+body;
return HTMLtemplate;
}

function createProgramTemplate(data) {
var heading= data.heading;
var link=data.link;
var type=data.type;
var date= data.date;
var title= "Blog-Lightnin | " + heading;
var content= data.content;
var titleBar=`
<html>
    <head>
        <title>${title}</title>
        <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
        
        <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
        <link href="/ui/style.css" rel="stylesheet"/>
    </head>
    <body>
      <DIV id="titlebar">
        <br>
        <a href="/dir-Home"><img id="logo" src="/ui/LOGO.png" alt="Logo"></a>
        <div class="dropdown">
          <a href="/dir-Home"><button class="dropbtn" id="Home">Home</button></a>
          <a href="/dir-About-Me"><button class="dropbtn" id="About">About Me</button></a>
          <a href="/dir-Web-Programs"><button class="dropbtn" id="Programs">Web Programs</button></a>
          <a href="/dir-Learn"><button class="dropbtn" id="Learn">Learn</button></a>
          <a href="/dir-Help"><button class="dropbtn" id="Help">Help</button></a>
          <div id="login_buttons">
          <a href="/dir-Sign-Up"><button class="dropbtn specialB" id="SignUpB"">Sign Up</button></a>
          <a href="/dir-Login"><button class="dropbtn specialB" id="LoginB">Login</button></a>
          </div>
        <!--<p id="name">Janak Shah- <span id="username">LightninTh5426@EpicThunder</span></p>-->

      </DIV>

      <br><br>
`;
var body=`
   <div class="gotProgram">
    <div class="ProgramHead">
        <a target="_blank href="/ui/Programs/${type}/Calculator/${link}">${heading}</a>
        <p><b>${date.toDateString()}</b></p>
    </div>
    <p>${content}</p>
    <div class="comment_area">
        <br><hr>
       <div style="text-align: center;"><a href="/dir-Web-Programs/Comment/Program-one">Comment</a></div>
        <hr>
    </div>
    </div>
    <br>
    <br>
    <script src="/ui/check-login.js"></script
	<script>console.log(document.getElementById('body'));</script>
</html>
`;
var HTMLtemplate=titleBar+body;
return HTMLtemplate;
}

app.get('/', function (req, res) {
res.sendFile(path.join(__dirname, 'ui', 'index.html'));
});

function hash (input, salt) {
    var hashed = crypto.pbkdf2Sync(input, salt, 10000, 512, 'sha512');
    return ["pbkdf2", "10000", salt, hashed.toString('hex')].join('$');
}

app.get('/hash/:input', function(req,res) {
    var hashedString=hash(req.params.input, 'random-string');
    res.send(hashedString);
});

app.post('/create-user', function(req, res) {
	if(req.body.username==='' || req.body.password==='' || req.body.email==='') {
		res.status(500).send(err.toString());
	}
    var salt = crypto.randomBytes(128).toString('hex');
    var dbString=hash(req.body.password, salt);
    pool.query("INSERT INTO `user`(`username`,`password`,`email`) VALUES ('"+req.body.username+"','"+dbString+"', '"+req.body.email+"')", function(err, field, result) {
        if(err) {
            res.status(500).send(err.toString());
        }
        else {
            res.send('User successfully created' + req.body.username);
        }
    });
});

app.post('/login', function(req, res) {
    pool.query("SELECT * FROM `user` WHERE `username` = '"+req.body.username+"' ", function(err, result, field) {
        if(err) {
            res.status(500).send(err.toString());
        } else {
            if(result.length === 0) {
                res.status(400).send('Username/Password is invalid');
            }
            else{
				var password=req.body.password;
                 var dbString = result[0].password;
                 var salt = dbString.split('$')[2];
                 var hashedPassword = hash(password, salt);
                 if(hashedPassword === dbString) {
                     req.session.auth = {userId: result[0].username};
                     res.send('Credentials correct');
                   } else{
                     res.status(403).send('Username/Password is invalid');
                   }
                 }
        }

    });
});

app.post('/send-password_email', function(req, res) {
	pool.query("SELECT * FROM `user` WHERE `username` = '"+req.body.username+"' ", function(err, result, field) {
		if(err) {
			res.status(500).send(err.toString());
        } 
		else {
            if(result.length === 0) {
                res.status(400).send('Username is invalid');
            }
            else{
				var email=result[0].email;
				var dbString = result[0].password;
				var salt = dbString.split('$')[2];
				var password = generator.generate({
					length: 10,
					numbers: true
				});
				var hashedPassword=hash(password, salt);
				var mailOptions = {
				  from: process.env.EMAIL_AUTH_USER,
				  to: email.toString(),
				  subject: 'Your password',
				  text: "This is your new password for your account: '"+password+"' "
				};

				transporter.sendMail(mailOptions, function(error, info){
				  if (error) {
					console.log(error);
				  } else {
					console.log('Email sent: ' + info.response);
				  }
				});
				
				pool.query("UPDATE `user` SET password = '"+hashedPassword+"' WHERE username = '"+req.body.username+"'", function(err, result, field) {
					if(err) {
						res.send(err);
					} else {
						res.send(result);
					}
				});
				
				
			}
		}
									 
	});
});

app.post('/credentials_update', function(req, res) {
	pool.query("SELECT * FROM `user` WHERE `username` = '"+req.session.auth.userId+"' ", function(err, result, field) {
		if(err) {
			res.status(500).send(err.toString());
        } 
		else {
            if(result.length === 0) {
                res.status(400).send('Username is invalid');
            }
            else{
				var dbString = result[0].password;
				var salt = dbString.split('$')[2];
				var hashedPassword = hash(req.body.password, salt);
				pool.query("UPDATE `user` SET `password` = ? WHERE `username` = ?",[hashedPassword,req.session.auth.userId], function(err, result, field) {
					if(err) {
						res.send(err);
					} else {
						res.send(result);
					}
				});
			}
		}
	});
});

app.post('/check-login', function (req, res) {
   if (req.session && req.session.auth && req.session.auth.userId) {
       pool.query("SELECT * FROM `user` WHERE `username`='"+req.session.auth.userId+"'", function(err, result, field) {
		  if (err) {
			  res.send(err);
		  }  else {
			  var cred=[result[0].username, result[0].password, result[0].email];
			  res.send(cred);
		  }
	   });
   } else {
       res.status(400).send('You are not logged in.');
   }
});

app.get('/check-login', function (req, res) {
   if (req.session && req.session.auth && req.session.auth.userId) {
       pool.query("SELECT * FROM `user` WHERE `username`='"+req.session.auth.userId+"'", function(err, result, field) {
		  if (err) {
			  res.send(err);
		  }  else {
			  var cred=[result[0].username, result[0].password, result[0].email];
			  res.send(cred);
		  }
	   });
   } else {
       res.status(400).send('You are not logged in.');
   }
});

app.get('/logout', function(req, res) {
    delete req.session.auth;
    res.send('You have logged out.<br><a href="/">Home</a>');
});

app.get('/delete-account', function(req,res) {
    console.log(req.session.auth.userId);
    pool.query('DELETE FROM `user` WHERE `username` = ?', [req.session.auth.userId], function (err, fields, result) {
    if (err) {
        res.send('Error');
    } else{
    delete req.session.auth;
    res.send(`Your account has been deleted and you have logged out.<br><a href="/">Home</a>`);
	}
	});
});

//var pool = new Pool(config);
app.get('/get-programs', function(req,res) {
  pool.query("SELECT * FROM `programs` ORDER BY `date`", function (err, result, fields) {
    if(err) {
      res.send('Error');
    }
    res.send(result);
  });
});

app.get("/get-progComments", function(req,res) {
pool.query("SELECT * FROM `progComments` ORDER BY `date`", function (err, result, fields) {
    if(err) {
      res.send('error');
    }
    res.send(result);
  });
});

app.get("/get-progComments/:programName", function(req,res) {
pool.query("SELECT * FROM `progComments` WHERE `programs_tag` = ?",[req.params.programName], function (err, result, fields) {
    if(err) {
      res.send('error');
    }
    res.send(result);
  });
});

app.post('/submit-progComment/:programName', function (req, res) {
   // Check if the user is logged in
    if (req.session && req.session.auth && req.session.auth.userId) {
        // First check if the article exists and get the article-id
        pool.query('SELECT * from programs where tag = ?', [req.params.programName], function (err, result) {
            if (err) {
                res.status(500).send(err.toString());
            } else {
                if (result.length === 0) {
                    res.status(400).send('Program not found');
                } else {
					console.log(result);
                    var programTag = result[0].tag;
                    // Now insert the right comment for this article
                    pool.query("INSERT INTO progComments (programs_tag, user_username, comment) VALUES (?, ?, ?)", [programTag, req.session.auth.userId, req.body.comment], function (err, result) {
                            if (err) {
                                res.status(500).send(err.toString());
                            } else {
                                res.status(200).send('Comment inserted!')
                            }
                        });
                }
            }
       });     
    } else {
        res.status(403).send('Only logged in users can comment');
    }
});

app.get('/:dirName',function (req, res) {
  var dirName = req.params.dirName;
  res.send(createTemplate(dir[dirName]));
});

app.get('/test-db', function(req,res) {
  pool.query("SELECT * FROM `programs`", function (err, result, fields) {
    if(err) {
      res.send('error');
    }
    res.send(result);
  });
});


app.get('/programs/:programName', function (req, res) {
  // SELECT * FROM article WHERE title = '\'; DELETE WHERE a = \'asdf'
  pool.query("SELECT * FROM programs WHERE tag = ?", req.params.programName, function (err, result) {
    if (err) {
        res.status(500).send(err.toString());
    } else {
        if (result.length === 0) {
            res.status(404).send('Program not found');
        } else {
            var programData = result[0];
            res.send(createProgramTemplate(programData));
        }
    }
  });
});



app.get('/ui/:fileName', function (req, res) {
  res.sendFile(path.join(__dirname, 'ui', req.params.fileName));
});

app.get('/ui/Programs/:fileName', function (req, res) {
  res.sendFile(path.join(__dirname, 'ui/Programs', req.params.fileName));
});
app.get('/ui/Programs/Math/:fileName', function (req, res) {
  res.sendFile(path.join(__dirname, 'ui/Programs/Math/Calculator/', req.params.fileName));
});

pool.connect(function(err, result) {
  if (err) {
      console.log('Error in connecting to MySQL Database.');
            console.log(result);
  } else{
  console.log("Connected!");
      console.log(result);
  }
});


var server = app.listen(3000, function () {

  var host = server.address().address;
  var port = server.address().port;

  console.log('App listening at http://localhost:%s', port);

});