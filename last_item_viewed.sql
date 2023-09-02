-- creating a sub table of the least item viewd by each user

SELECT user_id,
       users.email_address,
       items.id,
       items.name,
       items.category
FROM
    ( SELECT user_id,
             item_id,
             event_time,
             RANK() OVER (PARTITION BY user_id
                                ORDER BY event_time DESC) AS view_number
   FROM view_item_events
   WHERE event_time > '2023-01-01' ) recent_views
JOIN users
  ON user_id = recent_views.user_id
JOIN items
  ON items.id = recent_views.item_id
WHERE view_number = 1;