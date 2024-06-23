drop view if exists "public"."gifts_visible";

drop view if exists "public"."all_gifts";

alter table "public"."gifts" add column "description" text;

alter table "public"."gifts" add column "title" text;

create or replace view "public"."all_translations" as  SELECT gifts.id,
    gifts.price,
    gifts.parts,
    gifts.image,
    gift_translations.title,
    gift_translations.description,
    gift_translations.language,
    sum(transactions.amount) AS amount_gifted,
    gifts.hidden
   FROM ((gifts
     LEFT JOIN gift_translations ON ((gifts.id = gift_translations.gift)))
     LEFT JOIN transactions ON ((gifts.id = transactions.gift)))
  GROUP BY gifts.id, gifts.price, gifts.parts, gifts.image, gift_translations.title, gift_translations.description, gift_translations.language;


create or replace view "public"."all_gifts" as  SELECT gifts.id,
    gifts.price,
    gifts.parts,
    gifts.image,
    gifts.title,
    gifts.description,
    sum(transactions.amount) AS amount_gifted,
    gifts.hidden
   FROM (gifts
     LEFT JOIN transactions ON ((gifts.id = transactions.gift)))
  GROUP BY gifts.id, gifts.price, gifts.parts, gifts.image, gifts.title, gifts.description;



