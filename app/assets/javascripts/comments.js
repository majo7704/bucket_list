let Comments = {};

Comments.displayComment = function (comment) {
  let commentTime = document.createElement('time');
  commentTime.setAttribute('datetime', comment.datetime);
  commentTime.appendChild(document.createTextNode(comment.when));

  let commentHeader = document.createElement('h3');
  commentHeader.className = 'comment__title';
  commentHeader.appendChild(document.createTextNode(comment.commenter));
  commentHeader.appendChild(commentTime);

  let commentParagraph = document.createElement('p');
  commentParagraph.appendChild(document.createTextNode(comment.body));

  let commentBody = document.createElement('div');
  commentBody.className = 'comment__body';
  commentBody.appendChild(commentHeader);
  commentBody.appendChild(commentParagraph);

  let avatar = document.createElement('img');
  avatar.className = 'avatar';
  avatar.setAttribute('src', '#images/avatar.png');

  let commentListItem = document.createElement('li');
  commentListItem.className = 'comment';
  commentListItem.appendChild(avatar);
  commentListItem.appendChild(commentBody);

  let comments = document.getElementById('commentList');
  comments.insertBefore(commentListItem, comments.firstChild);
};
