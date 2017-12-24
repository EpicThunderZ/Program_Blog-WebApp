function loadPrograms() {
    "use strict";
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === XMLHttpRequest.DONE) {
            var programs = document.getElementById('programs');
            if (request.status === 200) {
                var content = ` `;
                var programData = JSON.parse(this.responseText);
                for (var i=0; i< programData.length; i++) {
                    content += `
                    <div class="gotProgram">
                    <div class="ProgramHead">
                        <a target="_blank" href="/ui/Programs/${programData[i].type}/${programData[i].link}">${programData[i].heading}</a>
                        <p><b>${programData[i].date.split('T')[0]}</b></p>
                    </div>
                    <p>${programData[i].content}</p>
                    <div class="comment_area">
                        <br><hr>
                        <div style="text-align:center;">
                        <div class="ShowCom">
							<button class="ShowComBox" onclick="openComBox('${((programData[i].tag))}');">Comment</button>
                            <button id="${(programData[i].tag)}_ShowCom" onclick="showCom('${((programData[i].tag))}');">Show All Comments</button>
                        </div>
                        </div>
                    <hr>
                    </div>
                    <div id="comments_${((programData[i].tag))}"></div>
                    </div>
					
                    <br>
                    <br>
                    `;
                }
   /* <HR>

                        <div class="commentBoxPar" id="${programData[i].tag}_CommentBoxPar">
                            <TEXTAREA id="${programData[i].tag}_commentBox" style="overflow:auto; width: 70%; height: 100%; max-width: 70%; max-height: 100%; min-width: 70%; min-height: 100%;" class="commentBox"> </TEXTAREA>
                        </div>

                        <div class="commentDiv" id="${programData[i].tag}_CommentDiv">
                        <div class="commentB" id="${programData[i].tag}_CommentB"><button>Comment</button></div>
                        <div class="ShowCom" id="${programData[i].tag}_ShowCom"><button>Show All Comments</button></div>
                        </div>
                        </div>*/    
                console.log(content);
                programs.innerHTML = content;
            } else {
                programs.innerHTML='Oops! Could not load all articles!';
            }
        }
    };
    
    request.open('GET', '/get-programs', true);
    request.send(null);
}                      

loadPrograms();
