-- Task 2

use vk_full

select CONCAT((select first_name from users where users.id = from_user_id), ' ', 
              (select last_name from users where users.id = from_user_id)) AS name
from messages 
where is_delivered = 1 and to_user_id = 3 and from_user_id IN (
		SELECT to_user_id FROM friend_requests WHERE from_user_id = 3 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
			UNION
		SELECT from_user_id FROM friend_requests WHERE to_user_id = 3 AND request_type = 
				(SELECT id FROM friend_requests_types WHERE name = 'accepted')
	)
group by from_user_id 
order by count(is_delivered)
limit 1; 

-- Task 3

select count(*) as sum_likes
from posts_likes
where post_id in (select id from posts where user_id in (
	select * from 
		(select user_id from profiles order by (TIMESTAMPDIFF(YEAR, birthday, NOW())) limit 10) as young_man));


-- Task 4
	
select sum(like_type) as male_likes, (select sum(like_type) from posts_likes where user_id in (select user_id from profiles where gender = 'f')) as female_likes
from posts_likes
where user_id in (select user_id from profiles where gender = 'm');

--  Task 5

select id, 
	   CONCAT(first_name , ' ', last_name) AS name, 
       ((select count(*) from friend_requests where friend_requests.from_user_id = id) +
       (select count(*) from posts_likes where posts_likes.user_id = id) +
       (select count(*) from messages where messages.from_user_id = users.id)) as summ
from users
order by summ
limit 1;

/*select from_user_id, count(*) as num
from friend_requests 
group by from_user_id;

select user_id, count(*) as num_likes
from posts_likes 
group by user_id;

select from_user_id, count(*) as num
from messages 
group by from_user_id;*/


