drop table item_sell_wishlist;
drop table item_buy_wishlist;
drop table item_buy;
drop table item_sell;
drop table transaction_history;
drop table items;
drop table id_tracker;
drop table messages;
drop table login_data;


create table id_tracker(
	current_id varchar(10) not null
);

insert into id_tracker values('1');

create table login_data(
	id varchar(20),
	username varchar(20),
	password varchar(20),
	email varchar(30),
	primary key (id)
);

create table items(
	id varchar(20) references login_data(id) on delete cascade,
	item_id serial primary key ,
	name varchar(100) not null,
	description varchar(1000) not null,
	category varchar(100) not null,
	is_biddable char(1) not null,
	bidding_price numeric(8,2) default 0,
	check(is_biddable in ('n', 'y'))
);

create table item_sell(
	id varchar(20) references login_data(id) on delete cascade,
	item_id int references items(item_id) on delete cascade,
	quantity integer not null,
	price numeric(8,2) not null,
	time_ timestamp not null,
	primary key (item_id),
	check(quantity >= 0),
	check(price > 0.00)
);

create table item_sell_wishlist (
	item_id int references item_sell(item_id) on delete cascade,
	id varchar(20) references login_data(id) on delete cascade,
	message varchar(1000) not null,
	quantity integer not null 

);

create table item_buy(
	id varchar(20) references login_data(id) on delete cascade,
	item_id int references items(item_id) on delete cascade,
	quantity integer not null,
	price_range varchar(20),
	specifications varchar(1000),
	comments varchar(1000),
	time_ timestamp not null,
	primary key (item_id),
	check(quantity > 0)
);

create table item_buy_wishlist (
	item_id int references item_buy(item_id) on delete cascade,
	id varchar(20) references login_data(id) on delete cascade,
	message varchar(1000) not null 
);

create table transaction_history(
	buyer varchar(20) references login_data(id) on delete cascade,
	seller varchar(20) references login_data(id) on delete cascade,
	item_id int references items(item_id) on delete cascade,
	price numeric(8,2) not null,
	quantity integer not null,
	comments varchar(1000),
	time_ timestamp not null
);

create table messages(
	sender varchar(20) references login_data(id) on delete cascade,
	receiver varchar(20) references login_data(id) on delete cascade,
	text varchar(1000) not null,
	time_ timestamp not null,
	check(sender <> receiver)
);