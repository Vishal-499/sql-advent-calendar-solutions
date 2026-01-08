-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH Calculate_table as (SELECT user_name,DATE(sent_at) as sent_at,COUNT(message_id) as messg_count FROM npn_users u 
  JOIN npn_messages m ON m.sender_id = u.user_id GROUP BY user_name, sent_at),final_table as (
  SELECT * , DENSE_RANK() OVER(PARtition BY sent_at ORDER BY messg_count DESC) rnk FROM Calculate_table)
  SELECT * FROM final_table WHERE rnk = 1;
