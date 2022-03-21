SELECT DATE_TRUNC('month', creation) AS date, count(*) AS count FROM factquotes GROUP BY DATE_TRUNC('month', creation) ORDER BY date;
