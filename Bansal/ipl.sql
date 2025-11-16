create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from [dbo].[icc_world_cup]

select team_1, count(team_1) cnt_match , sum(tm1_cnt) as win_cnt, count(team_1)-sum(tm1_cnt) tot_loss from (
select team_1, case when team_1 = winner then 1 else 0 end tm1_cnt  from [dbo].[icc_world_cup]
union all
select team_2, case when team_2 = winner then 1 else 0 end tm1_cnt from [dbo].[icc_world_cup]) er group by team_1


