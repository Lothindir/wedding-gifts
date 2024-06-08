drop policy "Enable insert for authenticated users only" on "public"."transactions";

alter table "public"."donors" alter column "address" set default ''::text;

alter table "public"."donors" alter column "email" set default ''::text;

alter table "public"."gift_translations" alter column "description" set not null;

alter table "public"."gifts" alter column "image" set not null;

alter table "public"."gifts" alter column "parts" set not null;

create or replace view "public"."all_gifts" as  SELECT gifts.id,
    gifts.price,
    gifts.parts,
    gifts.image,
    gift_translations.title,
    gift_translations.description,
    gift_translations.language,
    sum(transactions.amount) AS amount_gifted
   FROM ((gifts
     LEFT JOIN gift_translations ON ((gifts.id = gift_translations.gift)))
     LEFT JOIN transactions ON ((gifts.id = transactions.gift)))
  GROUP BY gifts.id, gifts.price, gifts.parts, gifts.image, gift_translations.title, gift_translations.description, gift_translations.language;


create or replace view "public"."gifts_visible" as  SELECT gifts.id,
    gifts.price,
    gifts.parts,
    gifts.image,
    gift_translations.title,
    gift_translations.description,
    gift_translations.language,
    sum(transactions.amount) AS amount_gifted
   FROM ((gifts
     JOIN gift_translations ON ((gifts.id = gift_translations.gift)))
     LEFT JOIN transactions ON ((gifts.id = transactions.gift)))
  WHERE (gifts.hidden = false)
  GROUP BY gifts.id, gifts.price, gifts.parts, gifts.image, gift_translations.title, gift_translations.description, gift_translations.language;


create policy "TEMP dev permissions"
on "public"."gift_translations"
as permissive
for all
to public
using (true);


create policy "TEMP dev permissions"
on "public"."gifts"
as permissive
for all
to public
using (true);



