= CREATE KEYSPACE football WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

= USE football;

= CREATE TYPE t_won(tournament text, year int, position int);

= CREATE TABLE newplayer(pid int, newplayerid int, name text, age int, country text, clubs list<text>, goals map<text, int>, position text, tournaments_won list<frozen<t_won>>, PRIMARY KEY(pid, newplayerid, name));

= 	DESCRIBE TABLE football.newplayer ;

	CREATE TABLE football.newplayer (			
	    pid int,
	    newplayerid int,
	    name text,
	    age int,
	    clubs list<text>,
	    country text,
	    goals map<text, int>,
	    position text,
	    tournaments_won list<frozen<t_won>>,
	    PRIMARY KEY (pid, newplayerid, name)
	) WITH CLUSTERING ORDER BY (newplayerid ASC, name ASC)
	    AND bloom_filter_fp_chance = 0.01
	    AND caching = '{"keys":"ALL", "rows_per_partition":"NONE"}'
	    AND comment = ''
	    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy'}
	    AND compression = {'sstable_compression': 'org.apache.cassandra.io.compress.LZ4Compressor'}
	    AND dclocal_read_repair_chance = 0.1
	    AND default_time_to_live = 0
	    AND gc_grace_seconds = 864000
	    AND max_index_interval = 2048
	    AND memtable_flush_period_in_ms = 0
	    AND min_index_interval = 128
	    AND read_repair_chance = 0.0
	    AND speculative_retry = '99.0PERCENTILE';
	 
=  INSERT INTO newplayer (pid , newplayerid , name , age , country, goals , tournaments_won , position ) VALUES ( 1, 7, 'Messi', 28, 'ARG', {'Total Goals' : 27}, [{tournament :'EPL', year: 2012, position:2}, {tournament :'EPL', year: 2014, position:4}, {tournament :'BCPL', year: 2014, position:1}], 'Center Forward');

= UPDATE newplayer SET clubs = clubs + ['Barcelona', 'MI'] WHERE pid = 1 and newplayerid = 1 and name = 'Messi';

= DELETE from newplayer WHERE pid = 1 and newplayerid = 1 and name ='Messi';

= UPDATE newplayer SET tournaments_won = [{tournament: 'EPL', year: 2012, position: 2}, {tournament: 'EPL', year: 2014, position: 4}] WHERE pid = 1 and newplayerid = 7 and name = 'Messi';

= BEGIN BATCH 
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 35, 'Ronaldohino', 21, 'BRZ', ['Barcelona', 'MI'], {'Total Goals' : 21}, [{tournament :'EPL', year: 2014, position:1}, {tournament :'La Liga', year: 2015, position:2}], 'Center Mid');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 222, 'Gayle', 28, 'BRZ', ['Barcelona', 'RPS'], {'Total Goals' : 27}, [{tournament :'EPL', year: 2014, position:1}, {tournament :'La Liga', year: 2015, position:2}],'Center Forward');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 45, 'Bravo', 26, 'BRZ', ['Barcelona', 'RPS'], {'Total Goals' : 16}, [{tournament :'EPL', year: 2014, position:1}, {tournament :'La Liga', year: 2015, position:2}],'Defender');
            ... APPLY BATCH;


= BEGIN BATCH 
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 30, 'Rooney', 28, 'ENG', ['ManU', 'KKR'], {'Total Goals' : 48}, [{tournament :'APL', year: 2012, position:1}, {tournament :'Bundesliga', year: 2015, position:1}], 'Defender');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 31, 'Beckham', 33, 'ENG', ['ManU', 'KKR'], {'Total Goals' : 56}, [{tournament :'APL', year: 2012, position:1}, {tournament :'Bundesliga', year: 2015, position:1}], 'Defender');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 32, 'Henry', 25, 'FRA', ['ManU', 'RCB'], {'Total Goals' : 70}, [{tournament :'APL', year: 2012, position:1}, {tournament :'Bundesliga', year: 2015, position:1}], 'Mid Field');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 1, 33, 'Zidane', 37, 'FRA', ['ManU', 'RCB'], {'Total Goals' : 101}, [{tournament :'APL', year: 2012, position:1}, {tournament :'Bundesliga', year: 2015, position:1}], 'Striker');
            ... APPLY BATCH;


