SELECT DATE_TRUNC('month', creation_date) AS date, count(*) AS count FROM factcontact GROUP BY DATE_TRUNC('month', creation_date) ORDER BY date;
