CREATE TABLE cd.member (
  memid SERIAL PRIMARY KEY, 
  surname VARCHAR(200), 
  firstname VARCHAR(200), 
  address VARCHAR(300), 
  zipcode INT, 
  telephone VARCHAR(20), 
  recommemdedby INT REFERENCES cd.member(memid), 
  joindate TIMESTAMP
);
CREATE TABLE cd.booking (
  bookid SERIAL PRIMARY KEY, 
  facid INT REFERENCES cd.facilities(facid), 
  memid INT REFERENCES cd.member(memid), 
  starttime TIMESTAMP, 
  slots INT
);
CREATE TABLE cd.facilities (
  facid SERIAL PRIMARY KEY, 
  name VARCHAR(200), 
  membercost NUMERIC, 
  guestcost NUMERIC, 
  initialoutlay NUMERIC, 
  monthlymaintenance NUMERIC
);
insert into cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
values 
  (9, 'Spa', 20, 30, 100000, 800);
INSERT INTO cd.facilities (
  facid, name, membercost, guestcost, 
  initialoutlay, monthlymaintenance
) 
select 
  (
    select 
      max(facid) 
    from 
      cd.facilities
  )+ 1, 
  'Spa', 
  20, 
  30, 
  100000, 
  800 
UPDATE 
  cd.facilities 
set 
  initialoutlay = 10000 
where 
  facid = 1 
UPDATE 
  cd.facilities 
set 
  membercost = (
    select 
      membercost * 1.1 
    from 
      cd.facilities 
    where 
      facid = 0
  ), 
  guestcost = (
    select 
      guestcost * 1.1 
    from 
      cd.facilities 
    where 
      facid = 0
  ) 
where 
  facid = 1 
Delete FROM 
  cd.bookings 
delete from 
  cd.members 
where 
  memid = 37;
select 
  facid, 
  name, 
  membercost, 
  monthlymaintenance 
from 
  cd.facilities 
where 
  membercost <= monthlymaintenance * 0.02 
  and membercost > 0 
select 
  * 
from 
  cd.facilities 
where 
  name like '%Tennis%';
select 
  * 
from 
  cd.facilities 
where 
  facid in (1, 5) 
select 
  memid, 
  surname, 
  firstname, 
  joindate 
from 
  cd.members 
where 
  joindate > '2012-09-01' 
select 
  surname 
from 
  cd.members 
union 
select 
  name 
from 
  cd.facilities 
select 
  starttime 
from 
  cd.bookings bookings 
  LEFT JOIN cd.members members on bookings.memid = members.memid 
where 
  members.surname = 'Farrell' 
  AND members.firstname = 'David' 
select 
  starttime, 
  name 
from 
  cd.bookings bks 
  inner join cd.facilities fcs on bks.facid = fcs.facid 
where 
  bks.starttime >= '2012-09-21' 
  and bks.starttime < '2012-09-22' 
  and fcs.name like 'Tennis%' 
order by 
  bks.starttime 
select 
  members.firstname as memfname, 
  members.surname as memsname, 
  refe.firstname as recfnam, 
  refe.surname as recsname 
from 
  cd.members members 
  left join cd.members refe on members.recommendedby = refe.memid 
order by 
  memsname, 
  memfname 
select 
  distinct refe.firstname as recfnam, 
  refe.surname as recsname 
from 
  cd.members members 
  inner join cd.members refe on members.recommendedby = refe.memid 
order by 
  recsname, 
  recfnam 
select 
  distinct mems.firstname || ' ' || mems.surname as member, 
  (
    select 
      recs.firstname || ' ' || recs.surname as recommender 
    from 
      cd.members recs 
    where 
      recs.memid = mems.recommendedby
  ) 
from 
  cd.members mems 
order by 
  member;
select 
  recommendedby, 
  count(*) 
from 
  cd.members 
where 
  recommendedby is not null 
group by 
  recommendedby 
order by 
  recommendedby;
select 
  facid, 
  sum(slots) as "Total Slots" 
from 
  cd.bookings 
group by 
  facid 
order by 
  facid;
select 
  facid, 
  sum(slots) as "Total Slots" 
from 
  cd.bookings 
where 
  starttime >= '2012-09-01' 
  and starttime < '2012-10-01' 
group by 
  facid 
order by 
  sum(slots);
select 
  count(distinct memid) 
from 
  cd.bookings 
select 
  mems.surname, 
  mems.firstname, 
  mems.memid, 
  min(bks.starttime) as starttime 
from 
  cd.bookings bks 
  inner join cd.members mems on mems.memid = bks.memid 
where 
  starttime >= '2012-09-01' 
group by 
  mems.surname, 
  mems.firstname, 
  mems.memid 
order by 
  mems.memid;
select 
  (
    select 
      count(*) 
    from 
      cd.members
  ), 
  firstname, 
  surname 
from 
  cd.members 
order by 
  joindate 
select 
  row_number() over(
    order by 
      joindate
  ), 
  firstname, 
  surname 
from 
  cd.members 
order by 
  joindate 
select 
  facid, 
  total 
from 
  (
    select 
      facid, 
      sum(slots) total, 
      rank() over (
        order by 
          sum(slots) desc
      ) rank 
    from 
      cd.bookings 
    group by 
      facid
  ) as ranked 
where 
  rank = 1 
select 
  surname || ', ' || firstname as name 
from 
  cd.members 
select 
  memid, 
  telephone 
from 
  cd.members 
where 
  telephone similar to '%[()]%';
select 
  substr (mems.surname, 1, 1) as letter, 
  count(*) as count 
from 
  cd.members mems 
group by 
  letter 
order by 
  letter

