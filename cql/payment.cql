// Total number of successfull payments
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN count(distinct(r))

// Total number of successful payments based on gender and device
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN u.gender as gender , u.device as device , count(u) as total ORDER BY count(u) DESC

// Total number of successful payments based on gender | device
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN u.gender as gender , count(u) as total ORDER BY count(u) DESC


// Total number of successful payments based on location
MATCH (u:User)-[r:VISITED]->(e:Entry { page : 'payment_confirmation_page'})
    RETURN r.state as state, r.country as country, count(u) as total ORDER BY count(u) DESC