= BEGIN BATCH 
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 65, 'Smith', 28, 'AUS', ['Chelsea', 'RCB'], {'Total Goals' : 47}, [{tournament :'EPL', year: 2014, position:3}, {tournament :'La Liga', year: 2015, position:1}],'Center Forward');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 99, 'Oram', 21, 'ARG', ['Chelsea', 'RCB'], {'Total Goals' : 67}, [{tournament :'EPL', year: 2014, position:3}, {tournament :'La Liga', year: 2015, position:1}],'Mid Field');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 48, 'McCullum', 23, 'ARG', ['Chelsea', 'KXIP'], {'Season Goals' : 8}, [{tournament :'EPL', year: 2014, position:3}, {tournament :'La Liga', year: 2015, position:1}],'Defender');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 95, 'Williamson', 24, 'ARG', ['Chelsea', 'KXIP'], {'Season Goals' : 17}, [{tournament :'EPL', year: 2014, position:3}, {tournament :'La Liga', year: 2015, position:1}],'Striker');
            ... APPLY BATCH;

= BEGIN BATCH 
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 81, 'Guptil', 25, 'NZ', ['Liverpool', 'KXIP'], {'Season Goals' : 21}, [{tournament :'EPL', year: 2014, position:2}, {tournament :'La Liga', year: 2015, position:3}],'Center Forward');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 81, 'Guptil', 25, 'NZ', ['Liverpool', 'KXIP'], {'Season Goals' : 21}, [{tournament :'EPL', year: 2014, position:2}, {tournament :'La Liga', year: 2015, position:3}],'Center Forward');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 47, 'Starc', 28, 'AUS', ['Liverpool', 'MI'], {'Total Goals' : 72}, [{tournament :'EPL', year: 2014, position:2}, {tournament :'La Liga', year: 2015, position:3}],'Center Forward');
            ... INSERT INTO newplayer (pid , newplayerid , name , age , country, clubs , goals , tournaments_won , position ) VALUES ( 2, 99, 'ABD', 30, 'SA', ['Liverpool', 'MI'], {'Total Goals' : 90}, [{tournament :'EPL', year: 2014, position:2}, {tournament :'La Liga', year: 2015, position:3}],'Mid Field');
            ... APPLY BATCH;



=   CREATE FUNCTION countrycompletion(age int) CALLED ON NULL INPUT RETURNS text LANGUAGE java AS 'if(age<=20) { String s = "PROMISING PLAYER"; return s;} if(age<=30) { String s = "PERFORMER PLAYER"; return s;} if(age<=40) { String s = "EXPERIENCED PLAYER"; return s;} if(age>40) { String s = "LEGEND PLAYER"; return s;} else { String s = "RETIRED"; return s;}' ;

= EXPAND ON

= create index clubs_index on newplayer (clubs) ;
= CREATE INDEX goals ON newplayer (goals);


= SELECT * FROM newplayer;

= SELECT * FROM newplayer WHERE pid = 1;
= SELECT * FROM newplayer WHERE pid = 2;

= select newplayerid, name FROM newplayer where pid = 1;
= select newplayerid, name FROM newplayer where pid = 2;

= select count(*) FROM newplayer where pid = 1;
= select count(*) FROM newplayer where pid = 2;

= select min(age) FROM newplayer where pid = 1;
= select min(age) FROM newplayer where pid = 2;

= select max(age) FROM newplayer where pid = 1;
= select max(age) FROM newplayer where pid = 2;

= select avg(age) FROM newplayer where pid = 1;
= select avg(age) FROM newplayer where pid = 2;

= select name, country, clubs, ageanalyser(age) as Age_Analysis FROM newplayer WHERE pid = 1;
= select name, country, clubs, ageanalyser(age) as Age_Analysis FROM newplayer WHERE pid = 2; 

= SELECT count(*), avg(age) as Manchester_United_average_age FROM newplayer WHERE clubs CONTAINS 'ManU';
= SELECT count(*), avg(age) as Manchester_United_average_age FROM newplayer WHERE clubs CONTAINS 'Liverpool';

= SELECT name,age, country, ageanalyser(age) as Player_class FROM newplayer WHERE clubs CONTAINS 'Chelsea';
= SELECT name,age, country, ageanalyser(age) as Player_class FROM newplayer WHERE clubs CONTAINS 'Barcelona';

= SELECT name, goals FROM newplayer;





