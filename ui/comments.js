function showCom(tag) {
    "use strict";
    console.log(tag.toString());
        // Check if the user is already logged in
    
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            var comments = document.getElementById('comments_'+tag);
            console.log(comments);
            if (request.status === 200) {
                var content = ``;
                var commentsData = JSON.parse(this.responseText);
                for (var i=0; i< commentsData.length; i++) {
                    content += `
					<div class="comments">
                        <div class="comment"><p>${commentsData[i].comment}</p></div>
						
                        <div class="commenter">
                        	<hr>
							<div class="commenterDetail">${commentsData[i].user_username}</div> 
							<div class="commentTime"> - ${(commentsData[i].date)} </div>
                        </div>
						
                    </div><br><br>`;
                }
				content+=`<hr>`;
                console.log(content);
                comments.innerHTML = content;
            } else {
                comments.innerHTML('Oops! Could not load comments!');
            }
        }
    };
    
    request.open('GET', '/get-progComments/' + tag, true);
    request.send(null);
}

function openComBox(tag) {
	var comments = document.getElementById('comments_'+tag);
	comments.innerHTML=`
                        <div class="commentBoxPar" id="${tag}_CommentBoxPar">
                            <TEXTAREA id="${tag}_commentBox" style="overflow:auto; width: 70%; height: 10%; max-width: 70%; max-height: 20%; min-width: 70%; min-height: 20%;" class="commentBox"> </TEXTAREA>
                        </div>

                        <div class="commentDiv" id="${tag}_CommentDiv">
							<div class="commentB" id="${tag}_CommentB">					
								<button id="${tag}_commentB" onclick="commentF('${tag}');">Comment</button>
							</div>
						</div>
						<hr>
			`
}

function commentF(tag) {
  var request = new XMLHttpRequest();
		var commentB=document.getElementById(tag+'_commentB');
        
        // Capture the response and store it in a variable
        request.onreadystatechange = function () {
          if (request.readyState === XMLHttpRequest.DONE) {
                // Take some action
                if (request.status === 200) {
                    // clear the form & reload all the comments
                    document.getElementById(tag+'_commentBox').value = '';
                    showCom(tag);    
                } else if(request.status===403) {
                    alert('You are not logged in.');
                } else if(request.status===500) {
					alert('Your comment is too long. Please make it smaller, less than 600 characters.');
				} else{
					alert('Oops!... Something went wrong on the server!')
				}
                commentB.value = 'Comment';
          }
        };
        
        // Make the request
        var comment = document.getElementById(tag+'_commentBox').value;
        request.open('POST', '/submit-progComment/' + tag, true);
        request.setRequestHeader('Content-Type', 'application/json');
        request.send(JSON.stringify({comment: comment}));  
        commentB.value = 'Submitting...';
}
