create or replace view "public"."all_gifts" as  SELECT gifts.id,
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



