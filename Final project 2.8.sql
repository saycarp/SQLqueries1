/*********************************** PART 1 ***********************************************/
/* TASK 1: Before a band releases a new record, Drop Table Records will work to promote the band
and get fans excited for the new record.

We need a query that shows which artists have upcoming album releases, with those who
have the nearest album release date listed first. Copy the text of your query below.*/ 

select a.albumname as 'album name', 
		a.releasedate as 'release date', 
        b.bandname as 'band name'
from album a
join band b on a.idband = b.idband
order by releasedate desc;

/* TASK 2 Drop Table Records also sends bands to play at different venues or events.
Some venues request bands that feature certain instruments. 

Can you write a query that displays the names of all bands that feature a drummer? Copy the text of your query
below.*/

select b.idband AS 'Band ID',
		b.bandname as 'Band Name',
        p.pfname as 'First Name',
        p.plname as 'Last Name',
        i.instrument as 'Instrument'
from player p
	join instrument i on p.instID = i.instID
	join band b on b.idband = p.idband
where instrument = 'drums';

/* TASK 3: It is important that Drop Table Records has a diversity of different bands signed to its label.
We want many artists who represent different styles of music.

One way we determine the diversity in music is by looking at how many bands feature a
certain instrument. We need a query that displays the number of bands that feature a
certain instrument. */

select instrument.instrument as 'instrument',
		count(distinct band.bandname) as 'Number of bands'
from band, player, instrument
where band.idband=player.idband and player.InstID = instrument.InstID
Group by instrument.instrument;

/*********************************** PART 2 ***********************************************/

/*TASK 1: Our first task is to add the new bands to the correct table. The bands to be added are:
Weezer
TLC
Paramore
Blackpink
Vampire Weekend*/

insert into band values ('22','1', 'Weezer');
insert into band values ('23','1', 'TLC');
insert into band values ('24','1', 'Paramore');
insert into band values ('25','1', 'Blackpink');
insert into band values ('26','1', 'Vampire Weekend');

select * from band; 


insert into player values ('30','3', '22', 'Rivers', 'Cuomo', 'Rochester', 'NY');
insert into player values ('31','1', '22', 'Brian', 'Bell', 'Iowa City', 'IA');
insert into player values ('32','4', '22', 'Patrick', 'Wilson', 'Buffalo', 'NY');
insert into player values ('33','2', '22', 'Scott', 'Shriner', 'Toledo', 'OH');
insert into player values ('34','3', '23', 'Tionne', 'Watkins', 'Des Moines', 'IA');
insert into player values ('35','3', '23', 'Rozonda', 'Thomas', 'Columbus', 'GA');
insert into player values ('36','3', '24', 'Hayley', 'Williams', 'Franklin', 'TN');
insert into player values ('37','1', '24', 'Taylor', 'York', 'Nashville', 'TN');
insert into player values ('38','4', '24', 'Zac', 'Farro', 'Voorhees Township', 'NJ');
insert into player values ('39','3', '25', 'Jisoo', 'Kim', null, 'South Korea');
insert into player values ('40','3', '25', 'Jennie', 'Kim', null, 'South Korea');
insert into player values ('41','3', '25', 'Roseanne', 'Park', null, 'New Zealand');
insert into player values ('42','3', '25', 'Lisa', 'Manoban', null, 'Thailand');
insert into player values ('43','3', '26', 'Ezra', 'Koenig', 'New York', 'NY');
insert into player values ('44','2', '26', 'Chris', 'Baio', 'Bronxville', 'NY');
insert into player values ('45','4', '26', 'Chris', 'Tomson', 'Upper Freehold Township', 'NJ');

select * from player;

/*TASK 2: Drop Table Records has signed a contract with a new venue! Our artists will have the
opportunity to perform at the new venue before anyone else!
Can you please add the following venue to the database? */

insert into venue values ('12','Twin City Rock House', 'Minneapolis', 'MN', '55414', '2000');

select * from venue; 


/*********************************** PART 3 ***********************************************/

