--Q1

select userid
from userbase
minus
select userid
from orders;

--Q2

select productcode
from productlist
minus
select productcode
from reviews;

--Q3

select  u.*,
case 
when months_between(sysdate, u.birthday) / 12 >= 18
then 'adult'
else 'minor'
end as age_group
from    userbase u;

--Q4

select  p.*,
case 
when p.price <= 20 then 'on sale'
else 'base price'
end as price_status
from    productlist p;

--Q5

select userid
from   userlibrary
where  productcode = 'GAME6'
intersect
select userid
from   userprofile;

--Q6

select productcode
from   wishlist
where  position in (1, 2)
intersect
select productcode
from   reviews
where  rating >= 3;

--Q7

select  u1.username as user1_username,
u1.birthday as user1_birthday,
u2.username as user2_username,
u2.birthday as user2_birthday
from    userbase u1
join    userbase u2
on  u1.birthday = u2.birthday
and u1.userid < u2.userid;

--Q8

select *
from   userlibrary ul
cross  join wishlist w;

--Q9

select 'user' as source_type,
to_char(userid) as id,
username as name
from   userbase
union all
select 'product' as source_type,
productcode as id,
productname as name
from   productlist;

--Q10

select senderid as userid,
datesent as activity_date,
'chat' as activity_type,
content as activity_detail
from   chatlog
union all
select userid as userid,
null as activity_date,
'profile' as activity_type,
description as activity_detail
from   userprofile;

--Q11

select username
from   userbase
where  userid in (
select userid
from   userbase
minus
select userid
from   infractions
);

--Q12

select title,
description
from   communityrules
where  rulenum in (
select rulenum
from   communityrules
minus
select rulenum
from   infractions
);

--Q13

select distinct u.username,
u.email
from   userbase u
join   infractions i
on     u.userid = i.userid
where  i.penalty is not null;

--Q14

select dateassigned as activity_date
from   infractions
intersect
select datesubmitted
from   usersupport;

--Q15

select c.title,
i.penalty
from   communityrules c
join   infractions i
on     c.rulenum = i.rulenum;

--Q16

select c.*,
case
when c.severitypoint >= 10 then 'bannable'
else 'appealable'
end as rule_status
from   communityrules c;

--Q17

select u.*,
case
when lower(u.status) <> 'closed'
and u.dateupdated < (trunc(sysdate) - 7)
then 'high priority'
else 'standard'
end as priority_status
from   usersupport u;

--Q18

select *
from   usersupport us
cross  join infractions i;

--Q19

select u1.ticketid  as ticketid_1,
u2.ticketid  as ticketid_2,
u1.dateupdated
from   usersupport u1
join   usersupport u2
on  u1.dateupdated = u2.dateupdated
and  u1.ticketid < u2.ticketid
where  lower(u1.status) = 'closed'
and  lower(u2.status) = 'closed';

--Q20

select userid,
birthday      as activity_date,
'user record' as activity_type,
null          as detail
from   userbase
union all
select userid,
dateassigned  as activity_date,
'infraction'  as activity_type,
penalty       as detail
from   infractions;


