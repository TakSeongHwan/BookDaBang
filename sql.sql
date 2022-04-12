use gootac6;

alter table event_board
add foreign key(writer) references member(userId);

alter table event_Reply
add foreign key(replywriter) references member(userId);

alter table event_Reply
add foreign key(boardno) references event_board(boardno);

-- 전체 출력
select * from event_board;
select * from event_board order by date desc;

-- 베스트 게시글 불러오기
select * from event_board where boardno = 1;
select * from freeboard where likecount > 5 order by date desc;

-- 게시글 추가
insert into event_board(title, eventStart, eventEnd, content, mainImg) 
values ("테스트1", "2021-11-15", "2022-05-10", "테스트용 데이터입니다", null);

-- 게시글 삭제
delete from event_board where boardno = 14;

-- 게시글 수정
update event_board
set title = "수정된 이벤트", eventStart = "2022-04-08", eventEnd = "2022-04-13" 
where boardno =1;


-- 테이블 전체 데이터 날리기
set FOREIGN_KEY_CHECKS = 0;
TRUNCATE event_board;
set FOREIGN_KEY_CHECKS = 1;