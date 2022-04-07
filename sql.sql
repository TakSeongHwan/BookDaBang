use gootac6;

alter table event_board
add foreign key(writer) references member(userId);

alter table event_Reply
add foreign key(replywriter) references member(userId);

alter table event_Reply
add foreign key(boardno) references event_board(boardno);