/*TASK 1: We are preparing for the upcoming music festival at the Twin City Rock House. We need to
choose which bands will be performing. Most of the bands have already been selected, but
we want to give you some input, too.
Select three bands from our band table to perform at the music festival. The festival will
take place the first Saturday of next month and will have 2,000 attendees.
Each band will need the gig added to the gig table. Copy the text of your query below.*/

select * from gig;

insert into gig values ('1','12', '1', '2022-04-03', '2000');
insert into gig values ('2','12', '25', '2022-04-03', '2000');
insert into gig values ('3','12', '3', '2022-04-03', '2000');


select * from gig;

/* TASK 2: Preparing for the upcoming festival has made us realize that we need a way to quickly view
which bands have upcoming gigs.
Create a view that displays the following information ordered by gig date:
● Band ID
● Band name
● Gig venue
● Gig date
● Number of attendees*/

Select * from gig;

select gig.idband as 'Band ID', 
		band.bandname as 'Band name', 
        venue.vname as 'Gig Venue', 
        gig.gigdate as 'Gig date', 
        gig.numattendees as 'Number of Attendees'
from gig, band, venue
where band.idband = gig.idband and gig.idvenue = venue.idvenue
order by gig.gigdate;

-- or

select gig.idband as 'Band ID', 
		band.bandname as 'Band name', 
        venue.vname as 'Gig Venue', 
        gig.gigdate as 'Gig date', 
        gig.numattendees as 'Number of Attendees'
from gig
	inner join band on gig.idband = band.idband 
	inner join venue on gig.idvenue = venue.idvenue
order by gig.gigdate;

/* TASK 3: When a musician performs in their hometown, we end up selling more merchandise.
Concert attendees love to support local musicians.
We would like a view that shows us the location of our venues and the hometowns of our
signed artists. Not all our artists are from the United States. If the city column is NULL for
an artist, we can display their state as “international” instead.
The information we need in this view:
● Band ID
● Band name
● Player first name
● Player last name
● Home city
● Home state
● Gig date
● Venue name
● Venue city
● Venue state */


select * from player;

select band.idband as 'Band ID', 
		band.bandname as 'Band name', 
        player.pfname as 'Player first name',
        player.plname as 'player last name',
        player.homecity as 'Home city',
			case
				when homecity is null then 'international'
				else homestate
			end as 'Home State',
		gig.gigdate as 'Gig date',
        venue.vname as 'Venue name', 
        venue.city as 'Venue city',
        venue.state as 'Venue state'
from gig, band, venue, player
where band.idband = gig.idband and gig.idvenue = venue.idvenue and band.idband = player.idband;

select * from gig;

/*********************************** PART 4 ***********************************************/
/* Task 1: We loved the view you created for us! However, it sometimes displays too much
information to be useful.
Can you create a stored procedure that allows us to specify a US state and then displays all
players who are from that state?
The information we want to see:
● Band name 
● Player first name
● Player last name
● Home state */

select band.bandname as 'Band name', 
		player.pfname as 'Player first name',
        player.plname as 'player last name',
        player.homestate as 'Home state'
from band, player
where band.idband = player.idband
having player.homestate = 'CA';

/* Task 2: You have heard the saying “the show must go on.” We do everything we can to avoid
canceling a gig. However, life happens, and sometimes a player has a family emergency or
a bad cold.
When a player cannot perform, the first thing we do is try to find another musician to take
their place for the night.
We need a stored procedure that allows us to specify which instrument we need filled and
displays all players who play that instrument and are not already scheduled for gigs that
night. */

select player.pfname as 'Player first name',
        player.plname as 'Player last name',
		instrument.instrument as 'Instrument'
from player, instrument
where player.InstID = instrument.InstID
having instrument.instrument = 'vocals';


/* Task 3: To thank you for all your hard work, we are letting you choose the music group that will
perform at the end of our festival.
We are willing to pay any amount to get your favorite artist to perform. However, to do so,
we will need you to add their information to our database.
Add your favorite artist to our band table and player table. Do not forget to add the gig,
too! */
select * from gig;

insert into band values ('27','1', 'Phoebe Bridgers');
insert into player value ('46','3', '27', 'Phoebe', 'Bridgers', 'Los Angeles', 'CA');
insert into gig value ('4', '12', '27', '2022-04-03', '2000');

select * from band;
select * from player;
select * from gig;