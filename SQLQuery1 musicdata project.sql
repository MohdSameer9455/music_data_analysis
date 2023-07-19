create database music_data;
use music_data
select * from albums;

--who is the senior most employee basedon the job title.
select top(1) title,levels from employee
order by levels desc;

--which countries has the most invoices.
select top(1) billing_country,COUNT(billing_country)as highestinvoice from invoice
group by billing_country
order by highestinvoice desc;

--what are top 3 values of total invoices
select top(3) * from invoice
order by total desc;

--which city has the best customers? we would like to throw a music festival in the city we made the most money write a query that has one city with higest sum of total invoices
--return both the city name and the invoice total
select top(1) billing_city,sum(total)as invoice_total from invoice
group by billing_city
order by invoice_total desc;

-- who is the best customer? the best customer who had spent the most money write a query that returns the best customer.
select TOP(1) c.customer_id,c.first_name,c.last_name,SUM(i.total)as total_spend
from customer c
join invoice i on i.customer_id=c.customer_id
group by c.customer_id,c.first_name,c.last_name
order by total_spend desc;

--Write query to return the first name last name email and genre o all rock music listner ordered alphabetically email starting with a?
select c.email,c.first_name,c.last_name 
from customer c
join invoice i on i.customer_id=c.customer_id
join [invoice line] il on il.invoice_id=i.invoice_id
where track_id in(select track_id from track t
join genre g on g.genre_id=t.genre_id
where g.name='rock')
order by email;

--write a query that returns the artist name and total track count of the top 10 rock brands
select top(10) a.name,a.artist_id,COUNT(a.artist_id) as noofsongs
from artist a
join albums ab on ab.artist_id=a.artist_id
join track t on t.album_id=ab.album_id
join genre g on g.genre_id=t.genre_id
where g.name='rock'
group by a.artist_id,a.name
order by noofsongs desc;

-- return all the track names that have song length longer than the avg song length return the name and ms for each track
--order by the song length in desc
select name,milliseconds  from track
where milliseconds>(select AVG(milliseconds)average_song_length from track)
order by milliseconds desc;

