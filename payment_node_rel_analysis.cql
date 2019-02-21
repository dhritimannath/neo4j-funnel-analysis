// Total number of successful payments
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN count(distinct(r))

// Total number of successful payments based on gender and device
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN u.gender as gender , u.device as device , count(u) as total ORDER BY count(u) DESC
